package iti.jets.service;

import iti.jets.dao.impl.*;
import iti.jets.entity.*;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.File;
import java.io.IOException;
import java.util.*;

@WebServlet("/home")
public class Home extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
        response.setHeader("Pragma", "no-cache");
        response.setDateHeader("Expires", 0);

        ProductRepoImpl productRepo = new ProductRepoImpl();
        List<Product> products = productRepo.findAll();

        request.setAttribute("products", products);

        CategoryRepoImpl categoryRepo = new CategoryRepoImpl();
        List<Category> categories = categoryRepo.findAll();

        request.setAttribute("categories", categories);

        Map<Integer, List<String>> productsImages = loadProductImages(products, getServletContext());
        request.setAttribute("productsImages", productsImages);

        updateCartSizeIfLoggedIn(request);

        RequestDispatcher dispatcher = request.getRequestDispatcher("/home.jsp");
        dispatcher.forward(request, response);

        if (productRepo.getEntityManager().isOpen()) {
            productRepo.getEntityManager().close();
        }
    }

    private Map<Integer, List<String>> loadProductImages(List<Product> products, ServletContext context) {
        Map<Integer, List<String>> imagesMap = new HashMap<>();
        String imageBasePath = context.getRealPath("/images/products/");

        for (Product product : products) {
            File imageDir = new File(imageBasePath, String.valueOf(product.getProductId()));
            List<String> imageList = new ArrayList<>();

            if (imageDir.exists() && imageDir.isDirectory()) {
                File[] imageFiles = imageDir.listFiles((dir, name) -> {
                    String lower = name.toLowerCase();
                    return lower.endsWith(".jpg") || lower.endsWith(".jpeg")
                            || lower.endsWith(".png") || lower.endsWith(".gif");
                });

                if (imageFiles != null) {
                    for (File file : imageFiles) {
                        imageList.add(file.getName());
                    }
                }
            }

            imagesMap.put(product.getProductId(), imageList);
        }

        return imagesMap;
    }

    private void updateCartSizeIfLoggedIn(HttpServletRequest request) {
        HttpSession session = request.getSession(false);
        if (session != null &&
                Boolean.TRUE.equals(session.getAttribute("login")) &&
                session.getAttribute("id") != null) {

            int userId = (int) session.getAttribute("id");
            CartRepoImpl cartRepo = new CartRepoImpl();
            int cartSize = cartRepo.getTotalQuantityByUserId(userId);

            session.setAttribute("cart-size", cartSize);
            System.out.println("✅ [HomeServlet] Cart size updated for user " + userId + ": " + cartSize);

            if (cartRepo.getEntityManager().isOpen()) {
                cartRepo.getEntityManager().close();
            }
        }
    }
}
