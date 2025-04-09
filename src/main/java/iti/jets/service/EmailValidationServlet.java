package iti.jets.service;

import iti.jets.dao.impl.UserRepoImpl;
import jakarta.persistence.*;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;

@WebServlet("/validate-email")
public class EmailValidationServlet extends HttpServlet {


    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        EntityManager entityManager = UserRepoImpl.getEntityManagerFactory().createEntityManager();
        String email = request.getParameter("email");
        try {
            // Query to check if email exists in the database
            Long count = UserRepoImpl.checkValidEmail(entityManager, email);
            response.setContentType("text/plain");
            if (count > 0) {
                response.getWriter().write("invalid");  // Email exists
            } else {
                response.getWriter().write("valid"); // Email doesn't exist
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().write("error");  // Error occurred
        }
    }
}

