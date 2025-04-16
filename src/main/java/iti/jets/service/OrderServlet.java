package iti.jets.service;

import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.google.gson.Gson;
import iti.jets.dao.impl.GenericRepoImpl;
import iti.jets.dao.impl.OrderDetailsRepoImpl;
import iti.jets.dao.impl.OrderRepoImpl;
import iti.jets.dao.impl.ProductRepoImpl;
import iti.jets.entity.Order;
import iti.jets.entity.OrderDetails;
import iti.jets.entity.Product;
import iti.jets.enums.OrderStatus;
import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityManagerFactory;
import jakarta.persistence.Persistence;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.BufferedReader;
import java.io.IOException;
import java.util.List;
import java.util.Map;

@WebServlet("/admin/orders")
public class OrderServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        resp.setContentType("application/json");
        resp.setCharacterEncoding("UTF-8");

        GenericRepoImpl<Order, Integer> repo = new GenericRepoImpl<>(Order.class);

        try {
            List<Order> orders = repo.findAll();

            Gson gson = new Gson();
            resp.getWriter().write(gson.toJson(orders));

        } catch (Exception e) {
            resp.getWriter().write("{\"error\": \"An error occurred in Order Servlet\"}");
            e.printStackTrace();
        }finally {
            if (repo.getEntityManager() != null && repo.getEntityManager().isOpen()) {
                repo.getEntityManager().close();
            }
        }
    }


    @Override
    protected void doPut(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        resp.setContentType("application/json");
        resp.setCharacterEncoding("UTF-8");

        BufferedReader reader = req.getReader();
        ObjectMapper objectMapper = new ObjectMapper();
        Map<String, Object> requestData = objectMapper.readValue(reader, new TypeReference<Map<String, Object>>() {});

        int orderId = (int) requestData.get("orderId");
        String newStatus = (String) requestData.get("status");

        EntityManager em = GenericRepoImpl.getEntityManagerFactory().createEntityManager();
        OrderRepoImpl orderRepo = new OrderRepoImpl(em);
        OrderDetailsRepoImpl orderDetailsRepo = new OrderDetailsRepoImpl(em);
        ProductRepoImpl productRepo = new ProductRepoImpl(em);

        try {
            em.getTransaction().begin();

            Order order = orderRepo.findById(orderId);

            if (order == null) {
                resp.setStatus(HttpServletResponse.SC_NOT_FOUND);
                resp.getWriter().write("{\"message\": \"Order not found.\"}");
                return;
            }
            List<OrderDetails> orderDetails = orderDetailsRepo.getOrderDetailsByOrderId(orderId);

            for(OrderDetails od : orderDetails){
                int productId = od.getProduct().getProductId();
                int quantity = od.getQuantity();
                Product product = productRepo.findById(productId);
                if(product==null){
                    resp.setStatus(HttpServletResponse.SC_NOT_FOUND);
                    resp.getWriter().write("{\"message\": \"Product not found.\"}");
                    return;
                }
                if("CANCELED".equalsIgnoreCase(newStatus)){
                    product.setQuantity(product.getQuantity()+quantity);
                }

                productRepo.insert(product);

            }

            if ("COMPLETED".equalsIgnoreCase(newStatus)) {
                order.setStatus(OrderStatus.COMPLETED);
            } else if ("CANCELED".equalsIgnoreCase(newStatus)) {
                order.setStatus(OrderStatus.CANCELED);
            } else {
                resp.setStatus(HttpServletResponse.SC_BAD_REQUEST);
                resp.getWriter().write("{\"message\": \"Invalid status value.\"}");
                return;
            }

            Order updatedOrder = orderRepo.update(order);
            em.getTransaction().commit();
            if (updatedOrder != null) {
                resp.setStatus(HttpServletResponse.SC_OK);
                resp.getWriter().write("{\"message\": \"Order status updated successfully.\"}");
            }
            else {
                resp.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
                resp.getWriter().write("{\"message\": \"Order update failed.\"}");
            }

        }
        catch (Exception e) {
            e.printStackTrace();
            resp.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            resp.getWriter().write("{\"message\": \"Server error while updating order status.\"}");
        }
        finally {
            if (em != null && em.isOpen()) {
                em.close();
            }
        }
    }

}
