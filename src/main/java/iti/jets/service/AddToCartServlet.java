package iti.jets.service;


import iti.jets.dao.impl.CartRepoImpl;
import iti.jets.entity.Cart;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;

@WebServlet("/addtocart")
public class AddToCartServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        response.setContentType("application/json");

        if (session.getAttribute("login") == null || !(Boolean) session.getAttribute("login") ||
                session.getAttribute("id") == null) {
            response.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
            response.getWriter().write("{\"error\":\"You must be logged in to add to cart.\"}");
            return;
        }

        CartRepoImpl cartRepo = new CartRepoImpl();
        try {
            int userId = (int) session.getAttribute("id");
            int productId = Integer.parseInt(request.getParameter("productId"));
            int quantity = Integer.parseInt(request.getParameter("quantity"));

            if (quantity <= 0) {
                response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
                response.getWriter().write("{\"error\":\"Quantity must be greater than zero\"}");
                return;
            }

            Cart sortedCart = cartRepo.getCartByUserAndProduct(userId, productId);
            boolean flag = false;
            if (sortedCart == null) {
                Cart newCart = new Cart();
                newCart.setProductId(productId);
                newCart.setQuantity(quantity);
                newCart.setUserId(userId);
                Cart inserted = cartRepo.insert(newCart);
                if (inserted != null) flag = true;
            } else {
                sortedCart.setQuantity(sortedCart.getQuantity() + quantity);
                cartRepo.update(sortedCart);
                flag = true;
            }
            if (flag) {
                int oldCart = (int) session.getAttribute("cart-size");
                session.setAttribute("cart-size", oldCart + quantity);
                response.setStatus(HttpServletResponse.SC_OK);
                response.getWriter().write("{\"message\":\"Item added to cart\"}");
                System.out.println("Add to cart successfully : user:" + userId + " productId:" + productId + " quantity:" + quantity);
            } else {
                response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
                response.getWriter().write("{\"error\":\"Failed to insert item to cart\"}");
                System.out.println("Add to cart faild : user:" + userId + " productId:" + productId + " quantity:" + quantity);

            }
        } catch (Exception e) {
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            response.getWriter().write("{\"error\":\"An internal error occurred\"}");
            e.printStackTrace();
        } finally {
            if (cartRepo.getEntityManager().isOpen()) {
                cartRepo.getEntityManager().close();
            }
        }

    }
}