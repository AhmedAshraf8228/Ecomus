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
    <!-- Toastr -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/toastr.min.css" />
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/toastr.min.js"></script>
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
            <!-- Add more rows dynamically here -->
            </tbody>
        </table>
    </div>
</div>

    <div class="add-product-container">
            <form id="product-info-form" method="post">
                <h3>Add Product Info</h3>
                <input type="text" id="product-name" placeholder="Product Name" name="name" required>
                <input type="text" id="product-description" placeholder="Product Description" name="description" required>
                <input type="number" min="1" id="product-quantity" placeholder="Product Quantity" name="quantity" required>
                <input type="number" min="1" id="product-price" placeholder="Product Price" name="price" required>
                <h3>Categories</h3>
                <div class="categories-container">

                </div>
                <h3>Choose Images</h3>
                <input type="file" id="product-images" accept="image/*" multiple>
                <div id="image-preview-box" class="image-preview-box"></div>
                <button type="button" id="add-product-btn" onclick="addProductInfo()" >Save Product Info</button>
                <button type="button" id="edit-product-btn" onclick="updateProductInfo()" disabled>Edit Product Info</button>
            </form>

    </div>

</div>
</body>
</html>