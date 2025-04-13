<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="iti.jets.entity.Order" %>
<%@ page import="java.util.List" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.text.DecimalFormat" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en-US" lang="en-US">
<head>
    <meta charset="utf-8">
    <title>Ecomus - My Orders</title>

    <meta name="author" content="themesflat.com">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">

   <!-- font -->
   <link rel="stylesheet" href="fonts/fonts.css">
   <!-- Icons -->
   <link rel="stylesheet" href="fonts/font-icons.css">
   <link rel="stylesheet" href="css/bootstrap.min.css">
   <link rel="stylesheet" href="css/swiper-bundle.min.css">
   <link rel="stylesheet" href="css/animate.css">
   <link rel="stylesheet" type="text/css" href="css/styles.css"/>

    <!-- Favicon and Touch Icons  -->
    <link rel="shortcut icon" href="images/logo/favicon.png">
    <link rel="apple-touch-icon-precomposed" href="images/logo/favicon.png">
</head>

<body class="preload-wrapper">
    <%
        // Get orders from request attribute (set by servlet)
        List<Order> userOrders = (List<Order>) request.getAttribute("userOrders");
        
        SimpleDateFormat dateFormat = new SimpleDateFormat("MMMM d, yyyy");
        DecimalFormat priceFormat = new DecimalFormat("$#,##0.00");
        
        // Check if user is logged in (redundant as servlet already checked, but good practice)
        Boolean isLoggedIn = (Boolean) session.getAttribute("login");
        if (isLoggedIn == null || !isLoggedIn) {
            response.sendRedirect("login.jsp");
            return;
        }
    %>
    
    <div id="wrapper">
        <!-- page-title -->
        <div class="tf-page-title">
            <div class="container-full">
                <div class="heading text-center">My Orders</div>
            </div>
        </div>
        <!-- /page-title -->
        
        <!-- page-cart -->
        <section class="flat-spacing-11">
            <div class="container">
                <div class="row">
                    <div class="col-lg-3">
                        <ul class="my-account-nav">
                            <li><a href="${pageContext.request.contextPath}/accountDetails" class="my-account-nav-item">Account Details</a></li>
                            <li><span class="my-account-nav-item active">Orders</span></li>
                            <li><a href="my-account-address.jsp" class="my-account-nav-item">Addresses</a></li>
                            <li><a href="${pageContext.request.contextPath}/profile" class="my-account-nav-item">Account Update</a></li>
                            <li><a href="my-account-wishlist.jsp" class="my-account-nav-item">Wishlist</a></li>
                            <li><a href="${pageContext.request.contextPath}/logout" class="my-account-nav-item">Logout</a></li>
                        </ul>
                    </div>
                    <div class="col-lg-9">
                        <div class="my-account-content account-order">
                            <div class="wrap-account-order">
                                <% if (userOrders != null && !userOrders.isEmpty()) { %>
                                <table>
                                    <thead>
                                        <tr>
                                            <th class="fw-6">Order</th>
                                            <th class="fw-6">Date</th>
                                            <th class="fw-6">Status</th>
                                            <th class="fw-6">Total</th>
                                            <th class="fw-6">Address</th>
                                            <th class="fw-6">Payment</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <% for (Order order : userOrders) { %>
                                        <tr class="tf-order-item">
                                            <td>
                                                #<%= order.getOrderId() %>
                                            </td>
                                            <td>
                                                <%= dateFormat.format(order.getDate()) %>
                                            </td>
                                            <td>
                                                <%= order.getStatus() %>
                                            </td>
                                            <td>
                                                <%= priceFormat.format(order.getPrice()) %>
                                            </td>
                                            <td>
                                                <%= order.getAddress() %>
                                            </td>
                                            <td>
                                                <%= order.getPayType() %>
                                            </td>
                                        </tr>
                                        <% } %>
                                    </tbody>
                                </table>
                                <% } else { %>
                                <div class="text-center">
                                    <p>You have no orders yet.</p>
                                </div>
                                <% } %>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </section>
        <!-- page-cart -->
    </div>

    <!-- Javascript -->
    <script type="text/javascript" src="js/bootstrap.min.js"></script>
    <script type="text/javascript" src="js/jquery.min.js"></script>
    <script type="text/javascript" src="js/swiper-bundle.min.js"></script>
    <script type="text/javascript" src="js/carousel.js"></script>
    <script type="text/javascript" src="js/bootstrap-select.min.js"></script>
    <script type="text/javascript" src="js/lazysize.min.js"></script>
    <script type="text/javascript" src="js/count-down.js"></script>   
    <script type="text/javascript" src="js/wow.min.js"></script>
    <script type="text/javascript" src="js/multiple-modal.js"></script>
    <script type="text/javascript" src="js/main.js"></script>
</body>
</html>