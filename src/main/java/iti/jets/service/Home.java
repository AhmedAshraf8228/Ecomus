package iti.jets.service;

import iti.jets.dao.impl.*;
import iti.jets.entity.*;
import jakarta.persistence.*;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.*;
import java.util.*;

@WebServlet("/home")
public class Home extends HttpServlet {
    private ProductRepoImpl productRepo;

    @Override
    public void init() throws ServletException {
        EntityManager entityManager = GenericRepoImpl.getEntityManagerFactory().createEntityManager();
        productRepo = new ProductRepoImpl(entityManager, Product.class);
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        List<Product> products = productRepo.findAll();
        request.setAttribute("products", products);

        Map<Integer, List<String>> productsImages = new HashMap<>();
        String imagePath = getServletContext().getRealPath("/images/products/");

        for (Product p : products) {
            File dir = new File(imagePath + File.separator + p.getProductId());
            List<String> imageNames = new ArrayList<>();
            if (dir.exists() && dir.isDirectory()) {
                File[] files = dir.listFiles((d, name) -> {
                    String lower = name.toLowerCase();
                    return lower.endsWith(".jpg") || lower.endsWith(".png") || lower.endsWith(".jpeg") || lower.endsWith(".gif");
                });
                if (files != null) {
                    for (File file : files) {
                        imageNames.add(file.getName());
                    }
                }
            }
            productsImages.put(p.getProductId(), imageNames);
        }

        request.setAttribute("productsImages", productsImages);
        RequestDispatcher dispatcher = request.getRequestDispatcher("/home.jsp");
        dispatcher.forward(request, response);
    }

    @Override
    public void destroy() {
        if (productRepo != null && productRepo.getEntityManager().isOpen()) {
            productRepo.getEntityManager().close();
        }
    }
}
