package iti.jets.service;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.google.gson.Gson;
import com.google.gson.JsonSyntaxException;
import iti.jets.dao.impl.GenericRepoImpl;
import iti.jets.entity.Category;
import iti.jets.entity.Product;
import iti.jets.entity.ProductCategory;
import iti.jets.entity.User;
import jakarta.json.JsonObject;
import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityManagerFactory;
import jakarta.persistence.Persistence;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;
import org.eclipse.tags.shaded.org.apache.xpath.operations.Number;
import org.hibernate.Hibernate;

import java.io.BufferedReader;
import java.io.File;
import java.io.IOException;
import java.nio.file.Paths;
import java.util.ArrayList;
import java.util.Collections;
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


    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        ObjectMapper objectMapper = new ObjectMapper();

        EntityManager entityManager = emf.createEntityManager();
        GenericRepoImpl<Product, Integer> productRepo = new GenericRepoImpl<>(entityManager, Product.class);

        try {
            Product product = objectMapper.readValue(request.getReader(), Product.class);

            if (product.getProductName() == null || product.getProductName().trim().isEmpty() ||
                    product.getDescription() == null || product.getDescription().trim().isEmpty() ||
                    product.getQuantity() <= 0 || product.getPrice() <= 0) {

                response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
                response.getWriter().write("{\"error\": \"Missing or invalid required fields\"}");
                return;
            }

            Product insertedProduct = productRepo.insert(product);

            if (insertedProduct!=null) {
                response.setStatus(HttpServletResponse.SC_OK);
                response.getWriter().write("{\"message\": \"Product added successfully!\"}");
            } else {
                response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
                response.getWriter().write("{\"error\": \"Failed to add product\"}");
            }

        } catch (IOException e) {
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            response.getWriter().write("{\"error\": \"Invalid JSON format\"}");
        }

    }
    @Override
    public void destroy() {
        if (emf.isOpen()) {
            emf.close();
        }
    }
}
