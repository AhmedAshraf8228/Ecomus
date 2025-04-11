package iti.jets.service;

import java.io.IOException;
import java.sql.Date;

import iti.jets.dao.impl.UserRepoImpl;
import iti.jets.entity.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/updateAccount")
public class UpdateProfileServlet extends HttpServlet {
    
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession(false);
        
        if (session != null && session.getAttribute("login") != null && (boolean) session.getAttribute("login")) {
            int userId = (int) session.getAttribute("id");
            
            String userName = req.getParameter("userName");
            String email = req.getParameter("email");
            String phone = req.getParameter("phone");
            Date BD = Date.valueOf(req.getParameter("BD"));
            String job = req.getParameter("job");
            String city = req.getParameter("city");
            String area = req.getParameter("area");
            String street = req.getParameter("street");
            String buildingNo = req.getParameter("buildingNo");
            String creditNo = req.getParameter("creditNo");
            Integer creditLimit = Integer.valueOf(req.getParameter("creditLimit"));
            
            UserRepoImpl userRepo = new UserRepoImpl();
            
            try {
                User user = userRepo.findById(userId);
                if (user != null) {
                    
                    user.setUserName(userName);
                    user.setEmail(email);
                    user.setPhone(phone);
                    user.setBD(BD);
                    user.setJob(job);
                    user.setCity(city);
                    user.setArea(area);
                    user.setStreet(street);
                    user.setBuildingNo(buildingNo);
                    user.setCreditNo(creditNo);
                    user.setCreditLimit(creditLimit);
                    
                    userRepo.update(user);
                    
                    // Set success message as a request attribute
                    req.setAttribute("message", "Profile updated successfully!");
                    req.setAttribute("messageType", "success");
                    
                    // Fetch the updated user and send to the profile page
                    user = userRepo.findById(userId);
                    req.setAttribute("user", user);
                    
                    // Forward to the profile JSP
                    req.getRequestDispatcher("/my-account-edit.jsp").forward(req, resp);
                } else {
                    req.setAttribute("message", "User not found");
                    req.setAttribute("messageType", "error");
                    req.getRequestDispatcher("/my-account-edit.jsp").forward(req, resp);
                }
            } catch (Exception e) {
                e.printStackTrace();
                req.setAttribute("message", "Error updating profile: " + e.getMessage());
                req.setAttribute("messageType", "error");
                req.getRequestDispatcher("/my-account-edit.jsp").forward(req, resp);
            } finally {
                if (userRepo.getEntityManager() != null && userRepo.getEntityManager().isOpen()) {
                    userRepo.getEntityManager().close();
                }
            }
        } else {
            resp.sendRedirect("login.jsp");
        }
    }
}