<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Customers</title>
    <link rel="stylesheet" href="/MindMaze/admin/css/customers.css">
    <link rel="stylesheet" href="/MindMaze/admin/css/general.css">
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="/MindMaze/admin/js/customers.js"></script>

</head>
<body>


<div class="main">
    <div class="header-container">
        <h2 class="dashboard-title">Customers</h2>
    </div>
    <input type="text" id="search-input" placeholder="Search by Customer ID" onkeyup="searchCustomer()">
    <table>
        <thead>
        <tr>
            <th>Customer ID</th>
            <th>Name</th>
            <th>Email</th>
            <th>Phone</th>
            <th>Address</th>
            <th>Action</th>
        </tr>
        </thead>
        <tbody>
        <tr>
            <td>001</td>
            <td>John Doe</td>
            <td>johndoe@example.com</td>
            <td>+123456789</td>
            <td>Cairo, Egypt</td>
            <td>
                <button class="delete-button">Delete</button>
            </td>
        </tr>
        <tr>
            <td>002</td>
            <td>Jane Smith</td>
            <td>janesmith@example.com</td>
            <td>+987654321</td>
            <td>Cairo, Egypt</td>
            <td>
                <button class="delete-button">Delete</button>
            </td>
        </tr>
        </tbody>
    </table>
</div>
</body>
</html>
