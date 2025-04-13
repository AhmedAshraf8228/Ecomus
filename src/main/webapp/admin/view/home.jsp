<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Dashboard</title>
    <link rel="stylesheet" href="/MindMaze/admin/css/home.css">
    <link rel="stylesheet" href="/MindMaze/admin/css/general.css">
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="/MindMaze/admin/js/home.js"></script>

</head>
<body>

<div class="main">
    <div class="header-container">
        <h2 class="dashboard-title">Dashboard</h2>
    </div>

    <div class="dashboard-cards">

        <div class="card">
            <p class="card-title">TOTAL ORDERS</p>
            <h3 class="card-value" id="totalOrders"></h3>
        </div>
        <div class="card">
            <p class="card-title">TOTAL CUSTOMERS</p>
            <h3 class="card-value" id="totalCustomers"></h3>
        </div>
        <div class="card">
            <p class="card-title">TOTAL CATEGORIES</p>
            <h3 class="card-value" id="totalCategories"></h3>
        </div>
    </div>
</div>


</body>
</html>
