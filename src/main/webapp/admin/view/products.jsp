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
                <th>Type</th>
                <th>Inventory</th>
                <th>Actions</th>
            </tr>
            </thead>
            <tbody>
            <tr>
                <td>1</td>
                <td><img src="\MindMaze\admin\images\1.jpeg" alt="Product"></td>
                <td>Super Extreme Nike Sports</td>
                <td>Shoes</td>
                <td>3</td>
                <td>
                    <button class="edit-button">Edit</button>
                    <button class="delete-button">Delete</button>
                </td>
            </tr>
            <tr>
                <td>2</td>
                <td><img src="\MindMaze\admin\images\1.jpeg" alt="Product"></td>
                <td>Super Extreme Nike Sports</td>
                <td>Shoes</td>
                <td>3</td>
                <td>
                    <button class="edit-button">Edit</button>
                    <button class="delete-button">Delete</button>
                </td>
            </tr>
            <!-- Add more rows dynamically here -->
            </tbody>
        </table>
    </div>
</div>
    <div class="add-category-container">

        <h3>Add New Product</h3>

            <input type="text" id="product-name" placeholder="Product Name" required>
            <input type="text" id="product-description" placeholder="Product Description" required>
            <input type="number" id="product-quantity" placeholder="Product Quantity" required>
            <input type="number" id="product-price" placeholder="Product Price" required>

        <div class="categories-container">
            <h3>Categories</h3>

            <label class="category-item">
                <input type="checkbox" name="Categories" value="Action">Action
            </label>

            <label class="category-item">
                <input type="checkbox" name="Categories" value="Adventure">Adventure
            </label>
            <label class="category-item">
                <input type="checkbox" name="Categories" value="RPG">RPG
            </label>

            <label class="category-item">
                <input type="checkbox" name="Categories" value="Shooter">Shooter
            </label>

            <label class="category-item">
                <input type="checkbox" name="Categories" value="VR">VR
            </label>
        </div>

        <div class="image-upload-container">
            <h3>Choose Images (up to 5)</h3>
            <input type="file" id="product-images" accept="image/*" multiple>

            <div id="image-preview-box" class="image-preview-box"></div>
        </div>

        <button>Add Product</button>
    </div>
</div>
</body>
</html>