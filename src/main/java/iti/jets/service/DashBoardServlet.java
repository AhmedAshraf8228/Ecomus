package iti.jets.service;

import com.fasterxml.jackson.databind.ObjectMapper;
import iti.jets.dao.impl.CategoryRepoImpl;
import iti.jets.dao.impl.GenericRepoImpl;
import iti.jets.dao.impl.UserRepoImpl;
import iti.jets.entity.Order;
import jakarta.persistence.EntityManager;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

@WebServlet("/admin/dashboard")
public class DashBoardServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse response) throws ServletException, IOException {
        EntityManager em = GenericRepoImpl.getEntityManagerFactory().createEntityManager();
        GenericRepoImpl orderRepo = new GenericRepoImpl(Order.class , em);
        UserRepoImpl userRepo = new UserRepoImpl(em);
        CategoryRepoImpl categoryRepo = new CategoryRepoImpl(em);
        try {
            em.getTransaction().begin();
            int totalOrders = orderRepo.countRows();
            int totalUsers = userRepo.countRows();
            int totalCategories = categoryRepo.countRows();
            em.flush();
            em.getTransaction().commit();

            ObjectMapper objectMapper = new ObjectMapper();

            Map<String, Integer> responseData = new HashMap<>();
            responseData.put("totalOrders", totalOrders);
            responseData.put("totalUsers", totalUsers);
            responseData.put("totalCategories", totalCategories);

            System.out.println(responseData);
            String jsonResponse = objectMapper.writeValueAsString(responseData);

            response.setContentType("application/json");
            response.getWriter().write(jsonResponse);

        }
        catch(Exception e){
            e.printStackTrace();
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            response.getWriter().write("{\"error\": \"An error occurred while processing the request.\"}");
        }
        finally {
            if(em.isOpen()){
                em.close();
            }
        }

    }
}
