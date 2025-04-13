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
                            <li><a href="my-account-address.jsp" class="my-account-nav-item">Addresses</a></li>
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
                            
                                    <div class="tf-field style-1 mb_15">
                                        <input class="tf-field-input tf-input" type="text" id="userName" name="userName" value="${user.userName}">
                                        <label for="userName">Username</label>
                                    </div>
                                    <div class="tf-field style-1 mb_15">
                                        <input class="tf-field-input tf-input" type="email" id="email" name="email" value="${user.email}">
                                        <label for="email">Email</label>
                                    </div>
                                    <div class="tf-field style-1 mb_15">
                                        <input class="tf-field-input tf-input" type="tel" id="phone" name="phone" value="${user.phone}">
                                        <label for="phone">Phone</label>
                                    </div>
                                    <div class="tf-field style-1 mb_15">
                                        <input class="tf-field-input tf-input" type="date" id="BD" name="BD" value="${user.BD}">
                                        <label for="BD">Birth Date</label>
                                    </div>
                                    <div class="tf-field style-1 mb_15">
                                        <input class="tf-field-input tf-input" type="text" id="job" name="job" value="${user.job}">
                                        <label for="job">Job</label>
                                    </div>
                            
                                    <h6>Address Information</h6>
                                    <div class="tf-field style-1 mb_15">
                                        <input class="tf-field-input tf-input" type="text" id="city" name="city" value="${user.city}">
                                        <label for="city">City</label>
                                    </div>
                                    <div class="tf-field style-1 mb_15">
                                        <input class="tf-field-input tf-input" type="text" id="area" name="area" value="${user.area}">
                                        <label for="area">Area</label>
                                    </div>
                                    <div class="tf-field style-1 mb_15">
                                        <input class="tf-field-input tf-input" type="text" id="street" name="street" value="${user.street}">
                                        <label for="street">Street</label>
                                    </div>
                                    <div class="tf-field style-1 mb_15">
                                        <input class="tf-field-input tf-input" type="text" id="buildingNo" name="buildingNo" value="${user.buildingNo}">
                                        <label for="buildingNo">Building Number</label>
                                    </div>
                            
                                    <h6>Payment Information</h6>
                                    <div class="tf-field style-1 mb_15">
                                        <input class="tf-field-input tf-input" type="text" id="creditNo" name="creditNo" value="${user.creditNo}">
                                        <label for="creditNo">Credit Card Number</label>
                                    </div>
                                    <div class="tf-field style-1 mb_15">
                                        <input class="tf-field-input tf-input" type="number" id="creditLimit" name="creditLimit" value="${user.creditLimit}">
                                        <label for="creditLimit">Credit Limit</label>
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