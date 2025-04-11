package iti.jets.service;

import java.io.IOException;
import java.util.List;

import iti.jets.dao.impl.CartRepoImpl;
import iti.jets.entity.Cart;
import iti.jets.entity.User;
import jakarta.persistence.EntityManager;
import jakarta.persistence.Persistence;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/cart")
public class CartServlet extends HttpServlet {
    

    
    @Override
protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    HttpSession session = request.getSession(false);
    if (session == null || session.getAttribute("login") == null || !(Boolean)session.getAttribute("login")) {
        response.sendRedirect(request.getContextPath() + "/login.jsp");
        return;
    }

    CartRepoImpl cartRepo = new CartRepoImpl();

        try {
            int userId = (Integer) session.getAttribute("id");
            User user = cartRepo.getEntityManager().find(User.class, userId);
            List<Cart> cartItems = cartRepo.getCartItemsByUserId(userId);
            int total = 0;
            for (Cart cart : cartItems) {
                total += cart.getProduct().getPrice() * cart.getQuantity();
            }

            request.setAttribute("cartItems", cartItems);
            request.setAttribute("total", total);
            request.setAttribute("cartIsEmpty", cartItems.isEmpty());
            RequestDispatcher dispatcher = request.getRequestDispatcher("/view-cart.jsp");
            dispatcher.forward(request, response);
        } catch (Exception e) {
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            response.getWriter().write("{\"error\": \"Failed to add category\"}");
            e.printStackTrace();
        } finally {
            if (cartRepo.getEntityManager().isOpen()) {
                cartRepo.getEntityManager().close();
            }
        }
    }
}