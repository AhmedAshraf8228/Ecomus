<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en-US" lang="en-US">
<head>
    <meta charset="utf-8">
    <title>Ecomus - checkout</title>


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

    <!-- SweetAlert2 CSS -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/sweetalert2@11/dist/sweetalert2.min.css">

    <!-- Custom styles for centered layout -->
    <style>
        .checkout-container {
            max-width: 1200px;
            margin: 0 auto;
            padding: 20px;
        }
        
        .checkout-form-container {
            background-color: #fff;
            border-radius: 8px;
            box-shadow: 0 0 20px rgba(0,0,0,0.1);
            padding: 30px;
            margin-bottom: 40px;
        }
        
        @media (max-width: 767px) {
            .checkout-column {
                margin-bottom: 30px;
            }
        }
        
        .checkout-title {
            font-size: 24px;
            margin-bottom: 25px;
            font-weight: 600;
        }
        
        .checkout-section {
            padding: 20px;
            background-color: #f9f9f9;
            border-radius: 5px;
            height: 100%;
        }
    </style>
</head>

<body class="preload-wrapper">
    <!-- preload -->
    <div class="preload preload-container">
        <div class="preload-logo">
            <div class="spinner"></div>
        </div>
    </div>
    <!-- /preload -->
    <div id="wrapper">

        <!-- header -->
        <header id="header" class="header-default">
            <div class="px_15 lg-px_40">
                <div class="row wrapper-header align-items-center">
                    <div class="col-xl-3 col-md-3 col-3">
                        <a href="${pageContext.request.contextPath}/home" class="logo-header">
                            <img src="images/logo/logo.svg" alt="logo" class="logo">
                        </a>
                    </div>
                    <div class="col-xl-6 col-md-6 col-6">
                    </div>
                    <div class="col-xl-3 col-md-3 col-3">
                        <ul class="nav-icon d-flex justify-content-end align-items-center gap-20">

                            <% Integer cartSize = (Integer) session.getAttribute("cart-size"); %>
                            <li class="nav-account"><a href="${pageContext.request.contextPath}/accountDetails" class="nav-icon-item"><i class="icon icon-account"></i></a></li>
                            <li class="nav-wishlist"><a href="my-account-wishlist.jsp" class="nav-icon-item"><i class="icon icon-heart"></i><span class="count-box">0</span></a></li>
                            <li class="nav-cart"><a href="${pageContext.request.contextPath}/cart" class="nav-icon-item"><i class="icon icon-bag"></i><span class="count-box"><%= cartSize != null ? cartSize : 0 %></span></a></li>
                        </ul>
                    </div>
                </div>
            </div>
        </header>

        <!-- /header -->
      
        <!-- page-title -->
        <div class="tf-page-title">
            <div class="container-full">
                <div class="heading text-center">Check Out</div>
            </div>
        </div>
        <!-- /page-title -->
        
        <!-- page-cart -->
        <section class="flat-spacing-11">
            <!-- Custom container for centered content -->
            <div class="checkout-container">
                <div class="checkout-form-container">
                    <form id="checkoutForm" class="form-checkout" method="post" action="<c:url value='/processCheckout' />">
                        <!-- Row container for side-by-side layout -->
                        <div class="row">
                            <!-- Left column for customer details -->
                            <div class="col-lg-6 checkout-column">
                                <div class="checkout-section">
                                    <h4 class="checkout-title">Customer Information</h4>
                                    <div class="tf-page-cart-item">
                                        <fieldset class="fieldset">
                                            <label for="last-name">Name</label>
                                            <input type="text" id="last-name" name="customerName" value="${user.userName}" readonly>
                                        </fieldset>
                                        
                                        <fieldset class="box fieldset">
                                            <label for="city">Town/City</label>
                                            <input type="text" id="city" name="city" value="${user.city}" required>
                                        </fieldset>
                                        <div class="box grid-3">
                                            <fieldset class="box fieldset">
                                                <label for="area">Area</label>
                                                <input type="text" id="area" name="area" value="${user.area}" required>
                                            </fieldset>
                                            <fieldset class="box fieldset">
                                                <label for="street">Street</label>
                                                <input type="text" id="street" name="street" value="${user.street}" required>
                                            </fieldset>
                                            <fieldset class="box fieldset">
                                                <label for="buildingNum">Building Number</label>
                                                <input type="text" id="buildingNum" name="buildingNum" value="${user.buildingNo}" required>
                                            </fieldset>
                                        </div>
                                        <fieldset class="box fieldset">
                                            <label for="phone">Phone Number</label>
                                            <input type="number" id="phone" name="phone" value="${user.phone}" readonly>
                                        </fieldset>
                                    </div>
                                </div>
                            </div>
                            
                            <!-- Right column for order summary -->
                            <div class="col-lg-6 checkout-column">
                                <div class="checkout-section">
                                    <h4 class="checkout-title">Order Summary</h4>
                                    <div class="tf-page-cart-footer">
                                        <div class="tf-cart-footer-inner">
                                            <div class="tf-page-cart-checkout widget-wrap-checkout">
                                                <ul class="wrap-checkout-product">
                                                    <c:choose>
                                                        <c:when test="${not empty cartItems}">
                                                            <c:forEach items="${cartItems}" var="cartItem">
                                                            <li class="checkout-product-item">
                                                                <figure class="img-product">
                                                                    <img src="${pageContext.request.contextPath}/../products/${cartItem.productId}/1.jpg" alt="${pageContext.request.contextPath}/../products/1.jpg">
                                                                    <span class="quantity">${cartItem.quantity}</span>
                                                                </figure>
                                                                <div class="content">
                                                                    <div class="info">
                                                                        <p class="name">${cartItem.product.productName}</p>
                                                                    </div>
                                                                    <span class="price">$${cartItem.product.price}</span>
                                                                </div>
                                                            </li>
                                                            </c:forEach>
                                                        </c:when>
                                                        <c:otherwise>
                                                            <li>No items in cart</li>
                                                        </c:otherwise>
                                                    </c:choose>
                                                </ul>
                                             
                                                <div class="d-flex justify-content-between line pb_20">
                                                    <h6 class="fw-5">Total</h6>
                                                    <h6 class="total fw-5">
                                                        <fmt:formatNumber value="${empty total ? 0 : total}" type="currency" />
                                                    </h6>
                                                </div>
                                                
                                                <div class="wd-check-payment">
                                                    <div class="fieldset-radio mb_20">
                                                        <input type="radio" name="payment" id="delivery" value="cash" class="tf-check" ${paymentMethod == 'cash' ? 'checked' : ''}>
                                                        <label for="delivery">Cash on delivery</label>
                                                    </div>
                                                    <div class="fieldset-radio mb_20">
                                                        <input type="radio" name="payment" id="bank" value="credit" class="tf-check" ${paymentMethod == 'credit' or empty paymentMethod ? 'checked' : ''}>
                                                        <label for="bank">Credit Card</label>
                                                    </div>
                                                   
                                                    <p class="text_black-2 mb_20">Your personal data will be used to process your order, support your experience throughout this website, and for other purposes described in our <a href="privacy-policy.html" class="text-decoration-underline">privacy policy</a>.</p>
                                                    <div class="box-checkbox fieldset-radio mb_20">
                                                        <input type="checkbox" id="check-agree" name="termsAgreed" class="tf-check" required>
                                                        <label for="check-agree" class="text_black-2">I have read and agree to the website <a href="terms-conditions.html" class="text-decoration-underline">terms and conditions</a>.</label>
                                                    </div>
                                                </div>
                                                <button type="submit" class="tf-btn radius-3 btn-fill btn-icon animate-hover-btn justify-content-center">Confirm order</button>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </form>
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

    

    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>

 <script>
    $(document).ready(function() {
    $("#checkoutForm").submit(function(e) {
        e.preventDefault();
        
        $.ajax({
            type: "POST",
            url: "${pageContext.request.contextPath}/checkInventory",
            dataType: "json",
            success: function(response) {
                if (response.success) {
                    if (response.hasInventoryIssues) {
                        let message = "The following products have insufficient inventory:<br><br>";
                        let issueTable = "<table class='table'><thead><tr><th>Product</th><th>Requested</th><th>Available</th></tr></thead><tbody>";
                        
                        response.inventoryIssues.forEach(function(issue) {
                            issueTable += "<tr><td>" + issue.productName + "</td><td>" + 
                                        issue.requestedQuantity + "</td><td>" + 
                                        issue.availableQuantity + "</td></tr>";
                        });
                        
                        issueTable += "</tbody></table>";
                        
                        Swal.fire({
                            icon: 'warning',
                            title: 'Inventory Issues',
                            html: message + issueTable + "<br>Would you like to proceed with the available quantities?",
                            showCancelButton: true,
                            confirmButtonText: 'Yes, proceed',
                            cancelButtonText: 'No, cancel',
                            allowOutsideClick: false
                        }).then((result) => {
                            if (result.isConfirmed) {
                                processCheckout(true);
                            }
                        });
                    } else {
                        processCheckout(false);
                    }
                } else {
                    Swal.fire({
                        icon: 'error',
                        title: 'Error',
                        text: response.error || 'Something went wrong checking inventory.',
                        confirmButtonText: 'OK'
                    });
                }
            },
            error: function(xhr, status, error) {
                console.error("Error checking inventory: " + error);
                Swal.fire({
                    icon: 'error',
                    title: 'Error',
                    text: 'Failed to check inventory: ' + error,
                    confirmButtonText: 'OK'
                });
            }
        });
    });
    
    function processCheckout(acceptReducedQuantity) {
        let formData = $("#checkoutForm").serialize();
        if (acceptReducedQuantity) {
            formData += "&acceptReducedQuantity=true";
        }
        
        $("#checkoutForm button[type='submit']").prop('disabled', true);
        
        $.ajax({
            type: "POST",
            url: "${pageContext.request.contextPath}/processCheckout",
            data: formData,
            dataType: "json",
            success: function(response) {
                $("#checkoutForm button[type='submit']").prop('disabled', false);
                
                if (response.success) {
                    Swal.fire({
                        icon: 'success',
                        title: 'Thank you for your purchase!',
                        text: 'Your order has been received. Order ID: #' + response.orderId,
                        showConfirmButton: true,
                        confirmButtonText: 'Continue Shopping',
                        allowOutsideClick: false
                    }).then((result) => {
                        if (result.isConfirmed) {
                            window.location.href = "${pageContext.request.contextPath}/home";
                        }
                    });
                } else if (response.inventoryIssue) {
                    Swal.fire({
                        icon: 'error',
                        title: 'Inventory Issue',
                        text: response.message,
                        confirmButtonText: 'OK'
                    });
                } else if (response.creditLimitIssue) {
                    // Handle credit limit issues
                    Swal.fire({
                        icon: 'error',
                        title: 'Credit Limit Issue',
                        html: response.message + '<br><br>Would you like to update your profile or choose a different payment method?',
                        showCancelButton: true,
                        confirmButtonText: 'Update Profile',
                        cancelButtonText: 'Choose Different Payment',
                        allowOutsideClick: false
                    }).then((result) => {
                        if (result.isConfirmed) {
                         
                            window.location.href = "${pageContext.request.contextPath}/profile";
                        } else {
                         
                            $('input[name="payment"][value="cash"]').prop('checked', true);
                        }
                    });
                } else {
                    Swal.fire({
                        icon: 'error',
                        title: 'Error',
                        text: response.error || 'Failed to process order.',
                        confirmButtonText: 'OK'
                    });
                }
            },
            error: function(xhr, status, error) {
                $("#checkoutForm button[type='submit']").prop('disabled', false);
                console.error("Error processing order: " + error);
                
                Swal.fire({
                    icon: 'error',
                    title: 'Oops...',
                    text: 'Something went wrong! Please try again later.',
                    confirmButtonText: 'OK'
                });
            }
        });
    }
});
 </script>

</body>
</html>