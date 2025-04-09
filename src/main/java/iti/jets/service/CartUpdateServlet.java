package iti.jets.service;

import java.io.IOException;
import java.io.PrintWriter;

import com.google.gson.JsonObject;

import iti.jets.dao.impl.CartRepoImpl;
import iti.jets.entity.Cart;
import jakarta.persistence.EntityManager;
import jakarta.persistence.Persistence;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/updateCart")
public class CartUpdateServlet extends HttpServlet {
    
    private CartRepoImpl cartRepo;
    private EntityManager entityManager;
    
    @Override
    public void init() throws ServletException {
        entityManager = Persistence.createEntityManagerFactory("jpa-mysql").createEntityManager();
        cartRepo = new CartRepoImpl(entityManager);
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        response.setContentType("application/json");
        PrintWriter out = response.getWriter();
        JsonObject jsonResponse = new JsonObject();
        
        try {
            // Get parameters from request
            int userId = Integer.parseInt(request.getParameter("userId"));
            int productId = Integer.parseInt(request.getParameter("productId"));
            String action = request.getParameter("action");
            
            // Find the cart item
            Cart cartItem = cartRepo.getCartByUserAndProduct(userId, productId);
            
            if (cartItem == null) {
                jsonResponse.addProperty("success", false);
                jsonResponse.addProperty("message", "Cart item not found");
                out.print(jsonResponse);
                return;
            }
            
            int currentQuantity = cartItem.getQuantity();
            int newQuantity = currentQuantity;
            
            // Update quantity based on action
            if ("increase".equals(action)) {
                newQuantity = currentQuantity + 1;
            } else if ("decrease".equals(action)) {
                // Only decrease if quantity is greater than 1
                if (currentQuantity > 1) {
                    newQuantity = currentQuantity - 1;
                } else {
                    // Keep at 1, don't decrease further
                    newQuantity = 1;
                }
            } else if ("set".equals(action)) {
                int requestedQuantity = Integer.parseInt(request.getParameter("quantity"));
                // Ensure quantity is at least 1
                if (requestedQuantity >= 1) {
                    newQuantity = requestedQuantity;
                } else {
                    newQuantity = 1; // Force minimum quantity of 1
                }
            }
            
            // Update if quantity changed
            if (newQuantity != currentQuantity) {
                cartItem.setQuantity(newQuantity);
                cartRepo.update(cartItem);
            }
            
            // Always calculate and return updated totals regardless of whether quantity changed
            int itemTotal = cartItem.getProduct().getPrice() * newQuantity;
            
            // Get updated cart total
            int cartTotal = 0;
            for (Cart cart : cartRepo.getCartItemsByUserId(userId)) {
                cartTotal += cart.getProduct().getPrice() * cart.getQuantity();
            }
            
            // Return success response with updated values
            jsonResponse.addProperty("success", true);
            jsonResponse.addProperty("quantity", newQuantity);
            jsonResponse.addProperty("itemTotal", itemTotal);
            jsonResponse.addProperty("cartTotal", cartTotal);
            
            if (newQuantity == currentQuantity) {
                jsonResponse.addProperty("message", "No change in quantity");
            }
            
        } catch (Exception e) {
            jsonResponse.addProperty("success", false);
            jsonResponse.addProperty("message", "Error: " + e.getMessage());
            e.printStackTrace();
        }
        
        out.print(jsonResponse);
    }
    
    @Override
    public void destroy() {
        if (entityManager != null && entityManager.isOpen()) {
            entityManager.close();
        }
    }
}