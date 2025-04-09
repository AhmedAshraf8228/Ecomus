package iti.jets.service;

import java.io.IOException;
import java.util.List;

import org.hibernate.Hibernate;

import com.google.gson.Gson;

import iti.jets.dao.impl.GenericRepoImpl;
import iti.jets.entity.User;
import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityManagerFactory;
import jakarta.persistence.Persistence;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/admin/users")
public class UserServlet extends HttpServlet {

    private EntityManagerFactory emf = Persistence.createEntityManagerFactory("jpa-mysql");
    private EntityManager entityManager = emf.createEntityManager();
    private GenericRepoImpl<User, Integer> userRepo = new GenericRepoImpl<>(entityManager, User.class);

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        try {
            List<User> users = userRepo.findAll();

            // Ensure Lazy Loading doesn't break serialization
            for (User user : users) {
                Hibernate.initialize(user.getUserId());
            }

            Gson gson = new Gson();
            String json = gson.toJson(users);

            response.getWriter().write(json);
        } catch (Exception e) {
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            response.getWriter().write("{\"error\": \"An error occurred\"}");
            e.printStackTrace();
        }
    }

//    protected void doDelete(HttpServletRequest request, HttpServletResponse response) throws IOException {
//        int userId = Integer.parseInt(request.getParameter("userId"));
//
//        EntityManager entityManager = Persistence.createEntityManagerFactory("mindmazePU").createEntityManager();
//        entityManager.getTransaction().begin();
//
//        User user = entityManager.find(User.class, userId);
//        if (user != null) {
//            entityManager.remove(user);
//        }
//
//        entityManager.getTransaction().commit();
//        entityManager.close();
//
//        response.setStatus(200);
//    }



}
