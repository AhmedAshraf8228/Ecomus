package iti.jets.service;

import com.google.gson.Gson;
import iti.jets.dao.impl.GenericRepoImpl;
import iti.jets.entity.Category;
import iti.jets.entity.Order;
import iti.jets.entity.Product;
import iti.jets.entity.ProductCategory;
import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityManagerFactory;
import jakarta.persistence.Persistence;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.BufferedReader;
import java.io.IOException;
import java.util.List;

@WebServlet("/api/category")
public class CategoryServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        resp.setContentType("application/json");
        resp.setCharacterEncoding("UTF-8");

        GenericRepoImpl<Category, Integer> repo = new GenericRepoImpl<>(Category.class);
        Gson gson = new Gson();

        String categoryIdParam = req.getParameter("id");
        try {
            if (categoryIdParam != null) {
                int categoryId = Integer.parseInt(categoryIdParam);
                System.out.println("\n\n\t"+categoryId+"\n\n\t");
                Category category = repo.findById(categoryId);

                if (category != null) {
                    resp.getWriter().write(gson.toJson(category));
                } else {
                    resp.getWriter().write("{\"error\": \"Category not found\"}");
                }
            }else{
                List<Category> cats = repo.findAll();
                resp.getWriter().write(gson.toJson(cats));
            }

        }catch (Exception e) {
            resp.getWriter().write("{\"error\": \"An error occurred in Category Servlet\"}");
            e.printStackTrace();
        }finally {
            if (repo.getEntityManager().isOpen()) {
                repo.getEntityManager().close();
            }
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        BufferedReader reader = request.getReader();
        Gson gson = new Gson();
        Category newCategory = gson.fromJson(reader, Category.class);
        GenericRepoImpl<Category, Integer> categoryRepo = new GenericRepoImpl<>(Category.class);
        try {
            categoryRepo.insert(newCategory);
            response.setStatus(HttpServletResponse.SC_CREATED);
            response.getWriter().write("{\"message\": \"Category added successfully\"}");
        } catch (Exception e) {
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            response.getWriter().write("{\"error\": \"Failed to add category\"}");
            e.printStackTrace();
        } finally {
            if (categoryRepo.getEntityManager().isOpen()) {
                categoryRepo.getEntityManager().close();
            }
        }
    }

    @Override
    protected void doDelete(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int categoryId = Integer.parseInt(request.getParameter("categoryId"));
            GenericRepoImpl<Category, Integer> categoryRepo = new GenericRepoImpl<>(Category.class);
            GenericRepoImpl<ProductCategory, Integer> productCategoryRepo = new GenericRepoImpl<>(ProductCategory.class);
        try {
            categoryRepo.deleteById(categoryId);
            response.setStatus(200);
        } catch (Exception e) {
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            response.getWriter().write("{\"error\": \"Failed to add category\"}");
            e.printStackTrace();
        } finally {
            if (categoryRepo.getEntityManager().isOpen()) {
                categoryRepo.getEntityManager().close();
            }
            if (productCategoryRepo.getEntityManager().isOpen()) {
                productCategoryRepo.getEntityManager().close();
            }
        }
    }

    @Override
    protected void doPut(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        resp.setContentType("application/json");
        resp.setCharacterEncoding("UTF-8");
        GenericRepoImpl<Category, Integer> repo = new GenericRepoImpl<>(Category.class);
        Gson gson = new Gson();
        try {
            BufferedReader reader = req.getReader();
            Category updatedCategory = gson.fromJson(reader, Category.class);
            if (updatedCategory.getCategoryId() <= 0 || updatedCategory.getCategoryName() == null) {
                resp.getWriter().write("{\"error\": \"Invalid category data\"}");
                if (repo.getEntityManager().isOpen()) {
                    repo.getEntityManager().close();
                }
                return;
            }
            Category existingCategory = repo.findById(updatedCategory.getCategoryId());
            if (existingCategory != null) {
                existingCategory.setCategoryName(updatedCategory.getCategoryName());
                repo.update(existingCategory);
                resp.getWriter().write("{\"message\": \"Category updated successfully\"}");
            } else {
                resp.getWriter().write("{\"error\": \"Category not found\"}");
            }
        } catch (Exception e) {
            resp.getWriter().write("{\"error\": \"An error occurred while updating category\"}");
            e.printStackTrace();
        } finally {
            if (repo.getEntityManager().isOpen()) {
                repo.getEntityManager().close();
            }
        }
    }
}
