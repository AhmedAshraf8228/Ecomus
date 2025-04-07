package iti.jets.service;

import com.google.gson.Gson;
import iti.jets.dao.impl.GenericRepoImpl;
import iti.jets.dao.impl.UserRepoImpl;
import iti.jets.entity.User;
import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityManagerFactory;
import jakarta.persistence.Persistence;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.hibernate.Hibernate;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

@WebServlet("/admin/users")
public class UserServlet extends HttpServlet {

    private EntityManagerFactory emf = Persistence.createEntityManagerFactory("jpa-mysql");

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

         EntityManager entityManager = emf.createEntityManager();
         GenericRepoImpl<User, Integer> userRepo = new GenericRepoImpl<>(entityManager, User.class);

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
        }finally {
            entityManager.close();
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


    @Override
    public void destroy() {
            if (emf.isOpen()) {
                emf.close();
            }
    }
}
