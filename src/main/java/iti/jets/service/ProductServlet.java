package iti.jets.service;

import com.google.gson.Gson;
import iti.jets.dao.impl.GenericRepoImpl;
import iti.jets.entity.Product;
import iti.jets.entity.ProductCategory;
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
import java.util.List;

@WebServlet("/admin/products")

public class ProductServlet extends HttpServlet {
    private EntityManagerFactory emf = Persistence.createEntityManagerFactory("jpa-mysql");
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        EntityManager entityManager = emf.createEntityManager();
        GenericRepoImpl<Product, Integer> userRepo = new GenericRepoImpl<>(entityManager, Product.class);

        try {
            List<Product> products = userRepo.findAll();

            Gson gson = new Gson();
            String json = gson.toJson(products);

            response.getWriter().write(json);
        } catch (Exception e) {
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            response.getWriter().write("{\"error\": \"An error occurred\"}");
            e.printStackTrace();
        }finally {
            entityManager.close();
        }
    }

    @Override
    protected void doDelete(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int productIdId = Integer.parseInt(request.getParameter("productId"));

        EntityManager entityManager = emf.createEntityManager();
        GenericRepoImpl<Product, Integer> productRepo = new GenericRepoImpl<>(entityManager, Product.class);
        GenericRepoImpl<ProductCategory, Integer> productCategoryRepo = new GenericRepoImpl<>(entityManager, ProductCategory.class);
        productRepo.deleteById(productIdId);
//        productCategoryRepo.deleteById(productIdId);

        entityManager.close();
        response.setStatus(200);
    }

    @Override
    public void destroy() {
        if (emf.isOpen()) {
            emf.close();
        }
    }
}
