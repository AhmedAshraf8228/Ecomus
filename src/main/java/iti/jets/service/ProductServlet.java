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
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

@WebServlet("/admin/products/*")

public class ProductServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        ProductRepoImpl productRepo = new ProductRepoImpl();
        EntityManager entityManager = productRepo.getEntityManager();

        try {
            String pathInfo = req.getPathInfo();
            Gson gson = new Gson();

            if (pathInfo != null && pathInfo.length() > 1) {
                //Retern a product with specific ID
                int productId = Integer.parseInt(pathInfo.substring(1));

                entityManager.getTransaction().begin();
                Product product = productRepo.findById(productId);
                entityManager.getTransaction().commit();

                if (product != null) {
                    String json = gson.toJson(product);
                    response.getWriter().write(json);
                } else {
                    response.setStatus(HttpServletResponse.SC_NOT_FOUND);
                    response.getWriter().write("{\"error\": \"Product not found\"}");
                }
            } else {
                // Return all products
                entityManager.getTransaction().begin();
                List<Product> products = productRepo.findAll();
                entityManager.getTransaction().commit();

                String json = gson.toJson(products);
                response.getWriter().write(json);
            }

        } catch (Exception e) {
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            response.getWriter().write("{\"error\": \"An error occurred\"}");
            e.printStackTrace();
        } finally {
            if (entityManager.isOpen()) {
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
                ln("\n\n\tinserted Produt ID :"+insertedProduct.getProductId()+"\n\n\t");
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
                ln("\n\n\tem in PS is closed\n\n\t");
            }
        }

    }

    @Override
    protected void doPut(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        EntityManager em = GenericRepoImpl.getEntityManagerFactory().createEntityManager();
        ObjectMapper objectMapper = new ObjectMapper();
        ProductRepoImpl productRepo = new ProductRepoImpl(em);
        CategoryRepoImpl categoryRepo = new CategoryRepoImpl(em);

        try {
            Product updatedProduct = objectMapper.readValue(request.getReader(), Product.class);

            em.getTransaction().begin();
            Product existingProduct = productRepo.findById(updatedProduct.getProductId());

            if (existingProduct == null) {
                response.setStatus(HttpServletResponse.SC_NOT_FOUND);
                response.getWriter().write("{\"error\": \"Product not found\"}");
                return;
            }

            // Update fields
            existingProduct.setProductName(updatedProduct.getProductName());
            existingProduct.setDescription(updatedProduct.getDescription());
            existingProduct.setQuantity(updatedProduct.getQuantity());
            existingProduct.setPrice(updatedProduct.getPrice());

            // Get and set managed categories
            List<Category> managedCategories = new ArrayList<>();
            for (Category cat : updatedProduct.getCategories()) {
                Category managedCat = categoryRepo.getCategoryByName(cat.getCategoryName());
                if (managedCat != null) {
                    managedCategories.add(managedCat);
                } else {
                    throw new IllegalArgumentException("Category not found: " + cat.getCategoryName());
                }
            }
            existingProduct.setCategories(managedCategories);

            productRepo.update(existingProduct);
            em.getTransaction().commit();

            response.setStatus(HttpServletResponse.SC_OK);
            response.getWriter().write("{\"message\": \"Product updated successfully\"}");
        }
        catch (Exception e) {
            if (em.getTransaction().isActive()) {
                em.getTransaction().rollback();
            }
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            response.getWriter().write("{\"error\": \"Failed to update product\"}");
            e.printStackTrace();
        }
        finally {
            if (em.isOpen()) {
                em.close();
            }
        }
    }

}
