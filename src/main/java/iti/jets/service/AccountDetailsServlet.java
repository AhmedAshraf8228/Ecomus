package iti.jets.service;

import java.io.IOException;

import iti.jets.dao.impl.UserRepoImpl;
import iti.jets.entity.User;
import jakarta.persistence.EntityManager;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/accountDetails")
public class AccountDetailsServlet extends HttpServlet {
    
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession(false);
        
        if (session != null && session.getAttribute("login") != null && (boolean) session.getAttribute("login")) {
            int userId = (int) session.getAttribute("id");
            
            UserRepoImpl userRepo = new UserRepoImpl();
            
            try {
                User user = userRepo.findById(userId);
                
                if (user != null) {
                    req.setAttribute("user", user);
                    req.getRequestDispatcher("/my-account.jsp").forward(req, resp);
                } else {
                    resp.getWriter().write("User not found");
                }
            } catch (Exception e) {
                e.printStackTrace();
                resp.getWriter().write("Error fetching profile data: " + e.getMessage());
            } finally {
                if (userRepo.getEntityManager().isOpen()) {
                    userRepo.getEntityManager().close();
                }
            }
        } else {
            resp.sendRedirect("login.jsp");
        }
    }
}