<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Products</title>
    <script src="https://kit.fontawesome.com/a076d05399.js" crossorigin="anonymous"></script>
    <link rel="stylesheet" href="/MindMaze/admin/css/products.css">
    <link rel="stylesheet" href="/MindMaze/admin/css/general.css">
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="/MindMaze/admin/js/products.js"></script>

</head>
<body>

<div class="container">

    <div class="main">

    <div class="header-container">
        <h2 class="dashboard-title">Products</h2>
    </div>

    <div class="search-container">
        <input type="text" id="search-input" onkeyup="searchProduct()" placeholder="Search by Product ID...">
    </div>

    <div >
        <table id="products-table">
            <thead>
            <tr>
                <th>ID</th>
                <th>Image</th>
                <th>Product</th>
                <th>Inventory</th>
                <th>Price</th>
                <th>Actions</th>
            </tr>
            </thead>
            <tbody id="product-tbody">
<%--            <tr>--%>
<%--                <td>1</td>--%>
<%--                <td><img src="\MindMaze\admin\images\1.jpeg" alt="Product"></td>--%>
<%--                <td>Super Extreme Nike Sports</td>--%>
<%--                <td>Shoes</td>--%>
<%--                <td>3</td>--%>
<%--                <td>--%>
<%--                    <button class="edit-button">Edit</button>--%>
<%--                    <button class="delete-button">Delete</button>--%>
<%--                </td>--%>
<%--            </tr>--%>
<%--            <tr>--%>
<%--                <td>2</td>--%>
<%--                <td><img src="\MindMaze\admin\images\1.jpeg" alt="Product"></td>--%>
<%--                <td>Super Extreme Nike Sports</td>--%>
<%--                <td>Shoes</td>--%>
<%--                <td>3</td>--%>
<%--                <td>--%>
<%--                    <button class="edit-button">Edit</button>--%>
<%--                    <button class="delete-button">Delete</button>--%>
<%--                </td>--%>
<%--            </tr>--%>
            <!-- Add more rows dynamically here -->
            </tbody>
        </table>
    </div>
</div>

    <div class="add-product-container">
        <!-- Div #1: Add Product Info -->
        <div id="product-info-container">
            <form id="product-info-form" method="post">
                <h3>Add Product Info</h3>
                <input type="text" id="product-name" placeholder="Product Name" name="name" required>
                <input type="text" id="product-description" placeholder="Product Description" name="description" required>
                <input type="number" id="product-quantity" placeholder="Product Quantity" name="quantity" required>
                <input type="number" id="product-price" placeholder="Product Price" name="price" required>
                <button type="button" onclick="addProductInfo()">Save Product Info</button>
            </form>
        </div>

        <!-- Div #2: Add Category to Product -->
        <div id="category-container">
            <h3>Categories</h3>
            <div class="categories-container">
                <!-- Example categories (checkboxes) -->
                <label><input type="checkbox" name="Categories" value="Category1"> Category 1</label>
                <label><input type="checkbox" name="Categories" value="Category2"> Category 2</label>
                <label><input type="checkbox" name="Categories" value="Category3"> Category 3</label>
            </div>
            <button type="button" onclick="addCategories()">Save Categories</button>
        </div>

        <!-- Div #3: Add Images (Multiple) for Product -->
        <div id="image-upload-container">
            <h3>Choose Images (up to 5)</h3>
            <input type="file" id="product-images" accept="image/*" multiple>
            <div id="image-preview-box" class="image-preview-box"></div>
            <button type="button" onclick="addImages()">Save Images</button>
        </div>
    </div>




</div>
</body>
</html>