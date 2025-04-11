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

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        response.setContentType("application/json");
        PrintWriter out = response.getWriter();
        JsonObject jsonResponse = new JsonObject();
        CartRepoImpl cartRepo = new CartRepoImpl();
        try {
            int userId = Integer.parseInt(request.getParameter("userId"));
            int productId = Integer.parseInt(request.getParameter("productId"));
            String action = request.getParameter("action");
            Cart cartItem = cartRepo.getCartByUserAndProduct(userId, productId);
            if (cartItem == null) {
                jsonResponse.addProperty("success", false);
                jsonResponse.addProperty("message", "Cart item not found");
                out.print(jsonResponse);
                return;
            }
            
            int currentQuantity = cartItem.getQuantity();
            int newQuantity = currentQuantity;
            
          
            if ("increase".equals(action)) {
                newQuantity = currentQuantity + 1;
            } else if ("decrease".equals(action)) {
       
                if (currentQuantity > 1) {
                    newQuantity = currentQuantity - 1;
                } else {
                 
                    newQuantity = 1;
                }
            } else if ("set".equals(action)) {
                int requestedQuantity = Integer.parseInt(request.getParameter("quantity"));
              
                if (requestedQuantity >= 1) {
                    newQuantity = requestedQuantity;
                } else {
                    newQuantity = 1; 
                }
            }
            
          
            if (newQuantity != currentQuantity) {
                cartItem.setQuantity(newQuantity);
                cartRepo.update(cartItem);
            }
            
        
            int itemTotal = cartItem.getProduct().getPrice() * newQuantity;
            
          
            int cartTotal = 0;
            for (Cart cart : cartRepo.getCartItemsByUserId(userId)) {
                cartTotal += cart.getProduct().getPrice() * cart.getQuantity();
            }
            
         
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
        }finally {
            if (cartRepo.getEntityManager().isOpen()) {
                cartRepo.getEntityManager().close();
            }
        }
        
        out.print(jsonResponse);
    }

}