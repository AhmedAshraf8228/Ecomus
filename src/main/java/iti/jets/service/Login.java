package iti.jets.service;

import iti.jets.dao.impl.*;
import iti.jets.entity.User;
import jakarta.persistence.EntityManager;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.*;

@WebServlet("/login")
public class Login extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        UserRepoImpl userRepo = new UserRepoImpl();

        String email = req.getParameter("email");
        String password = req.getParameter("password");

        System.out.println(email + " " + password);
        try {
            User user = userRepo.getUserByEmail(email);
            if(user != null){
                boolean flag = PasswordUtils.checkPassword(password, user.getPassword());
                if(flag){
                    HttpSession session = req.getSession(true);
                    session.setAttribute("login", true);
                    session.setAttribute("id", user.getUserId());
                    session.setAttribute("userName", user.getUserName());
                    resp.getWriter().write("valid");
                }else {
                    resp.getWriter().write("invalid");
                }
            }else {
                resp.getWriter().write("invalid");
            }
        }catch (Exception e){
            e.printStackTrace();
            resp.getWriter().write("error");
        }finally {
            if (userRepo.getEntityManager() != null && userRepo.getEntityManager().isOpen()) {
                userRepo.getEntityManager().close();
            }
        }
    }
}
