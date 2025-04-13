package iti.jets.service;

import java.io.IOException;
import java.util.List;

import iti.jets.dao.impl.OrderRepoImpl;
import iti.jets.entity.Order;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/my-orders")
public class OrdersServlet extends HttpServlet {
    
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession(false);
    
        Boolean isLoggedIn = (Boolean) session.getAttribute("login");
        Integer userId = (Integer) session.getAttribute("id");
        
        if (isLoggedIn == null || !isLoggedIn || userId == null) {
            resp.sendRedirect("login.jsp");
            return;
        }
        
        OrderRepoImpl orderRepo = null;
        try {
        
            orderRepo = new OrderRepoImpl();
            List<Order> userOrders = orderRepo.getOrdersByUserId(userId);
            req.setAttribute("userOrders", userOrders);

            req.getRequestDispatcher("my-account-orders.jsp").forward(req, resp);
        } catch (Exception e) {
            e.printStackTrace();
            resp.sendRedirect("error.jsp");
        } finally {
            if (orderRepo != null && orderRepo.getEntityManager() != null && orderRepo.getEntityManager().isOpen()) {
                orderRepo.getEntityManager().close();
            }
        }
    }
}