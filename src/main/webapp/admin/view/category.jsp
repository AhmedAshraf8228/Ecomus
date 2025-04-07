<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Categories</title>
    <link rel="stylesheet" href="/MindMaze/admin/css/category.css">
    <link rel="stylesheet" href="/MindMaze/admin/css/general.css">
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="/MindMaze/admin/js/category.js"></script>

</head>
<body>

<div class="container">
    <div class="main">
        <div class="header-container">
            <h2 class="dashboard-title">Categories</h2>
        </div>

        <input type="text" id="search-input" onkeyup="searchCategory()" placeholder="Search by ID...">
        <table id="category-table">
            <thead>
            <tr>
                <th>ID</th>
                <th>Name</th>
                <th>Number of Products</th>
                <th>Action</th>
            </tr>
            </thead>
            <tbody id="category-tbody">
<%--            <tr>--%>
<%--                <td>1</td>--%>
<%--                <td>Electronics</td>--%>
<%--                <td>120</td>--%>
<%--                <td>--%>
<%--                    <button class="edit-button">Edit</button>--%>
<%--                    <button class="delete-button">Delete</button>--%>
<%--                </td>--%>
<%--            </tr>--%>
<%--            <tr>--%>
<%--                <td>2</td>--%>
<%--                <td>Clothing</td>--%>
<%--                <td>200</td>--%>
<%--                <td>--%>
<%--                    <button class="edit-button">Edit</button>--%>
<%--                    <button class="delete-button">Delete</button>--%>
<%--                </td>--%>
<%--            </tr>--%>
<%--            <tr>--%>
<%--                <td>3</td>--%>
<%--                <td>Home Appliances</td>--%>
<%--                <td>80</td>--%>
<%--                <td>--%>
<%--                    <button class="edit-button">Edit</button>--%>
<%--                    <button class="delete-button">Delete</button>--%>
<%--                </td>
            </tr>--%>
            </tbody>
        </table>
    </div>

    <div class="add-category-container">
        <h3>Add New Category</h3>
        <input type="text" id="category-name" placeholder="Category Name">
        <button>Add Category</button>
    </div>
</div>



</body>
</html>
