<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en-US" lang="en-US">
<head>
    <meta charset="utf-8">
    <title>Ecomus - Ultimate HTML</title>

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
                <div class="heading text-center">Edit Account</div>
            </div>
        </div>
        <!-- /page-title -->
        
        <!-- page-cart -->
        <section class="flat-spacing-11">
            <div class="container">
                <div class="row">
                    <div class="col-lg-3">
                        <ul class="my-account-nav">
                            <li><a href="${pageContext.request.contextPath}/accountDetails" class="my-account-nav-item ">Account Details</a></li>
                            <li><a href="${pageContext.request.contextPath}/my-orders" class="my-account-nav-item">Orders</a></li>
                            <li><span class="my-account-nav-item active">Account Update</span></li>
                            <li><a href="my-account-wishlist.jsp" class="my-account-nav-item">Wishlist</a></li>
                            <li><a href="${pageContext.request.contextPath}/logout" class="my-account-nav-item">Logout</a></li>
                        </ul>
                    </div>
                    <div class="col-lg-9">
                        <div class="my-account-content account-edit">
                            <!-- Success/Error Message Alert -->
                            <c:if test="${not empty message}">
                                <div class="alert ${messageType == 'success' ? 'alert-success' : 'alert-danger'}" role="alert">
                                    ${message}
                                </div>
                            </c:if>
                            
                            <!-- Debug info - can remove after fixing -->
                            <c:if test="${user != null}">
                                <!-- User data found -->
                            </c:if>
                            <c:if test="${user == null}">
                                <p>No user data available</p>
                            </c:if>

                            <div class="">
                                <form id="form-account-update" action="updateAccount" method="post">
                                    <input type="hidden" name="userId" value="${user.userId}">
                                    <h5>Personal Information</h5><br>
                                    <div class="tf-field style-1 mb_15">
                                        <label for="userName">Username</label>
                                        <input class="tf-field-input tf-input" type="text" id="userName" name="userName" value="${user.userName}">

                                    </div>
                                    <div class="tf-field style-1 mb_15">
                                        <label for="email">Email</label>
                                        <input class="tf-field-input tf-input" type="email" id="email" name="email" value="${user.email}" readonly>

                                    </div>
                                    <div class="tf-field style-1 mb_15">
                                        <label for="phone">Phone</label>
                                        <input class="tf-field-input tf-input" type="tel" id="phone" name="phone" value="${user.phone}">

                                    </div>
                                    <div class="tf-field style-1 mb_15">
                                        <label for="BD">Birth Date</label>
                                        <input class="tf-field-input tf-input" type="date" id="BD" name="BD" value="${user.BD}">

                                    </div>
                                    <div class="tf-field style-1 mb_15">
                                        <label for="job">Job</label>
                                        <input class="tf-field-input tf-input" type="text" id="job" name="job" value="${user.job}">

                                    </div>

                                    <h5>Address Information</h5><br>
                                    <div class="tf-field style-1 mb_15">
                                        <label for="city">City</label>
                                        <input class="tf-field-input tf-input" type="text" id="city" name="city" value="${user.city}">

                                    </div>
                                    <div class="tf-field style-1 mb_15">
                                        <label for="area">Area</label>
                                        <input class="tf-field-input tf-input" type="text" id="area" name="area" value="${user.area}">

                                    </div>
                                    <div class="tf-field style-1 mb_15">
                                        <label for="street">Street</label>
                                        <input class="tf-field-input tf-input" type="text" id="street" name="street" value="${user.street}">

                                    </div>
                                    <div class="tf-field style-1 mb_15">
                                        <label for="buildingNo">Building Number</label>
                                        <input class="tf-field-input tf-input" type="text" id="buildingNo" name="buildingNo" value="${user.buildingNo}">

                                    </div>

                                    <h5>Payment Information</h5><br>
                                    <div class="tf-field style-1 mb_15">
                                        <label for="creditNo">Credit Card Number</label>
                                        <input class="tf-field-input tf-input" type="text" id="creditNo" name="creditNo" value="${user.creditNo}">

                                    </div>
                                    <div class="tf-field style-1 mb_15">
                                        <label for="creditLimit">Credit Limit</label>
                                        <input class="tf-field-input tf-input" type="number" id="creditLimit" name="creditLimit" value="${user.creditLimit}">

                                    </div>

                                    <div class="mb_20">
                                        <button type="submit" class="tf-btn w-100 radius-3 btn-fill animate-hover-btn justify-content-center">Save Changes</button>
                                    </div>
                                </form>
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