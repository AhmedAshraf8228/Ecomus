package iti.jets.service;

import iti.jets.dao.impl.*;
import iti.jets.entity.*;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.*;
import java.util.*;

@WebServlet("/home")
public class Home extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        ProductRepoImpl productRepo = new ProductRepoImpl();

        List<Product> products = productRepo.getInStock();
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

        HttpSession session = request.getSession(false);
        if (session != null && Boolean.TRUE.equals(session.getAttribute("login")) &&
                session.getAttribute("id") != null) {

            int userId = (int)session.getAttribute("id");
            CartRepoImpl cartRepo = new CartRepoImpl();
            int size = cartRepo.getCartItemsByUserId(userId).size();
            session.setAttribute("cart-size", size);
            System.out.println("cart-size"+ size);
        }

        dispatcher.forward(request, response);

        if (productRepo.getEntityManager().isOpen()) {
            productRepo.getEntityManager().close();
        }
    }
}
