package iti.jets.service;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.google.gson.Gson;
import iti.jets.dao.impl.*;
import iti.jets.entity.Category;
import iti.jets.entity.Product;
import iti.jets.entity.ProductCategory;
import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityTransaction;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import jakarta.transaction.Transactional;

import java.io.BufferedReader;
import java.io.IOException;
import java.util.List;
import java.util.Optional;

@WebServlet("/admin/products")

public class ProductServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        ProductRepoImpl productRepo = new ProductRepoImpl();
        EntityManager entityManager = productRepo.getEntityManager();


        try {
            entityManager.getTransaction().begin();
            List<Product> products = productRepo.findAll();
            entityManager.getTransaction().commit();

            Gson gson = new Gson();
            String json = gson.toJson(products);

            response.getWriter().write(json);
        } catch (Exception e) {
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            response.getWriter().write("{\"error\": \"An error occurred\"}");
            e.printStackTrace();
        } finally {
            if(entityManager.isOpen()) {
                entityManager.close();
            }
        }
    }

    @Override
    protected void doDelete(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int productIdId = Integer.parseInt(request.getParameter("productId"));
        ProductRepoImpl productRepo = new ProductRepoImpl();
        EntityManager em = productRepo.getEntityManager();
        try {
            em.getTransaction().begin();
            productRepo.deleteById(productIdId);
            em.getTransaction().commit();

            response.setStatus(200);
        } catch (Exception e) {
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            response.getWriter().write("{\"error\": \"Invalid JSON format\"}");
        } finally {
            if (em != null && em.isOpen()) {
                em.close();
            }
        }

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        ObjectMapper objectMapper = new ObjectMapper();
        ProductRepoImpl productRepo = new ProductRepoImpl();
        EntityManager em = productRepo.getEntityManager();


        try {

            Product product = objectMapper.readValue(request.getReader(), Product.class);

            if (product.getProductName() == null || product.getProductName().trim().isEmpty() ||
                    product.getDescription() == null || product.getDescription().trim().isEmpty() ||
                    product.getQuantity() <= 0 || product.getPrice() <= 0) {

                response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
                response.getWriter().write("{\"error\": \"Missing or invalid required fields\"}");
                return;
            }

            em.getTransaction().begin();
            Product insertedProduct = productRepo.insert(product);
            em.refresh(insertedProduct);
            em.getTransaction().commit();


            if (insertedProduct != null) {
                System.out.println("\n\n\tinserted Produt ID :"+insertedProduct.getProductId()+"\n\n\t");
                response.setStatus(HttpServletResponse.SC_OK);

                String jsonResponse = String.format(
                        "{\"productId\": %d}", insertedProduct.getProductId());
                response.getWriter().write(jsonResponse);
            } else {
                response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
                response.getWriter().write("{\"error\": \"Failed to add product\"}");
            }

        }
        catch (IOException e) {
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            response.getWriter().write("{\"error\": \"Invalid JSON format\"}");
        }
        catch (Exception e) {
            em.getTransaction().rollback();
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            response.getWriter().write("{\"error\": \"An error occurred while adding the product.\"}");
            e.printStackTrace();
        }
        finally {
            if(em.isOpen()){
                em.close();
                System.out.println("\n\n\tem in PS is closed\n\n\t");
            }
        }

    }
}
