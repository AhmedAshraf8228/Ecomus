<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en-US" lang="en-US">


<!-- Mirrored from themesflat.co/html/ecomus/product-style-04.html by HTTrack Website Copier/3.x [XR&CO'2014], Mon, 02 Sep 2024 12:26:40 GMT -->
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
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/toastr.min.css">

</head>

<body class="preload-wrapper">
    <!-- preload -->
    <div class="preload preload-container">
        <div class="preload-logo">
            <div class="spinner"></div>
        </div>
    </div>
    <!-- /preload -->
    <div id="wrapper" >
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
                            <li class="nav-account"><a href="login.jsp" class="nav-icon-item"><i class="icon icon-account"></i></a></li>
                            <li class="nav-wishlist"><a href="my-account-wishlist.html" class="nav-icon-item"><i class="icon icon-heart"></i><span class="count-box">0</span></a></li>
                            <li class="nav-cart"><a href="view-cart.jsp" class="nav-icon-item"><i class="icon icon-bag"></i><span class="count-box"><%= cartSize != null ? cartSize : 0 %></span></a></li>
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
                <div class="row">
                    <div class="col-12">
                        <div class="heading text-center">Home</div>
                    </div>
                </div>
            </div>
        </div>
        <!-- /page-title -->


        <section class="flat-spacing-1">
            <div class="container">
                <div class="tf-shop-control grid-3 align-items-center">
                    <div class="tf-control-filter">
                        <a href="#filterShop" data-bs-toggle="offcanvas" aria-controls="offcanvasLeft" class="tf-btn-filter"><span class="icon icon-filter"></span><span class="text">Filter</span></a>

                    </div>
                    <ul class="tf-control-layout d-flex justify-content-center">
                        <li class="tf-view-layout-switch sw-layout-2" data-value-grid="grid-2">
                            <div class="item"><span class="icon icon-grid-2"></span></div>
                        </li>
                        <li class="tf-view-layout-switch sw-layout-3" data-value-grid="grid-3">
                            <div class="item"><span class="icon icon-grid-3"></span></div>
                        </li>
                        <li class="tf-view-layout-switch sw-layout-4 active" data-value-grid="grid-4">
                            <div class="item"><span class="icon icon-grid-4"></span></div>
                        </li>
                        <li class="tf-view-layout-switch sw-layout-5" data-value-grid="grid-5">
                            <div class="item"><span class="icon icon-grid-5"></span></div>
                        </li>
                        <li class="tf-view-layout-switch sw-layout-6" data-value-grid="grid-6">
                            <div class="item"><span class="icon icon-grid-6"></span></div>
                        </li>
                    </ul>
                    <div class="filter-summary text-center mt_10">
                        <span id="filter-count" class="badge bg_primary fs-14 fw-6 px-3 py-1 radius-5 " >0 Filters Applied</span>
                    </div>
                </div>
                <div id="product-list" class="grid-layout wrapper-shop" data-grid="grid-4">
                </div>
            </div>
        </section>
        

        <!-- footer -->
        <footer id="footer" class="footer">
            <div class="footer-wrap">
                <div class="footer-bottom">
                    <div class="container">
                        <div class="row">
                            <div class="col-12">
                                <div class="footer-bottom-wrap d-flex gap-20 flex-wrap justify-content-between align-items-center">
                                    <div class="footer-menu_item">© 2024 Ecomus Store. All Rights Reserved</div>
                                    <div class="tf-payment">
                                        <img src="images/payments/visa.png" alt="">
                                        <img src="images/payments/img-1.png" alt="">
                                        <img src="images/payments/img-2.png" alt="">
                                        <img src="images/payments/img-3.png" alt="">
                                        <img src="images/payments/img-4.png" alt="">
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </footer>
        <!-- /footer -->

    </div>

    <!-- gotop -->
    <div class="progress-wrap">
        <svg class="progress-circle svg-content" width="100%" height="100%" viewBox="-1 -1 102 102">
        <path d="M50,1 a49,49 0 0,1 0,98 a49,49 0 0,1 0,-98" style="transition: stroke-dashoffset 10ms linear 0s; stroke-dasharray: 307.919, 307.919; stroke-dashoffset: 286.138;"></path>
        </svg>
    </div>
    <!-- /gotop -->


    <!-- Filter -->
    <div class="offcanvas offcanvas-start canvas-filter" id="filterShop">
        <div class="canvas-wrapper">
            <header class="canvas-header">
                <div class="filter-icon">
                    <span class="icon icon-filter"></span>
                    <span>Filter</span>
                </div>
                <span class="icon-close icon-close-popup" data-bs-dismiss="offcanvas" aria-label="Close"></span>
            </header>
            <div class="canvas-body">
                <form action="#" id="facet-filter-form" class="facet-filter-form">
                <div class="widget-facet wd-categories">
                    <div class="facet-title" data-bs-target="#categories" data-bs-toggle="collapse" aria-expanded="true" aria-controls="categories">
                        <span>Product categories</span>
                        <span class="icon icon-arrow-up"></span>
                    </div>
                    <div id="categories" class="collapse show">
                        <ul class="list-categoris current-scrollbar mb_36">
                            <jsp:useBean id="categories" scope="request" type="java.util.List"/>

                            <c:forEach var="cat" items="${categories}">
                            <li class="list-item d-flex gap-12 align-items-center">
                                <input type="checkbox" name="categoryIds" class="tf-check" id="${cat.categoryId}" value="${cat.categoryName}">
                                <label for="${cat.categoryId}" class="label"><span>${cat.categoryName}</span></label>
                            </li>
                            </c:forEach>

                        </ul>
                    </div>
                </div>

                    <div class="widget-facet">
                        <div class="facet-title" data-bs-target="#availability" data-bs-toggle="collapse" aria-expanded="true" aria-controls="availability">
                            <span>Availability</span>
                            <span class="icon icon-arrow-up"></span>
                        </div>
                        <div id="availability" class="collapse show">
                            <ul class="tf-filter-group current-scrollbar mb_36">
                                <li class="list-item d-flex gap-12 align-items-center">
                                    <input type="checkbox" name="availability" class="tf-check" id="availability-1" value="in">
                                    <label for="availability-1" class="label"><span>In stock</span></label>
                                </li>
                                <li class="list-item d-flex gap-12 align-items-center">
                                    <input type="checkbox" name="availability" class="tf-check" id="availability-2" value="out">
                                    <label for="availability-2" class="label"><span>Out of stock</span></label>
                                </li>
                            </ul>
                        </div>
                    </div>
                    <div class="widget-facet">
                        <div class="facet-title" data-bs-target="#price" data-bs-toggle="collapse" aria-expanded="true" aria-controls="price">
                            <span>Price</span>
                            <span class="icon icon-arrow-up"></span>
                        </div>


                        <div id="price" class="collapse show">
                            <div class="widget-price">
                                <div id="slider-range"></div>

                                <div class="box-title-price mt_15">
                                    <div class="title-wrapper mb_10">
                                        <span class="title-price fw-6 ">Range</span>
                                    </div>
                                    <div class="caption-price  mt_10">
                                        <div class="price-box">
                                            <label for="min-price">start ($)</label>
                                            <input type="number" id="min-price" class="price-input" />
                                        </div>
                                        <div class="price-box">
                                            <label for="max-price" class="">end ($)</label>
                                            <input type="number" id="max-price" class="price-input">
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <button id="filter" class="tf-btn btn-fill justify-content-center fw-6 fs-16 flex-grow-1 animate-hover-btn w-100" >
                        <span>APPLY FILTER</span>
                    </button><br>
                    <button type="button" id="clear-filters" class="tf-btn btn-fill justify-content-center fw-6 fs-16 flex-grow-1 animate-hover-btn w-100 ">
                        <span>CLEAR ALL FILTERS</span>
                    </button>

                </form>    
            </div>
            
        </div>       
    </div>
    <!-- End Filter -->
    
    <!-- modal quick_add -->
    <div class="modal fade modalDemo quickModal" id="quick_add">
        <div class="modal-dialog modal-dialog-centered">
            <div class="modal-content">
                <input id="quick-add-product-id " class="quick-product-id" type="hidden">
                <div class="header">
                    <span class="icon-close icon-close-popup" data-bs-dismiss="modal"></span>
                </div>
                <div class="wrap">
                    <div class="tf-product-info-item">
                        <div class="image">
                            <img id="quick-add-image" src="" alt="">
                        </div>
                        <div class="content">
                            <a id="quick-add-name" class="quick-product-name" href="productDetail.html">name</a>
                            <div class="tf-product-info-price">
                                <div id="quick-add-price" class="price quick-product-price">$price</div>
                            </div>
                        </div>
                    </div>
                    <div class="tf-product-info-quantity mb_15">
                        <div class="quantity-title fw-6">Quantity</div>
                        <div class="wg-quantity">
                            <span class="btn-quantity minus-btn quick-add-btn">-</span>
                            <input id="quick-add-quantity" class="quick-product-quantity" type="text" name="number" value="1" disabled>
                            <span class="btn-quantity plus-btn quick-add-btn">+</span>
                        </div>
                    </div>
                    <div class="tf-product-info-buy-button">
                        <form class="">
                            <button id="quick-add-addToCart" class="tf-btn btn-fill justify-content-center fw-6 fs-16 flex-grow-1 animate-hover-btn quick-product-addToCart">
                                <span>Add to cart -&nbsp;</span><span id="quick-add-total" class="tf-qty-price quick-product-total">$total</span></button>
                            <div class="tf-product-btn-wishlist btn-icon-action">
                                <i class="icon-heart"></i>
                                <i class="icon-delete"></i>
                            </div>

                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!-- /modal quick_add -->

    <!-- modal quick_view -->
    <div class="modal fade modalDemo quickModal" id="quick_view">
        <div class="modal-dialog modal-dialog-centered">
            <div class="modal-content">
                <input type="hidden" id="quick-view-product-id"  class="quick-product-id"/>
                <div class="header">
                    <span class="icon-close icon-close-popup" data-bs-dismiss="modal"></span>
                </div>
                <div class="wrap">
                    <div class="tf-product-media-wrap">
                        <div class="swiper tf-single-slide">
                            <div id="quick-view-images" class="swiper-wrapper" >

                            </div>
                            <div class="swiper-button-next button-style-arrow single-slide-prev"></div>
                            <div class="swiper-button-prev button-style-arrow single-slide-next"></div>
                        </div>
                    </div>
                    <div class="tf-product-info-wrap position-relative">
                        <div class="tf-product-info-list">
                            <div class="tf-product-info-title">
                                <h5><a id="quick-view-name" class="link quick-product-name" href="productDetail.html">product name</a></h5>
                            </div>
                            <div class="tf-product-info-price">
                                <div id="quick-view-price" class="price quick-product-price">$prise</div>
                            </div>
                            <div class="tf-product-description">
                                <p id="quick-view-description" class="quick-product-description">description</p>
                            </div>
                            <div class="tf-product-info-quantity">
                                <div class="quantity-title fw-6">Quantity</div>
                                <div class="wg-quantity">
                                    <span class="btn-quantity minus-btn quick-view-btn" >-</span>
                                    <input id="quick-view-quantity" type="text" name="number"  class="quick-product-quantity" value="1" disabled>
                                    <span class="btn-quantity plus-btn quick-view-btn">+</span>
                                </div>
                            </div>
                            <div class="tf-product-info-buy-button">
                                <form class="">
                                    <button id="quick-view-addToCart" class="tf-btn btn-fill justify-content-center fw-6 fs-16 flex-grow-1 animate-hover-btn quick-product-addToCart" >
                                        <span>Add to cart -&nbsp;</span><span id="quick-view-total" class="tf-qty-price quick-product-total">$total</span></button>
                                    <a href="javascript:void(0);" class="tf-product-btn-wishlist hover-tooltip box-icon bg_white wishlist btn-icon-action">
                                        <span class="icon icon-heart"></span>
                                        <span class="tooltip">Add to Wishlist</span>
                                        <span class="icon icon-delete"></span>
                                    </a>
                                </form>
                            </div>
                            <div>
                                <a href="productDetail.html" class="tf-btn fw-6 btn-line">View full details<i class="icon icon-arrow1-top-left"></i></a>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!-- /modal quick_view -->

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
    <script src="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/toastr.min.js"></script>
    <script type="text/javascript" src="js/main.js"></script>
    <script type="text/javascript" src="js/search.js"></script>
    <script type="text/javascript" src="js/home.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>


    <script>
        window.products = [];
        <c:forEach var="product" items="${products}">
        window.products.push({
            id: ${product.productId},
            name: "${product.productName}",
            price: ${product.price},
            quantity: ${product.quantity},
            description: "${product.description}",
            categories: [
                <c:forEach var="cat" items="${product.categories}">
                "${cat.categoryName}",
                </c:forEach>
            ]
        });
        </c:forEach>
    </script>


    <script>
        window.isLoggedIn = '${login}'; // sets a JS global from the session

        window.productsImages = {};
        <c:forEach var="entry" items="${productsImages}">
        window.productsImages['${entry.key}'] = [
            <c:forEach var="img" items="${entry.value}">
            '${img}'<c:if test="${!img.equals(entry.value[entry.value.size()-1])}">,</c:if>
            </c:forEach>
        ];
        </c:forEach>

    </script>


</body>


</html>