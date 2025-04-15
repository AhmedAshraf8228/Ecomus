package iti.jets.service;

import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import iti.jets.dao.impl.CategoryRepoImpl;
import iti.jets.dao.impl.GenericRepoImpl;
import iti.jets.dao.impl.ProductCategoryRepoImpl;
import iti.jets.entity.Category;
import iti.jets.entity.Product;
import iti.jets.entity.ProductCategory;
import jakarta.persistence.EntityManager;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.transaction.Transactional;

import java.io.BufferedReader;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;

@WebServlet("/admin/productCategory")
public class ProductCategoryServlet extends HttpServlet {

        @Transactional
        @Override
        protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
            response.setContentType("application/json");
            response.setCharacterEncoding("UTF-8");

            EntityManager em = GenericRepoImpl.getEntityManagerFactory().createEntityManager();
            ObjectMapper objectMapper = new ObjectMapper();
            ProductCategoryRepoImpl productCategoryRepo = new ProductCategoryRepoImpl(em);
            CategoryRepoImpl categoryRepo = new CategoryRepoImpl(em);

            try {
                BufferedReader reader = request.getReader();
                StringBuilder stringBuilder = new StringBuilder();
                String line;
                while ((line = reader.readLine()) != null) {
                    stringBuilder.append(line);
                }

                JsonNode jsonNode = objectMapper.readTree(stringBuilder.toString());

                JsonNode productNode = jsonNode.get("id");
                if (productNode == null || !productNode.isInt()) {
                    response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
                    response.getWriter().write("{\"error\": \"Missing or invalid product field\"}");
                    return;
                }
                int productId = productNode.asInt();

                em.getTransaction().begin();
                Product product = em.find(Product.class, productId);
                if (product == null) {
                    response.setStatus(HttpServletResponse.SC_NOT_FOUND);
                    response.getWriter().write("{\"error\": \"Product not found\"}");
                    return;
                }

                em.refresh(product);



                JsonNode categoriesNode = jsonNode.get("categories");
                if (categoriesNode == null || !categoriesNode.isArray()) {
                    response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
                    response.getWriter().write("{\"error\": \"Missing or invalid categories field\"}");
                    return;
                }

                List<String> categories = new ArrayList<>();
                for (JsonNode category : categoriesNode) {
                    categories.add(category.asText());
                }

                if (!categories.isEmpty()) {
                    List<Integer> catIDs = categoryRepo.getCategoryIdByName(categories);
                    List<Category> cats = new ArrayList<>();
//                    em.getTransaction().begin();
                    for (int catId : catIDs) {
                        Category category = em.find(Category.class, catId);
                        if (category == null) {
                            response.setStatus(HttpServletResponse.SC_NOT_FOUND);
                            response.getWriter().write("{\"error\": \"Category not found\"}");
                            return;
                        }
                        em.refresh(category);


                        cats.add(category);
                        ProductCategory productCategory = new ProductCategory(product, category);
                        productCategoryRepo.insert(productCategory);


                    }
                    product.setCategories(cats);
                    em.getTransaction().commit();

                    response.setStatus(HttpServletResponse.SC_OK);
                    response.getWriter().write("{\"message\": \"Product categories assigned successfully\"}");
                }
            }
            catch (Exception e) {
                e.printStackTrace();
                response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
                response.getWriter().write("{\"error\": \"Invalid request format\"}");
            }
            finally {
                if (em.isOpen()) {
                    em.close();
                }
            }
    }


}
