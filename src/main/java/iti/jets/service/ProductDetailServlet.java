package iti.jets.service;

import iti.jets.dao.impl.*;
import iti.jets.entity.*;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.*;
import java.util.*;

@WebServlet("/productDetail")
public class ProductDetailServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String productId = request.getParameter("id");
        ProductRepoImpl productRepo = new ProductRepoImpl();

        Product product = productRepo.findById(Integer.parseInt(productId));
        request.setAttribute("product", product);

        List<String> imagesList = loadProductImages(productId, getServletContext());
        request.setAttribute("imgList", imagesList);

        System.out.println(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>" + product);
        System.out.println(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>" + imagesList);
        RequestDispatcher dispatcher = request.getRequestDispatcher("/productDetail.jsp");
        dispatcher.forward(request, response);
    }

    private List<String> loadProductImages(String productId , ServletContext context) {
        String imageBasePath = context.getRealPath("/images/products/");
        File imageDir = new File(imageBasePath, productId);
        List<String> imagesList = new ArrayList<>();
        if (imageDir.exists() && imageDir.isDirectory()) {
            File[] imageFiles = imageDir.listFiles((dir, name) -> {
                String lower = name.toLowerCase();
                return lower.endsWith(".jpg") || lower.endsWith(".jpeg")
                        || lower.endsWith(".png") || lower.endsWith(".gif");
            });

            if (imageFiles != null) {
                for (File file : imageFiles) {
                    imagesList.add(file.getName());
                }
            }
        }
        return imagesList;
    }
}
