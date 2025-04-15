<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="iti.jets.entity.Order" %>
<%@ page import="iti.jets.enums.OrderStatus" %>
<%@ page import="java.util.List" %>
<%@ page import="java.text.SimpleDateFormat" %>

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
    
    <style>
        .cancel-btn {
            background: none;
            border: none;
            color: #FF4444;
            cursor: pointer;
            padding: 5px;
            transition: all 0.3s ease;
        }
        .cancel-btn:hover {
            transform: scale(1.2);
        }
        .PROCESSING {
            color: #FFA500;
        }
        .COMPLETED {
            color: #4CAF50;
        }
        .CANCELED {
            color: #FF4444;
        }
    </style>
</head>

<body class="preload-wrapper">
    <%
        // Get orders from request attribute (set by servlet)
        List<Order> userOrders = (List<Order>) request.getAttribute("userOrders");
        
        SimpleDateFormat dateFormat = new SimpleDateFormat("MMMM d, yyyy");
        
        // Check if user is logged in (redundant as servlet already checked, but good practice)
        Boolean isLoggedIn = (Boolean) session.getAttribute("login");
        if (isLoggedIn == null || !isLoggedIn) {
            response.sendRedirect("login.jsp");
            return;
        }
    %>
    
    <div id="wrapper">

        <!-- header -->
        <header id="header" class="header-default">
            <div class="px_15 lg-px_40">
                <div class="row wrapper-header align-items-center">
                    <div class="col-xl-3 col-md-3 col-3">
                        <a href="${pageContext.request.contextPath}/home" class="logo-header">
                            <img src="images/logo/BordMaster.svg" alt="logo" class="logo">
                        </a>
                    </div>
                    <div class="col-xl-6 col-md-6 col-6">
                    </div>
                    <div class="col-xl-3 col-md-3 col-3">
                        <ul class="nav-icon d-flex justify-content-end align-items-center gap-20">
                            <li class="nav-search">
                                <a href="#search" class="nav-icon-item text-decoration-none search-box search icon">
                                    <i class="icon icon-search"></i>
                                </a>
                            </li>
                            <% Integer cartSize = (Integer) session.getAttribute("cart-size"); %>
                            <li class="nav-account"><a href="${pageContext.request.contextPath}/accountDetails" class="nav-icon-item"><i class="icon icon-account"></i></a></li>
                            <li class="nav-wishlist"><a href="my-account-wishlist.html" class="nav-icon-item"><i class="icon icon-heart"></i><span class="count-box">0</span></a></li>
                            <li class="nav-cart"><a href="${pageContext.request.contextPath}/cart" class="nav-icon-item"><i class="icon icon-bag"></i><span class="count-box"><%= cartSize != null ? cartSize : 0 %></span></a></li>
                        </ul>
                    </div>
                </div>
            </div>
        </header>

        <!-- Search Form -->
        <div id="search" class="">
            <span class="close">X</span>
            <form role="search" id="searchform" method="get">
                <input value="" name="q" type="search" placeholder="Type to Search">
            </form>
        </div>

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
                                            <th class="fw-6">Actions</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <% for (Order order : userOrders) { %>
                                        <tr class="tf-order-item" id="order-<%= order.getOrderId() %>">
                                            <td>
                                                #<%= order.getOrderId() %>
                                            </td>
                                            <td>
                                                <%= dateFormat.format(order.getDate()) %>
                                            </td>
                                            <td>
                                                <span class="order-status <%= order.getStatus() %>">
                                                    <%= order.getStatus() %>
                                                </span>
                                            </td>
                                            <td>
                                                <%= order.getPrice() %>
                                            </td>
                                            <td>
                                                <%= order.getAddress() %>
                                            </td>
                                            <td>
                                                <%= order.getPayType() %>
                                            </td>
                                            <td>
                                                <% if (OrderStatus.PROCESSING.equals(order.getStatus())) { %>
                                                    <form method="post" action="${pageContext.request.contextPath}/cancel-order" style="display:inline;">
                                                        <input type="hidden" name="orderId" value="<%= order.getOrderId() %>">
                                                        <button type="submit" class="cancel-btn">
                                                            <span style="color: #FF4444;">✕</span>
                                                        </button>
                                                    </form>
                                                <% } %>
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
    <script type="text/javascript" src="js/jquery.min.js"></script>
    <script type="text/javascript" src="js/bootstrap.min.js"></script>
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