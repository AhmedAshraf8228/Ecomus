package iti.jets.service;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;

import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.nio.file.Files;

@WebServlet("/admin/uploadProductImages")
@MultipartConfig
public class ImageUploadServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        String productId = req.getParameter("productId");
        if (productId == null || productId.isEmpty()) {
            resp.sendError(HttpServletResponse.SC_BAD_REQUEST, "Missing productId");
            return;
        }

        // 2. Define upload directory
        String uploadPath = getServletContext().getRealPath("/products/" + productId);
        File uploadDir = new File(uploadPath);
        if (!uploadDir.exists()) {
            uploadDir.mkdirs();
        }

        // 3. Process uploaded files
        int imageIndex = 1;
        for (Part part : req.getParts()) {
            if (part.getName().equals("images") && part.getSize() > 0) {
                String fileName = imageIndex + ".jpg"; // Can add logic to detect extension if needed
                File file = new File(uploadDir, fileName);

                try (InputStream input = part.getInputStream()) {
                    Files.copy(input, file.toPath());
                }

                imageIndex++;
            }
        }

        // 4. Response
        resp.setContentType("application/json");
        resp.getWriter().write("{\"message\": \"Images uploaded successfully\"}");

    }
}
