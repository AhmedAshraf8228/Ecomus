package iti.jets.service;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.google.gson.Gson;

import iti.jets.dao.impl.CartRepoImpl;
import iti.jets.dao.impl.ProductRepoImpl;
import iti.jets.entity.Cart;
import iti.jets.entity.Product;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/checkInventory")
public class CheckInventoryServlet extends HttpServlet {
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        
        if (session == null || session.getAttribute("login") == null ||
                !(Boolean) session.getAttribute("login")) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }
        
        Integer userId = (Integer) session.getAttribute("id");
        if (userId == null) {
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            response.getWriter().write("{\"success\": false, \"error\": \"User ID not found in session\"}");
            return;
        }
        
        CartRepoImpl cartRepo = new CartRepoImpl();
        ProductRepoImpl productRepo = new ProductRepoImpl();
        
        try {
            List<Cart> cartItems = cartRepo.getCartItemsByUserId(userId);
            List<Map<String, Object>> inventoryIssues = new ArrayList<>();
            boolean hasInventoryIssues = false;
            
            for (Cart cartItem : cartItems) {
                Product product = productRepo.findById(cartItem.getProduct().getProductId());
                
                if (product.getQuantity() < cartItem.getQuantity()) {
                    Map<String, Object> issue = new HashMap<>();
                    issue.put("productId", product.getProductId());
                    issue.put("productName", product.getProductName());
                    issue.put("requestedQuantity", cartItem.getQuantity());
                    issue.put("availableQuantity", product.getQuantity());
                    inventoryIssues.add(issue);
                    hasInventoryIssues = true;
                }
            }
            
            Map<String, Object> result = new HashMap<>();
            result.put("success", true);
            result.put("hasInventoryIssues", hasInventoryIssues);
            result.put("inventoryIssues", inventoryIssues);
            
            response.setContentType("application/json");
            response.setCharacterEncoding("UTF-8");
            response.getWriter().write(new Gson().toJson(result));
            
        } catch (Exception e) {
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            response.setContentType("application/json");
            response.setCharacterEncoding("UTF-8");
            response.getWriter().write("{\"success\": false, \"error\": \"Failed to check inventory: " + e.getMessage() + "\"}");
        } finally {
            if (cartRepo != null && cartRepo.getEntityManager() != null && 
                cartRepo.getEntityManager().isOpen()) {
                cartRepo.getEntityManager().close();
            }
            
            if (productRepo != null && productRepo.getEntityManager() != null && 
                productRepo.getEntityManager().isOpen()) {
                productRepo.getEntityManager().close();
            }
        }
    }
}