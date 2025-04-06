<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Add Product</title>
    <link rel="stylesheet" href="/MindMaze/admin/css/addProduct.css">
</head>
<body>
<div class="content">
    <h2 class="dashboard-title">Add Product</h2>
    <form action="addProductServlet" method="post" enctype="multipart/form-data">
        <label for="title">Title</label>
        <input type="text" id="title" name="title" placeholder="e.g. Short sleeve t-shirt" required>

        <label for="description">Description (optional)</label>
        <textarea id="description" name="description" placeholder="Enter product description"></textarea>

        <label for="productType">Product Type</label>
        <select id="productType" name="productType">
            <option value="Shirts">Shirts</option>
            <option value="Shoes">Shoes</option>
            <option value="TV">TV</option>
        </select>

        <label for="vendor">Vendor</label>
        <select id="vendor" name="vendor">
            <option value="Samsung">Samsung</option>
            <option value="Nike">Nike</option>
            <option value="Adidas">Adidas</option>
        </select>

        <label>Collections</label>
        <input type="checkbox" name="collections" value="Appliances"> Appliances
        <input type="checkbox" name="collections" value="Furniture"> Furniture
        <input type="checkbox" name="collections" value="Hardware Tools"> Hardware Tools
        <input type="checkbox" name="collections" value="Home Interior"> Home Interior

        <label>Media</label>
        <input type="file" name="image">

        <button type="submit">Save</button>
        <button type="button" onclick="window.history.back();">Discard</button>
    </form>
</div>
</body>
</html>
