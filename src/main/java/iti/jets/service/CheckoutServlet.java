package iti.jets.service;

import java.io.IOException;
import java.util.List;

import iti.jets.dao.impl.CartRepoImpl;
import iti.jets.dao.impl.UserRepoImpl;
import iti.jets.entity.Cart;
import iti.jets.entity.User; 
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/checkout")
public class CheckoutServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("login") == null ||
                !(Boolean)session.getAttribute("login")) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }
        
        CartRepoImpl cartRepo = new CartRepoImpl();
        UserRepoImpl userRepo = new UserRepoImpl(); 
        
        try {
           
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
        
            double total = 0;
            for (Cart cart : cartItems) {
                if (cart != null && cart.getProduct() != null) {
                    total += cart.getProduct().getPrice() * cart.getQuantity();
                }
            }
            
           
            request.setAttribute("user", user);
            request.setAttribute("cartItems", cartItems);
            request.setAttribute("total", total);
            
       
            RequestDispatcher dispatcher = request.getRequestDispatcher("/checkout.jsp");
            dispatcher.forward(request, response);
            
        } catch (Exception e) {
       
            System.err.println("Error in CheckoutServlet: " + e.getMessage());
            e.printStackTrace();
        
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            response.setContentType("application/json");
            response.getWriter().write("{\"error\": \"Failed to process checkout: " + e.getMessage() + "\"}");
        } 
        finally {
            if (cartRepo != null && cartRepo.getEntityManager() != null && 
                cartRepo.getEntityManager().isOpen()) {
                cartRepo.getEntityManager().close();
            }
     
            if (userRepo != null && userRepo.getEntityManager() != null && 
                userRepo.getEntityManager().isOpen()) {
                userRepo.getEntityManager().close();
            }
        }
    }
}