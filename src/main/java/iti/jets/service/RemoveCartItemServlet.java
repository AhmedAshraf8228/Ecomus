package iti.jets.service;

import iti.jets.dao.impl.CartRepoImpl;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.*;

@WebServlet("/removeCartItem")
public class RemoveCartItemServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("application/json;charset=UTF-8");
        PrintWriter out = response.getWriter();
        CartRepoImpl cartRepo = new CartRepoImpl();
        try {

            HttpSession session = request.getSession(false);
            if (session == null || session.getAttribute("login") == null || !(Boolean) session.getAttribute("login")) {
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
            if (cartRepo.getEntityManager() != null && cartRepo.getEntityManager().isOpen()) {
                cartRepo.getEntityManager().close();
            }
        }
    }

}