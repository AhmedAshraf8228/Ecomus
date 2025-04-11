package iti.jets.service;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.google.gson.Gson;
import iti.jets.dao.impl.*;
import iti.jets.entity.Product;
import jakarta.persistence.EntityManager;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.util.List;

@WebServlet("/admin/products")

public class ProductServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        EntityManager entityManager = GenericRepoImpl.getEntityManagerFactory().createEntityManager();
        ProductRepoImpl productRepo = new ProductRepoImpl();

        try {
            List<Product> products = productRepo.findAll();

            Gson gson = new Gson();
            String json = gson.toJson(products);

            response.getWriter().write(json);
        } catch (Exception e) {
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            response.getWriter().write("{\"error\": \"An error occurred\"}");
            e.printStackTrace();
        } finally {
            entityManager.close();
        }
    }

    @Override
    protected void doDelete(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int productIdId = Integer.parseInt(request.getParameter("productId"));
        ProductRepoImpl productRepo = new ProductRepoImpl();
        try {
            productRepo.deleteById(productIdId);
            if (productRepo.getEntityManager() != null && productRepo.getEntityManager().isOpen()) {
                productRepo.getEntityManager().close();
            }
            response.setStatus(200);
        } catch (Exception e) {
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            response.getWriter().write("{\"error\": \"Invalid JSON format\"}");
        } finally {
            if (productRepo.getEntityManager() != null && productRepo.getEntityManager().isOpen()) {
                productRepo.getEntityManager().close();
            }
        }

    }


    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        ObjectMapper objectMapper = new ObjectMapper();

        ProductRepoImpl productRepo = new ProductRepoImpl();

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

            if (insertedProduct != null) {
                response.setStatus(HttpServletResponse.SC_OK);
                response.getWriter().write("{\"message\": \"Product added successfully!\"}");
            } else {
                response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
                response.getWriter().write("{\"error\": \"Failed to add product\"}");
            }

        } catch (IOException e) {
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            response.getWriter().write("{\"error\": \"Invalid JSON format\"}");
        } finally {
            if (productRepo.getEntityManager() != null && productRepo.getEntityManager().isOpen()) {
                productRepo.getEntityManager().close();
            }
        }

    }
}
