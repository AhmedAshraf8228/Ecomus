package iti.jets.service;

import com.google.gson.Gson;
import iti.jets.dao.impl.UserRepoImpl;
import iti.jets.entity.User;
import jakarta.persistence.EntityManager;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import org.hibernate.Hibernate;

import java.io.IOException;
import java.util.List;

@WebServlet("/admin/users")
public class UserServlet extends HttpServlet {


    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        UserRepoImpl userRepo = new UserRepoImpl();
        try {
            List<User> users = userRepo.findAll();

            for (User user : users) {
                user.getUserId();
                user.getUserName();
                user.getEmail();
                user.getPhone();
                user.getCity();
                user.getArea();
                user.getStreet();

                Hibernate.initialize(user.getUserId());
            }

            Gson gson = new Gson();
            String json = gson.toJson(users);

            response.getWriter().write(json);
        } catch (Exception e) {
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            response.getWriter().write("{\"error\": \"An error occurred\"}");
            e.printStackTrace();
        } finally {
            if (userRepo.getEntityManager() != null && userRepo.getEntityManager().isOpen()) {
                userRepo.getEntityManager().close();
            }
        }
    }

    protected void doDelete(HttpServletRequest request, HttpServletResponse response) throws IOException {
        int userId = Integer.parseInt(request.getParameter("userId"));

        UserRepoImpl userRepo = new UserRepoImpl();
        EntityManager em = userRepo.getEntityManager();
        try {
            em.getTransaction().begin();
            userRepo.deleteById(userId);
            em.getTransaction().commit();
            response.setStatus(200);
        } catch (Exception e) {
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            response.getWriter().write("{\"error\": \"An error occurred\"}");
            e.printStackTrace();
        } finally {
            if (em != null && em.isOpen()) {
                em.close();
            }
        }

    }

}
