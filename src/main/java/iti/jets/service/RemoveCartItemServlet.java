package iti.jets.service;

import java.io.IOException;
import java.io.PrintWriter;

import iti.jets.dao.impl.CartRepoImpl;
import jakarta.persistence.EntityManager;
import jakarta.persistence.Persistence;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/removeCartItem")
public class RemoveCartItemServlet extends HttpServlet {
    
    private CartRepoImpl cartRepo;
    private EntityManager entityManager;
    
    @Override
    public void init() throws ServletException {
        entityManager = Persistence.createEntityManagerFactory("jpa-mysql").createEntityManager();
        cartRepo = new CartRepoImpl(entityManager);
    }
    
    // @Override
    // protected void doPost(HttpServletRequest request, HttpServletResponse response) 
    //         throws ServletException, IOException {
        
    //     response.setContentType("application/json;charset=UTF-8");
    //     PrintWriter out = response.getWriter();
        
    //     try {
    //         // Get product ID from request
    //         int productId = Integer.parseInt(request.getParameter("productId"));
    //         int userId = 1; // Fixed user ID for now
            
    //         // Call the removeCartItem method
    //         boolean removed = cartRepo.deleteByUserIdAndProductId(userId, productId);
            
    //         if (removed) {
    //             // Calculate the new total
    //             int newTotal = cartRepo.calculateCartTotal(userId);
                
    //             // Return success response with new total
    //             out.println("{\"success\": true, \"newTotal\": " + newTotal + "}");
    //         } else {
    //             out.println("{\"success\": false, \"message\": \"Item not found in cart\"}");
    //         }
            
    //     } catch (NumberFormatException e) {
    //         out.println("{\"success\": false, \"message\": \"Invalid product ID\"}");
    //         e.printStackTrace();
    //     } catch (Exception e) {
    //         out.println("{\"success\": false, \"message\": \"" + e.getMessage() + "\"}");
    //         e.printStackTrace();
    //     }
    // }
    
    // @Override
    // public void destroy() {
    //     if (entityManager != null && entityManager.isOpen()) {
    //         entityManager.close();
    //     }
    // }
    @Override
protected void doPost(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {
    
    response.setContentType("application/json;charset=UTF-8");
    PrintWriter out = response.getWriter();
    
    try {
        // Get product ID from request
        int productId = Integer.parseInt(request.getParameter("productId"));
        int userId = 1; // Fixed user ID for now
        
        // Call the removeCartItem method
        boolean removed = cartRepo.deleteByUserIdAndProductId(userId, productId);
        
        // Give time for the database to process
        try {
            Thread.sleep(100);
        } catch (InterruptedException e) {
            Thread.currentThread().interrupt();
        }
        
        // Calculate the new total regardless of removal status
        int newTotal = cartRepo.calculateCartTotal(userId);
        
        // Return success response with new total
        out.println("{\"success\": true, \"newTotal\": " + newTotal + "}");
        
    } catch (NumberFormatException e) {
        out.println("{\"success\": false, \"message\": \"Invalid product ID\"}");
        e.printStackTrace();
    } catch (Exception e) {
        out.println("{\"success\": false, \"message\": \"" + e.getMessage() + "\"}");
        e.printStackTrace();
    } finally {
        out.flush();
        out.close();
    }
}
}