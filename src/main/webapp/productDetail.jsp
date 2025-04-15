<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<jsp:useBean id="product" scope="request" type="iti.jets.entity.Product"/>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en-US" lang="en-US">


<!-- Mirrored from themesflat.co/html/ecomus/product-description-list.html by HTTrack Website Copier/3.x [XR&CO'2014], Mon, 02 Sep 2024 12:26:59 GMT -->
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
    <link rel="stylesheet" href="css/drift-basic.min.css">
    <link rel="stylesheet" href="css/photoswipe.css">
    <link rel="stylesheet" href="css/swiper-bundle.min.css">
    <link rel="stylesheet" href="css/animate.css">
   <link rel="stylesheet " type="text/css" href="css/styles.css"/>

    <!-- Favicon and Touch Icons  -->
    <link rel="shortcut icon" href="images/logo/favicon.png">
    <link rel="apple-touch-icon-precomposed" href="images/logo/favicon.png">

    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/toastr.min.css">
    <link href="https://cdn.jsdelivr.net/npm/sweetalert2@11.4.24/dist/sweetalert2.min.css" rel="stylesheet">




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
                        <a href="home" class="logo-header">
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
                            <li class="nav-cart"><a href="cart" class="nav-icon-item"><i class="icon icon-bag"></i><span class="count-box"><%= cartSize != null ? cartSize : 0 %></span></a></li>
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

        <!-- default -->
        <section class="flat-spacing-4 pt_0">
            <jsp:useBean id="imgList" scope="request" type="java.util.List"/>
            <div class="tf-main-product section-image-zoom">
                <div class="container">
                    <div class="row">
                        <div class="col-md-6">
                            <div class="tf-product-media-wrap sticky-top">
                                <div class="thumbs-slider">
                                    <div class="swiper tf-product-media-thumbs other-image-zoom" data-direction="vertical">
                                        <div class="swiper-wrapper stagger-wrap">

                                            <c:forEach var="img" items="${imgList}">
                                                <div class="swiper-slide stagger-item">
                                                    <div class="item">

                                                        <img class="lazyload" data-src="${pageContext.request.contextPath}/../products/${product.productId}/${img}" src="${pageContext.request.contextPath}/../products/${product.productId}/${img}" alt="${product.productName} image">
                                                    </div>
                                                </div>
                                            </c:forEach>
                                        </div>
                                    </div>
                                    <div class="swiper tf-product-media-main" id="gallery-swiper-started">
                                        <div class="swiper-wrapper" >
                                            <c:forEach var="img" items="${imgList}">
                                                <div class="swiper-slide">
                                                    <a href="${pageContext.request.contextPath}/../products/${product.productId}/${img}" target="_blank" class="item" data-pswp-width="770px" data-pswp-height="1075px">
                                                        <img class="tf-image-zoom lazyload" data-zoom="${pageContext.request.contextPath}/../products/${product.productId}/${img}" data-src="${pageContext.request.contextPath}/../products/${product.productId}/${img}" src="${pageContext.request.contextPath}/../products/${product.productId}/${img}" alt="${product.productName}">
                                                    </a>
                                                </div>
                                            </c:forEach>
                                        </div>
                                        <div class="swiper-button-next button-style-arrow thumbs-next"></div>
                                        <div class="swiper-button-prev button-style-arrow thumbs-prev"></div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-6">
                            <div class="tf-product-info-wrap position-relative">
                                <div class="tf-zoom-main"></div>
                                <div class="tf-product-info-list other-image-zoom">
                                    <input type="hidden" name="productId" value="${product.productId}" />
                                    <div class="tf-product-info-title">
                                        <h5>${product.productName}</h5>
                                    </div>
                                    <div class="tf-product-info-price">
                                        <div id = "price"class="price">$${product.price}</div>
                                    </div>

                                    <c:choose>
                                        <c:when test="${product.quantity>0}">
                                            <div class="tf-product-info-quantity">
                                                <div class="quantity-title fw-6">Quantity</div>
                                                <div class="wg-quantity">
                                                    <span class="btn-quantity minus-btn">-</span>
                                                    <input id ="quantity-1" type="number" name="quantity" value="1" disabled>
                                                    <span class="btn-quantity plus-btn">+</span>
                                                </div>
                                            </div>
                                        </c:when>
                                    </c:choose>
                                    <div class="tf-product-info-buy-button">
                                        <form id="form-1" class="" >
                                        <c:choose>
                                            <c:when test="${product.quantity>0}">
                                                <button type="submit" class="tf-btn btn-fill justify-content-center fw-6 fs-16 flex-grow-1 animate-hover-btn ">
                                                    <span>Add to cart -&nbsp;</span><span id="total-price" class="tf-qty-price">$${product.price}</span>
                                                </button>
                                            </c:when>
                                            <c:otherwise>
                                                <a class="tf-btn btns-sold-out cursor-not-allowed btn-fill justify-content-center fw-6 fs-16 flex-grow-1 animate-hover-btn ">
                                                    <span>Sold out -&nbsp;</span><span class="tf-qty-price">$${product.price}</span>
                                                </a>
                                            </c:otherwise>
                                        </c:choose>
                                        <a href="javascript:void(0);" class="tf-product-btn-wishlist hover-tooltip box-icon bg_white wishlist btn-icon-action">
                                            <span class="icon icon-heart"></span>
                                            <span class="tooltip">Add to Wishlist</span>
                                            <span class="icon icon-delete"></span>
                                        </a>
                                        </form>
                                    </div>
                                    <div class="tf-product-info-delivery-return">
                                        <div class="row">
                                            <div class="col-xl-6 col-12">
                                                <div class="tf-product-delivery">
                                                    <div class="icon">
                                                        <i class="icon-delivery-time"></i>
                                                    </div>
                                                    <p>Estimate delivery times: <span class="fw-7">12-26 days</span> (International), <span class="fw-7">3-6 days</span> (United States).</p>
                                                </div>
                                            </div>
                                            <div class="col-xl-6 col-12">
                                                <div class="tf-product-delivery mb-0">
                                                    <div class="icon">
                                                        <i class="icon-return-order"></i>
                                                    </div>
                                                    <p>Return within <span class="fw-7">30 days</span> of purchase. Duties & taxes are non-refundable.</p>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="tf-product-info-trust-seal">
                                        <div class="tf-product-trust-mess">
                                            <i class="icon-safe"></i>
                                            <p class="fw-6">Guarantee Safe <br> Checkout</p>
                                        </div>
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
            </div>
            <div class="tf-sticky-btn-atc">
                <div class="container">
                    <div class="tf-height-observer w-100 d-flex align-items-center">
                        <div class="tf-sticky-atc-product d-flex align-items-center">
                            <div class="tf-sticky-atc-img">
                                <img class="lazyloaded"
                                <c:choose>
                                    <c:when test="${not empty imgList}">
                                        <img class="lazyloaded"
                                             data-src="${pageContext.request.contextPath}/../products/${product.productId}/${imgList[0]}"
                                             src="${pageContext.request.contextPath}/../products/${product.productId}/${imgList[0]}"
                                             alt="${product.productName} image">
                                    </c:when>
                                    <c:otherwise>
                                        <img class="lazyloaded"
                                             data-src="${pageContext.request.contextPath}/../products/${product.productId}/1.jpg"
                                             src="${pageContext.request.contextPath}/../products/${product.productId}/1.jpg"
                                             alt="${product.productName} image">
                                    </c:otherwise>
                                </c:choose>
                            </div>
                            <div class="tf-sticky-atc-title fw-5 d-xl-block d-none">${product.productName}</div>
                        </div>
                        <div class="tf-sticky-atc-infos">
                            <form id = "form-2" class="" action="addtocart" method="POST">
                                <input type="hidden" name="productId" value="${product.productId}" />
                                <div class="tf-sticky-atc-btns">
                                    <c:choose>
                                        <c:when test="${product.quantity>0}">
                                    <div class="tf-product-info-quantity">
                                        <div class="wg-quantity">
                                            <span class="btn-quantity minus-btn">-</span>
                                            <input id="quantity-2" type="number" name="number" value="1" disabled>
                                            <span class="btn-quantity plus-btn">+</span>
                                        </div>
                                    </div>

                                            <button type="submit"
                                                    class="tf-btn btn-fill radius-3 justify-content-center fw-6 fs-14 flex-grow-1 animate-hover-btn ">
                                                <span>Add to cart</span>
                                            </button>
                                        </c:when>
                                        <c:otherwise>
                                            <a class="tf-btn btns-sold-out cursor-not-allowed btn-fill radius-3 justify-content-center fw-6 fs-14 flex-grow-1 animate-hover-btn ">
                                                <span>Sold out</span>
                                            </a>
                                        </c:otherwise>
                                    </c:choose>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </section>
        <!-- /default -->

        <!-- list -->
        <section class="flat-spacing-10">
            <div class="container">
                <div class="row">
                    <div class="col-12">

                        <div class="d-flex flex-column gap-20">
                            <div>
                                <div class="lg_fs_18 fw-6 line py_15">Description</div>
                                <div class="py_20 lg_py_30">
                                    <p class="mb_30">${product.description}</p>
                                </div>
                            </div>

                            <div>
                                <div class="lg_fs_18 fw-6 line py_15">Return Policies</div>
                                <div class="py_20 lg_py_30">
                                    <div class="tf-page-privacy-policy">
                                        <div class="title">The Company Private Limited Policy</div>
                                        <p>The Company Private Limited and each of their respective subsidiary, parent and affiliated companies is deemed to operate this Website (“we” or “us”) recognizes that you care how information about you is used and shared. We have created this Privacy Policy to inform you what information we collect on the Website, how we use your information and the choices you have about the way your information is collected and used. Please read this Privacy Policy carefully. Your use of the Website indicates that you have read and accepted our privacy practices, as outlined in this Privacy Policy.</p>
                                        <p>Please be advised that the practices described in this Privacy Policy apply to information gathered by us or our subsidiaries, affiliates or agents: (i) through this Website, (ii) where applicable, through our Customer Service Department in connection with this Website, (iii) through information provided to us in our free standing retail stores, and (iv) through information provided to us in conjunction with marketing promotions and sweepstakes.</p>
                                        <p>We are not responsible for the content or privacy practices on any websites.</p>
                                        <p>We reserve the right, in our sole discretion, to modify, update, add to, discontinue, remove or otherwise change any portion of this Privacy Policy, in whole or in part, at any time. When we amend this Privacy Policy, we will revise the “last updated” date located at the top of this Privacy Policy.</p>
                                        <p>If you provide information to us or access or use the Website in any way after this Privacy Policy has been changed, you will be deemed to have unconditionally consented and agreed to such changes. The most current version of this Privacy Policy will be available on the Website and will supersede all previous versions of this Privacy Policy.</p>
                                        <p>If you have any questions regarding this Privacy Policy, you should contact our Customer Service Department by email at marketing@company.com</p>
                                    </div>
                                </div>
                            </div>

                        </div>
                    </div>
                </div>
            </div>
        </section>
        <!-- /list -->

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


    <!-- Javascript -->
    <script type="text/javascript" src="js/bootstrap.min.js"></script>
    <script type="text/javascript" src="js/jquery.min.js"></script>
    <script type="text/javascript" src="js/swiper-bundle.min.js"></script>
    <script type="text/javascript" src="js/carousel.js"></script>
    <script type="text/javascript" src="js/count-down.js"></script>
    <script type="text/javascript" src="js/bootstrap-select.min.js"></script>
    <script type="text/javascript" src="js/lazysize.min.js"></script>
    <script type="text/javascript" src="js/bootstrap-select.min.js"></script>
    <script type="text/javascript" src="js/drift.min.js"></script>
    <script type="text/javascript" src="js/wow.min.js"></script>
    <script type="text/javascript" src="js/multiple-modal.js"></script>
    <script type="text/javascript" src="js/main.js"></script>
    <script type="module" src="js/model-viewer.min.js"></script>
    <script type="module" src="js/zoom.js"></script>
    <script type="text/javascript" src="js/search.js"></script>
    <script type="text/javascript" src="js/productDetail.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/toastr.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>



    <script type="text/javascript">
        window.isLoggedIn = '${login}'; // sets a JS global from the session
        var p = {
            productId : ${product.productId},
            productName: "${product.productName}",
            price: ${product.price},
            description: "${product.description}"
        };
    </script>


</body>

</html>