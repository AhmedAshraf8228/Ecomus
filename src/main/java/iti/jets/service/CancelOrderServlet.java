package iti.jets.service;

import java.io.IOException;
import java.util.List;

import iti.jets.dao.impl.OrderDetailsRepoImpl;
import iti.jets.dao.impl.OrderRepoImpl;
import iti.jets.dao.impl.ProductRepoImpl;
import iti.jets.entity.Order;
import iti.jets.entity.OrderDetails;
import iti.jets.entity.Product;
import iti.jets.enums.OrderStatus;
import jakarta.persistence.EntityManager;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/cancel-order")
public class CancelOrderServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession(false);
        
        // Check if user is logged in
        Boolean isLoggedIn = (Boolean) session.getAttribute("login");
        Integer userId = (Integer) session.getAttribute("id");
        
        if (isLoggedIn == null || !isLoggedIn || userId == null) {
            resp.sendRedirect("login.jsp");
            return;
        }
        
        // Get order ID from request
        String orderIdStr = req.getParameter("orderId");
        if (orderIdStr == null || orderIdStr.trim().isEmpty()) {
            resp.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            return;
        }
        
        int orderId;
        try {
            orderId = Integer.parseInt(orderIdStr);
        } catch (NumberFormatException e) {
            resp.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            return;
        }
        
        OrderRepoImpl orderRepo = null;
        OrderDetailsRepoImpl orderDetailsRepo = null;
        ProductRepoImpl productRepo = null;
        EntityManager em = null;
        
        try {
            orderRepo = new OrderRepoImpl();
            em = orderRepo.getEntityManager();
            Order order = orderRepo.findById(orderId);
            if (order == null || order.getUser().getUserId() != userId) {
                resp.setStatus(HttpServletResponse.SC_FORBIDDEN);
                return;
            }
            if (!OrderStatus.PROCESSING.equals(order.getStatus())) {
                resp.setStatus(HttpServletResponse.SC_BAD_REQUEST);
                return;
            }
            em.getTransaction().begin();
            orderDetailsRepo = new OrderDetailsRepoImpl(em);
            List<OrderDetails> orderDetailsList = orderDetailsRepo.getOrderDetailsByOrderId(orderId);
            productRepo = new ProductRepoImpl(em);
            for (OrderDetails details : orderDetailsList) {
                Product product = details.getProduct();
                if (product != null) {
                    int newQuantity = product.getQuantity() + details.getQuantity();
                    product.setQuantity(newQuantity);
                    productRepo.update(product);
                }
            }
            order.setStatus(OrderStatus.CANCELED);
            
            em.merge(order);
            
            em.getTransaction().commit();
            resp.sendRedirect(req.getContextPath() + "/my-orders");
            
        } catch (Exception e) {
            if (em != null && em.getTransaction().isActive()) {
                em.getTransaction().rollback();
            }
            e.printStackTrace();
            resp.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "An error occurred while canceling the order.");
            
        } finally {
            if (em != null && em.isOpen()) {
                em.close();
            }
        }
    }
}