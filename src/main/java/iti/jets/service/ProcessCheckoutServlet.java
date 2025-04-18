
package iti.jets.service;

import java.io.IOException;
import java.util.Date;
import java.util.List;

import iti.jets.dao.impl.CartRepoImpl;
import iti.jets.dao.impl.GenericRepoImpl;
import iti.jets.dao.impl.OrderDetailsRepoImpl;
import iti.jets.dao.impl.OrderRepoImpl;
import iti.jets.dao.impl.ProductRepoImpl;
import iti.jets.dao.impl.UserRepoImpl;
import iti.jets.entity.Cart;
import iti.jets.entity.Order;
import iti.jets.entity.OrderDetails;
import iti.jets.entity.Product;
import iti.jets.entity.User;
import iti.jets.enums.OrderStatus;
import iti.jets.enums.PayType;
import jakarta.persistence.EntityManager;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/processCheckout")
public class ProcessCheckoutServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        
        EntityManager entityManager = GenericRepoImpl.getEntityManagerFactory().createEntityManager();
        CartRepoImpl cartRepo = new CartRepoImpl(entityManager);
        UserRepoImpl userRepo = new UserRepoImpl(entityManager);
        OrderRepoImpl orderRepo = new OrderRepoImpl(entityManager);
        OrderDetailsRepoImpl orderDetailsRepo = new OrderDetailsRepoImpl(entityManager);
        ProductRepoImpl productRepo = new ProductRepoImpl(entityManager);
        
        try {
            entityManager.getTransaction().begin();
            if (session == null || session.getAttribute("login") == null ||
                    !(Boolean) session.getAttribute("login")) {
                response.sendRedirect(request.getContextPath() + "/login.jsp");
                return;
            }

            Integer userId = (Integer) session.getAttribute("id");
            if (userId == null) {
                throw new ServletException("User ID not found in session");
            }
            User user = userRepo.findById(userId);
            if (user == null) {
                throw new ServletException("User not found");
            }

            List<Cart> cartItems = cartRepo.getCartItemsByUserId(userId);
            if (cartItems == null || cartItems.isEmpty()) {
                response.sendRedirect(request.getContextPath() + "/cart");
                return;
            }
            boolean allInventoryAvailable = true;
            StringBuilder inventoryMessage = new StringBuilder();

            for (Cart cartItem : cartItems) {
                Product product = productRepo.findById(cartItem.getProduct().getProductId());

                if (product.getQuantity() < cartItem.getQuantity()) {
                    allInventoryAvailable = false;
                    inventoryMessage.append("Product ").append(product.getProductName())
                        .append(" has only ").append(product.getQuantity())
                        .append(" items available, but ").append(cartItem.getQuantity())
                        .append(" were requested.\n");
                }
            }

            if (!allInventoryAvailable && !"true".equals(request.getParameter("acceptReducedQuantity"))) {
                entityManager.getTransaction().rollback();
                response.setContentType("application/json");
                response.setCharacterEncoding("UTF-8");
                response.getWriter().write("{\"success\": false, \"inventoryIssue\": true, \"message\": \"" + 
                    inventoryMessage.toString().replace("\n", " ") + "\"}");
                return;
            }

            int totalPrice = 0;
      
            for (Cart cartItem : cartItems) {
                Product product = productRepo.findById(cartItem.getProduct().getProductId());
                int finalQuantity = cartItem.getQuantity();
                
                if (product.getQuantity() < cartItem.getQuantity() && "true".equals(request.getParameter("acceptReducedQuantity"))) {
                    finalQuantity = product.getQuantity();
                    cartItem.setQuantity(finalQuantity);
                }
                
                totalPrice += (int) (product.getPrice() * finalQuantity);
            }
            String paymentMethod = request.getParameter("payment");
            ln("Payment method: " + paymentMethod);
            ln("Total price: " + totalPrice);
            
            if ("credit".equals(paymentMethod)) {
                Integer creditLimit = user.getCreditLimit();
                ln("Credit limit: " + creditLimit);
                
                if (creditLimit == null) {
                    entityManager.getTransaction().rollback();
                    response.setContentType("application/json");
                    response.setCharacterEncoding("UTF-8");
                    response.getWriter().write("{\"success\": false, \"creditLimitIssue\": true, \"message\": \"Please update your profile to set your credit card limit.\"}");
                    return;
                }
                if (totalPrice > creditLimit) {
                    entityManager.getTransaction().rollback();
                    response.setContentType("application/json");
                    response.setCharacterEncoding("UTF-8");
                    response.getWriter().write("{\"success\": false, \"creditLimitIssue\": true, \"message\": \"Your order total ($" + totalPrice + ") exceeds your available credit limit ($" + creditLimit + ").\"}");
                    return;
                }
                ln("Deducting from credit limit. Before: " + creditLimit);
                user.setCreditLimit(creditLimit - totalPrice);
                ln("After deduction: " + user.getCreditLimit()); 
            }

            String customerName = request.getParameter("customerName");
            String city = request.getParameter("city");
            String area = request.getParameter("area");
            String street = request.getParameter("street");
            String buildingNum = request.getParameter("buildingNum");
            String phone = request.getParameter("phone");

            String fullAddress = String.format("%s, %s, %s, Building %s", street, area, city, buildingNum);

            Order order = new Order();
            order.setUser(user);
            order.setAddress(fullAddress);
            order.setPrice(totalPrice);
            order.setDate(new Date());
            order.setStatus(OrderStatus.PROCESSING);

            if ("cash".equals(paymentMethod)) {
                order.setPayType(PayType.CASH);
            } else {
                order.setPayType(PayType.CREDIT);
            }
        
            order = orderRepo.insert(order);
            ln("Order saved with ID: " + order.getOrderId());

            for (Cart cartItem : cartItems) {
                try {
                    Product product = productRepo.findById(cartItem.getProduct().getProductId());
                    int finalQuantity;
                    if (product.getQuantity() < cartItem.getQuantity() && "true".equals(request.getParameter("acceptReducedQuantity"))) {
                        finalQuantity = product.getQuantity();
                    } else {
                        finalQuantity = cartItem.getQuantity();
                    }
                    
                    OrderDetails orderDetails = new OrderDetails();
                    orderDetails.setOrder(order);
                    orderDetails.setProduct(cartItem.getProduct());
                    orderDetails.setQuantity(finalQuantity);
                    orderDetails.setPrice((int) cartItem.getProduct().getPrice());
                    
                    ln("Saving order detail for product: " + 
                                      cartItem.getProduct().getProductName() +
                                      " with quantity: " + finalQuantity);
                                      
                    orderDetailsRepo.insert(orderDetails);
                    ln("Order detail saved successfully");
                    product.setQuantity(product.getQuantity() - finalQuantity);
                    productRepo.update(product);
                } catch (Exception e) {
                    System.err.println("Error saving order detail: " + e.getMessage());
                    e.printStackTrace();
                    throw e; 
                }
            }

            // Clear the cart
            for (Cart cartItem : cartItems) {
                cartRepo.deleteByUserIdAndProductId(userId, cartItem.getProduct().getProductId());
            }

            entityManager.getTransaction().commit();
            response.setContentType("application/json");
            response.setCharacterEncoding("UTF-8");
            response.getWriter().write("{\"success\": true, \"message\": \"Order processed successfully\", \"orderId\": " + order.getOrderId() + "}");

        } catch (Exception e) {
            if (entityManager.getTransaction().isActive()) {
                entityManager.getTransaction().rollback();
            }
            System.err.println("Error in ProcessCheckoutServlet: " + e.getMessage());
            e.printStackTrace();

            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            response.setContentType("application/json");
            response.setCharacterEncoding("UTF-8");
            response.getWriter().write("{\"success\": false, \"error\": \"Failed to process order: " + e.getMessage() + "\"}");
        } 
        finally {
            if (entityManager != null && entityManager.isOpen()) {
                entityManager.close();
            }
        }
    }
}
