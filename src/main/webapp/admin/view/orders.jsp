<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Orders</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <link rel="stylesheet" href="/MindMaze/admin/css/orders.css">
    <link rel="stylesheet" href="/MindMaze/admin/css/general.css">
    <script src="/MindMaze/admin/js/orders.js"></script>


</head>
<body>

<div id="layout"></div>


<div class="main">
    <div class="header-container">
        <h2 class="dashboard-title">Order</h2>
    </div>
    <!-- Search Bar -->
    <input type="text" id="search-input" placeholder="Search by Order ID..." onkeyup="searchOrder()">

    <table>
        <thead>
        <tr>
            <th>Order</th>
            <th>Date</th>
            <th>Customer</th>
            <th>Payment</th>
            <th>Status</th>
            <th>Total</th>
        </tr>
        </thead>
        <tbody>
        <tr>
            <td>1</td>
            <td>Jan 18, 9:31am</td>
            <td>#19748</td>
            <td><span class="status COD">COD</span></td>
            <td><span class="fulfillment completed">Completed</span></td>
            <td>$ 16,943</td>
        </tr>
        <tr>
            <td>2</td>
            <td>Jan 18, 9:31am</td>
            <td>#19748</td>
            <td><span class="status CREDIT">CREDIT</span></td>
            <td><span class="fulfillment Canceled">Canceled</span></td>
            <td>$ 16,943</td>
        </tr>
        <tr>
            <td>3</td>
            <td>Jan 18, 9:31am</td>
            <td>#19748</td>
            <td><span class="status CREDIT">CREDIT</span></td>
            <td><span class="fulfillment processed">Processing</span></td>
            <td>$ 16,943</td>
        </tr>
        </tbody>
    </table>
</div>

</body>
</html>
