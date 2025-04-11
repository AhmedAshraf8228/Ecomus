package iti.jets.service;

import com.google.gson.Gson;
import iti.jets.dao.impl.GenericRepoImpl;
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

@WebServlet("/api/orders")
public class OrderServlet extends HttpServlet {


    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        resp.setContentType("application/json");
        resp.setCharacterEncoding("UTF-8");

        GenericRepoImpl<Order, Integer> repo = new GenericRepoImpl<>(Order.class);

        try {
            List<Order> orders = repo.findAll();

            Gson gson = new Gson();
            resp.getWriter().write(gson.toJson(orders));

        } catch (Exception e) {
            resp.getWriter().write("{\"error\": \"An error occurred in Order Servlet\"}");
            e.printStackTrace();
        }finally {
            if (repo.getEntityManager() != null && repo.getEntityManager().isOpen()) {
                repo.getEntityManager().close();
            }
        }
    }
}
