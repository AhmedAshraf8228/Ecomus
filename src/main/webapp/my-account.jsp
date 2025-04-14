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

    <style>
        .account-details-info {
            background-color: #f9f9f9;
            border-radius: 8px;
            padding: 25px;
            margin-top: 20px;
        }
        
        .info-label {
            font-weight: 600;
            color: #555;
            margin-bottom: 5px;
        }
        
        .info-value {
            font-size: 16px;
            padding: 5px 0;
        }
        
        .mb_15 {
            margin-bottom: 15px;
        }
        
        .mb_20 {
            margin-bottom: 20px;
        }
        
        .mb_30 {
            margin-bottom: 30px;
        }
        
        .mt_30 {
            margin-top: 30px;
        }
        
        .section-title {
            border-bottom: 1px solid #e5e5e5;
            padding-bottom: 10px;
            margin-bottom: 20px;
        }
    </style>
</head>

<body class="preload-wrapper">
    
    <div id="wrapper">
         <!-- header -->
 <header id="header" class="header-default">
    <div class="px_15 lg-px_40">
        <div class="row wrapper-header align-items-center">
            <div class="col-xl-3 col-md-3 col-3">
                <a href="home.jsp" class="logo-header">
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
<!-- /header -->
        <!-- page-title -->
        <div class="tf-page-title">
            <div class="container-full">
                <div class="heading text-center">My Account</div>
            </div>
        </div>
        <!-- /page-title -->
        
        <!-- page-cart -->
        <section class="flat-spacing-11">
            <div class="container">
                <div class="row">
                    <div class="col-lg-3">
                        <ul class="my-account-nav">
                            <li><span class="my-account-nav-item active">Account Details</span></li>
                            <li><a href="${pageContext.request.contextPath}/my-orders" class="my-account-nav-item">Orders</a></li>
                            <li><a href="my-account-address.html" class="my-account-nav-item">Addresses</a></li>
                            <li><a href="${pageContext.request.contextPath}/profile" class="my-account-nav-item">Update Account</a></li>
                            <li><a href="my-account-wishlist.html" class="my-account-nav-item">Wishlist</a></li>
                            <li><a href="${pageContext.request.contextPath}/logout" class="my-account-nav-item">Logout</a></li>
                        </ul>
                    </div>
                    <div class="col-lg-9">
                        <div class="my-account-content">
                            <div class="mb_30">
                                <c:if test="${not empty user}">
                                    <h5 class="fw-5 mb_20">Hello ${user.userName}</h5>
                                  
                                </c:if>
                            </div>
                            
                            <c:if test="${not empty user}">
                                <div class="account-details-info">
                                    <h5 class="section-title">Personal Information</h5>
                                    <div class="row mb_20">
                                        <div class="col-md-4 mb_15">
                                            <div class="info-label">Username</div>
                                            <div class="info-value">${user.userName}</div>
                                        </div>
                                        <div class="col-md-4 mb_15">
                                            <div class="info-label">Email</div>
                                            <div class="info-value">${user.email}</div>
                                        </div>
                                        <div class="col-md-4 mb_15">
                                            <div class="info-label">Phone</div>
                                            <div class="info-value">${user.phone}</div>
                                        </div>
                                    </div>
                                    
                                    <div class="row mb_20">
                                        <div class="col-md-4 mb_15">
                                            <div class="info-label">Birth Date</div>
                                            <div class="info-value">${user.BD}</div>
                                        </div>
                                        <div class="col-md-4 mb_15">
                                            <div class="info-label">Job</div>
                                            <div class="info-value">${user.job}</div>
                                        </div>
                                    </div>
                                    
                                    <h5 class="section-title mt_30">Address Information</h5>
                                    <div class="row mb_20">
                                        <div class="col-md-3 mb_15">
                                            <div class="info-label">City</div>
                                            <div class="info-value">${user.city}</div>
                                        </div>
                                        <div class="col-md-3 mb_15">
                                            <div class="info-label">Area</div>
                                            <div class="info-value">${user.area}</div>
                                        </div>
                                        <div class="col-md-3 mb_15">
                                            <div class="info-label">Street</div>
                                            <div class="info-value">${user.street}</div>
                                        </div>
                                        <div class="col-md-3 mb_15">
                                            <div class="info-label">Building No</div>
                                            <div class="info-value">${user.buildingNo}</div>
                                        </div>
                                    </div>
                                    
                                    <h5 class="section-title mt_30">Payment Information</h5>
                                    <div class="row mb_20">
                                        <div class="col-md-6 mb_15">
                                            <div class="info-label">Credit Card Number</div>
                                            <div class="info-value">
                                                <c:if test="${not empty user.creditNo}">
                                                    **** **** **** ${user.creditNo.substring(Math.max(0, user.creditNo.length() - 4))}
                                                </c:if>
                                                <c:if test="${empty user.creditNo}">
                                                    Not provided
                                                </c:if>
                                            </div>
                                        </div>
                                        <div class="col-md-6 mb_15">
                                            <div class="info-label">Credit Limit</div>
                                            <div class="info-value">
                                                <c:if test="${not empty user.creditLimit}">
                                                    $${user.creditLimit}
                                                </c:if>
                                                <c:if test="${empty user.creditLimit}">
                                                    Not provided
                                                </c:if>
                                            </div>
                                        </div>
                                    </div>
                                    
                                  
                                </div>
                            </c:if>
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