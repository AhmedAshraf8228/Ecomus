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
import jakarta.servlet.http.HttpSession;

@WebServlet("/removeCartItem")
public class RemoveCartItemServlet extends HttpServlet {
    
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
    
    response.setContentType("application/json;charset=UTF-8");
    PrintWriter out = response.getWriter();

    try {
       
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("login") == null || !(Boolean)session.getAttribute("login")) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        int userId = (Integer) session.getAttribute("id");
        int productId = Integer.parseInt(request.getParameter("productId"));

        boolean removed = cartRepo.deleteByUserIdAndProductId(userId, productId);

        Thread.sleep(100);

        int newTotal = cartRepo.calculateCartTotal(userId);

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