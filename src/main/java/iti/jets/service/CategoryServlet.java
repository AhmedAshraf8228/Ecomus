package iti.jets.service;

import com.google.gson.Gson;
import iti.jets.dao.impl.GenericRepoImpl;
import iti.jets.entity.Category;
import iti.jets.entity.Order;
import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityManagerFactory;
import jakarta.persistence.Persistence;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;

@WebServlet("/api/category")
public class CategoryServlet extends HttpServlet {
    private EntityManagerFactory factory = Persistence.createEntityManagerFactory("jpa-mysql");

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        resp.setContentType("application/json");
        resp.setCharacterEncoding("UTF-8");

        EntityManager session = factory.createEntityManager();
        GenericRepoImpl<Category, Integer> repo = new GenericRepoImpl<>(session, Category.class);

        try {
            List<Category> cats = repo.findAll();

            Gson gson = new Gson();
            resp.getWriter().write(gson.toJson(cats));

        } catch (Exception e) {
            resp.getWriter().write("{\"error\": \"An error occurred in Category Servlet\"}");
            e.printStackTrace();
        }finally {
            session.close();
        }
    }

    @Override
    public void destroy() {
        if (factory.isOpen()) {
            factory.close();
        }
    }
}
