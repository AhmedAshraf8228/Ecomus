<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en-US" lang="en-US">
<head>
    <meta charset="utf-8">
    <title>Your Cart - Ecomus</title>

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
    <link rel="stylesheet" type="text/css" href="css/placeorder.css"/>

    <!-- Favicon and Touch Icons  -->
    <link rel="shortcut icon" href="images/logo/favicon.png">
    <link rel="apple-touch-icon-precomposed" href="images/logo/favicon.png">
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
            <div class="heading text-center">Shopping Cart</div>
        </div>
    </div>
    <!-- /page-title -->
    
<!-- page-cart -->
<section class="flat-spacing-11">
    <div class="container">
        <div class="tf-page-cart-wrap">
            <div class="tf-page-cart-item">
                <c:choose>
                    <c:when test="${cartIsEmpty || empty cartItems}">
                        <!-- Display empty cart message -->
                        <div class="empty-cart-message" style="text-align: center; padding: 30px;">
                            <h3 style="margin-bottom: 15px;">Your cart is empty</h3>
                            <p style="margin-bottom: 20px;">Looks like you haven't added any items to your cart yet.</p>
                            <a href="shop" class="tf-button">Continue Shopping</a>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <!-- Display cart with items -->
                        <form>
                            <table class="tf-table-page-cart">
                                <thead>
                                    <tr>
                                        <th>Product</th>
                                        <th>Price</th>
                                        <th>Quantity</th>
                                        <th>Total</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach var="cartItem" items="${cartItems}">
                                        <tr class="tf-cart-item file-delete">
                                            <td class="tf-cart-item_product">
                                                <a href="product-detail.html" class="img-box">
                                                    <img src="images/products/7/1.jpg" alt="${cartItem.product.productName}">
                                                </a>
                                                <div class="cart-info">
                                                    <a href="product-detail.html" class="cart-title link">${cartItem.product.productName}</a>
                                                    <span class="productRemove" data-product-id="${cartItem.productId}" style="cursor: pointer; color: red;">Remove</span>
                                                </div>
                                            </td>
                                            
                                            <td class="tf-cart-item_price" cart-data-title="Price">
                                                <div class="cart-price">$${cartItem.product.price}</div>
                                            </td>
                                            <td class="tf-cart-item_quantity" cart-data-title="Quantity">
                                                <div class="cart-quantity">
                                                    <div class="wg-quantity">
                                                        <span class="btn-quantity minus-btn" data-user-id="${cartItem.userId}" data-product-id="${cartItem.productId}" data-action="decrease">
                                                            <svg class="d-inline-block" width="9" height="1" viewBox="0 0 9 1" fill="currentColor"><path d="M9 1H5.14286H3.85714H0V1.50201e-05H3.85714L5.14286 0L9 1.50201e-05V1Z"></path></svg>
                                                        </span>
                                                        <input type="number" name="quantity" value="${cartItem.quantity}" min="1" class="quantity-input" data-user-id="${cartItem.userId}" data-product-id="${cartItem.productId}">
                                                        <span class="btn-quantity plus-btn" data-user-id="${cartItem.userId}" data-product-id="${cartItem.productId}" data-action="increase">
                                                            <svg class="d-inline-block" width="9" height="9" viewBox="0 0 9 9" fill="currentColor"><path d="M9 5.14286H5.14286V9H3.85714V5.14286H0V3.85714H3.85714V0H5.14286V3.85714H9V5.14286Z"></path></svg>
                                                        </span>
                                                    </div>
                                                </div>
                                            </td>
                                            <td class="tf-cart-item_total" cart-data-title="Total">
                                                <span id="item-total-${cartItem.product.productId}">$${cartItem.quantity * cartItem.product.price}</span>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </tbody>
                            </table>
                        </form>
                </div>
                <div class="tf-page-cart-footer">
                   
                        <!-- Cart Totals -->
                        <div class="tf-cart-totals-discounts">
                            <h3>Subtotal</h3>
                            <span id="cart-total" class="price-value">$${total} USD</span>
                        </div>
                        
                        <!-- Shipping Info -->
                        <p class="tf-cart-tax">
                            Taxes and <a href="shipping-delivery.html" class="link-styled">shipping</a> calculated at checkout
                        </p>
                    
                        <!-- Terms Agreement - With Error Message -->
                        <div class="cart-checkbox">
                            <input type="checkbox" class="tf-check" id="check-agree" required>
                            <label for="check-agree" class="fw-4">
                                I agree with the terms and conditions
                            </label>
                        </div>
                        <!-- Error message will appear here -->
                        <div id="checkbox-error" class="checkbox-error-message" style="display: none;">
                            You must agree  before proceeding
                        </div>
                      
                    
                        <!-- Checkout Button -->
                        <div class="tf-action-btn">
                            <a href="javascript:void(0)" id="checkout-button" class="tf-btn radius-3 btn-fill btn-icon animate-hover-btn">
                                Proceed to Checkout
                            </a>
                        </div>
                    
                        <!-- Payment Methods -->
                        <div class="tf-page-cart_imgtrust">
                            <p class="text-center fw-6">Guarantee Safe Checkout</p>
                            <div class="cart-list-social">
                                <div class="payment-item">
                                    <svg viewBox="0 0 38 24" xmlns="http://www.w3.org/2000/svg" role="img" width="38" height="24" aria-labelledby="pi-visa"><title id="pi-visa">Visa</title><path opacity=".07" d="M35 0H3C1.3 0 0 1.3 0 3v18c0 1.7 1.4 3 3 3h32c1.7 0 3-1.3 3-3V3c0-1.7-1.4-3-3-3z"></path><path fill="#fff" d="M35 1c1.1 0 2 .9 2 2v18c0 1.1-.9 2-2 2H3c-1.1 0-2-.9-2-2V3c0-1.1.9-2 2-2h32"></path><path d="M28.3 10.1H28c-.4 1-.7 1.5-1 3h1.9c-.3-1.5-.3-2.2-.6-3zm2.9 5.9h-1.7c-.1 0-.1 0-.2-.1l-.2-.9-.1-.2h-2.4c-.1 0-.2 0-.2.2l-.3.9c0 .1-.1.1-.1.1h-2.1l.2-.5L27 8.7c0-.5.3-.7.8-.7h1.5c.1 0 .2 0 .2.2l1.4 6.5c.1.4.2.7.2 1.1.1.1.1.1.1.2zm-13.4-.3l.4-1.8c.1 0 .2.1.2.1.7.3 1.4.5 2.1.4.2 0 .5-.1.7-.2.5-.2.5-.7.1-1.1-.2-.2-.5-.3-.8-.5-.4-.2-.8-.4-1.1-.7-1.2-1-.8-2.4-.1-3.1.6-.4.9-.8 1.7-.8 1.2 0 2.5 0 3.1.2h.1c-.1.6-.2 1.1-.4 1.7-.5-.2-1-.4-1.5-.4-.3 0-.6 0-.9.1-.2 0-.3.1-.4.2-.2.2-.2.5 0 .7l.5.4c.4.2.8.4 1.1.6.5.3 1 .8 1.1 1.4.2.9-.1 1.7-.9 2.3-.5.4-.7.6-1.4.6-1.4 0-2.5.1-3.4-.2-.1.2-.1.2-.2.1zm-3.5.3c.1-.7.1-.7.2-1 .5-2.2 1-4.5 1.4-6.7.1-.2.1-.3.3-.3H18c-.2 1.2-.4 2.1-.7 3.2-.3 1.5-.6 3-1 4.5 0 .2-.1.2-.3.2M5 8.2c0-.1.2-.2.3-.2h3.4c.5 0 .9.3 1 .8l.9 4.4c0 .1 0 .1.1.2 0-.1.1-.1.1-.1l2.1-5.1c-.1-.1 0-.2.1-.2h2.1c0 .1 0 .1-.1.2l-3.1 7.3c-.1.2-.1.3-.2.4-.1.1-.3 0-.5 0H9.7c-.1 0-.2 0-.2-.2L7.9 9.5c-.2-.2-.5-.5-.9-.6-.6-.3-1.7-.5-1.9-.5L5 8.2z" fill="#142688"></path></svg>
                                </div>
                                <div class="payment-item">
                                    <svg viewBox="0 0 38 24" xmlns="http://www.w3.org/2000/svg" width="38" height="24" role="img" aria-labelledby="pi-paypal"><title id="pi-paypal">PayPal</title><path opacity=".07" d="M35 0H3C1.3 0 0 1.3 0 3v18c0 1.7 1.4 3 3 3h32c1.7 0 3-1.3 3-3V3c0-1.7-1.4-3-3-3z"></path><path fill="#fff" d="M35 1c1.1 0 2 .9 2 2v18c0 1.1-.9 2-2 2H3c-1.1 0-2-.9-2-2V3c0-1.1.9-2 2-2h32"></path><path fill="#003087" d="M23.9 8.3c.2-1 0-1.7-.6-2.3-.6-.7-1.7-1-3.1-1h-4.1c-.3 0-.5.2-.6.5L14 15.6c0 .2.1.4.3.4H17l.4-3.4 1.8-2.2 4.7-2.1z"></path><path fill="#3086C8" d="M23.9 8.3l-.2.2c-.5 2.8-2.2 3.8-4.6 3.8H18c-.3 0-.5.2-.6.5l-.6 3.9-.2 1c0 .2.1.4.3.4H19c.3 0 .5-.2.5-.4v-.1l.4-2.4v-.1c0-.2.3-.4.5-.4h.3c2.1 0 3.7-.8 4.1-3.2.2-1 .1-1.8-.4-2.4-.1-.5-.3-.7-.5-.8z"></path><path fill="#012169" d="M23.3 8.1c-.1-.1-.2-.1-.3-.1-.1 0-.2 0-.3-.1-.3-.1-.7-.1-1.1-.1h-3c-.1 0-.2 0-.2.1-.2.1-.3.2-.3.4l-.7 4.4v.1c0-.3.3-.5.6-.5h1.3c2.5 0 4.1-1 4.6-3.8v-.2c-.1-.1-.3-.2-.5-.2h-.1z"></path></svg>
                                </div>
                                <div class="payment-item">
                                    <svg viewBox="0 0 38 24" xmlns="http://www.w3.org/2000/svg" role="img" width="38" height="24" aria-labelledby="pi-master"><title id="pi-master">Mastercard</title><path opacity=".07" d="M35 0H3C1.3 0 0 1.3 0 3v18c0 1.7 1.4 3 3 3h32c1.7 0 3-1.3 3-3V3c0-1.7-1.4-3-3-3z"></path><path fill="#fff" d="M35 1c1.1 0 2 .9 2 2v18c0 1.1-.9 2-2 2H3c-1.1 0-2-.9-2-2V3c0-1.1.9-2 2-2h32"></path><circle fill="#EB001B" cx="15" cy="12" r="7"></circle><circle fill="#F79E1B" cx="23" cy="12" r="7"></circle><path fill="#FF5F00" d="M22 12c0-2.4-1.2-4.5-3-5.7-1.8 1.3-3 3.4-3 5.7s1.2 4.5 3 5.7c1.8-1.2 3-3.3 3-5.7z"></path></svg>
                                </div>
                                <div class="payment-item">
                                    <svg xmlns="http://www.w3.org/2000/svg" role="img" aria-labelledby="pi-american_express" viewBox="0 0 38 24" width="38" height="24"><title id="pi-american_express">American Express</title><path fill="#000" d="M35 0H3C1.3 0 0 1.3 0 3v18c0 1.7 1.4 3 3 3h32c1.7 0 3-1.3 3-3V3c0-1.7-1.4-3-3-3Z" opacity=".07"></path><path fill="#006FCF" d="M35 1c1.1 0 2 .9 2 2v18c0 1.1-.9 2-2 2H3c-1.1 0-2-.9-2-2V3c0-1.1.9-2 2-2h32Z"></path><path fill="#FFF" d="M22.012 19.936v-8.421L37 11.528v2.326l-1.732 1.852L37 17.573v2.375h-2.766l-1.47-1.622-1.46 1.628-9.292-.02Z"></path><path fill="#006FCF" d="M23.013 19.012v-6.57h5.572v1.513h-3.768v1.028h3.678v1.488h-3.678v1.01h3.768v1.531h-5.572Z"></path><path fill="#006FCF" d="m28.557 19.012 3.083-3.289-3.083-3.282h2.386l1.884 2.083 1.89-2.082H37v.051l-3.017 3.23L37 18.92v.093h-2.307l-1.917-2.103-1.898 2.104h-2.321Z"></path><path fill="#FFF" d="M22.71 4.04h3.614l1.269 2.881V4.04h4.46l.77 2.159.771-2.159H37v8.421H19l3.71-8.421Z"></path><path fill="#006FCF" d="m23.395 4.955-2.916 6.566h2l.55-1.315h2.98l.55 1.315h2.05l-2.904-6.566h-2.31Zm.25 3.777.875-2.09.873 2.09h-1.748Z"></path><path fill="#006FCF" d="M28.581 11.52V4.953l2.811.01L32.84 9l1.456-4.046H37v6.565l-1.74.016v-4.51l-1.644 4.494h-1.59L30.35 7.01v4.51h-1.768Z"></path></svg>
                                </div>
                                <div class="payment-item">
                                    <svg xmlns="http://www.w3.org/2000/svg" role="img" viewBox="0 0 38 24" width="38" height="24" aria-labelledby="pi-amazon"><title id="pi-amazon">Amazon</title><path d="M35 0H3C1.3 0 0 1.3 0 3v18c0 1.7 1.4 3 3 3h32c1.7 0 3-1.3 3-3V3c0-1.7-1.4-3-3-3z" fill="#000" fill-rule="nonzero" opacity=".07"></path><path d="M35 1c1.1 0 2 .9 2 2v18c0 1.1-.9 2-2 2H3c-1.1 0-2-.9-2-2V3c0-1.1.9-2 2-2h32" fill="#FFF" fill-rule="nonzero"></path><path d="M25.26 16.23c-1.697 1.48-4.157 2.27-6.275 2.27-2.97 0-5.644-1.3-7.666-3.463-.16-.17-.018-.402.173-.27 2.183 1.504 4.882 2.408 7.67 2.408 1.88 0 3.95-.46 5.85-1.416.288-.145.53.222.248.47v.001zm.706-.957c-.216-.328-1.434-.155-1.98-.078-.167.024-.193-.148-.043-.27.97-.81 2.562-.576 2.748-.305.187.272-.047 2.16-.96 3.063-.14.138-.272.064-.21-.12.205-.604.664-1.96.446-2.29h-.001z" fill="#F90" fill-rule="nonzero"></path><path d="M21.814 15.291c-.574-.498-.676-.73-.993-1.205-.947 1.012-1.618 1.315-2.85 1.315-1.453 0-2.587-.938-2.587-2.818 0-1.467.762-2.467 1.844-2.955.94-.433 2.25-.51 3.25-.628v-.235c0-.43.033-.94-.208-1.31-.212-.333-.616-.47-.97-.47-.66 0-1.25.353-1.392 1.085-.03.163-.144.323-.3.33l-1.677-.187c-.14-.033-.296-.153-.257-.38.386-2.125 2.223-2.766 3.867-2.766.84 0 1.94.234 2.604.9.842.82.762 1.918.762 3.11v2.818c0 .847.335 1.22.65 1.676.113.164.138.36-.003.482-.353.308-.98.88-1.326 1.2a.367.367 0 0 1-.414.038zm-1.659-2.533c.34-.626.323-1.214.323-1.918v-.392c-1.25 0-2.57.28-2.57 1.82 0 .782.386 1.31 1.05 1.31.487 0 .922-.312 1.197-.82z" fill="#221F1F"></path></svg>
                                </div>
                            </div>
                        </div>
                    </div>
                </c:otherwise>
            </c:choose>
                </div>
            </div>
        </div>
    </section>
    <!-- page-cart -->
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

    <!-- Javascript -->
    <script type="text/javascript" src="js/bootstrap.min.js"></script>
    <script type="text/javascript" src="js/jquery.min.js"></script>
    <script type="text/javascript" src="js/swiper-bundle.min.js"></script>
    <script type="text/javascript" src="js/carousel.js"></script>
    <script type="text/javascript" src="js/bootstrap-select.min.js"></script>
    <script type="text/javascript" src="js/lazysize.min.js"></script>
    <script type="text/javascript" src="js/count-down.js"></script>   
    <script type="text/javascript" src="js/wow.min.js"></script>   
    <script type="text/javascript" src="js/rangle-slider.js"></script>
    <script type="text/javascript" src="js/multiple-modal.js"></script>
    <script type="text/javascript" src="js/main.js"></script>

     <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
     <script type="text/javascript" src="js/updateCart.js"></script>



     <script>
 document.addEventListener('DOMContentLoaded', function() {
    const removeButtons = document.querySelectorAll('.productRemove');
    
    removeButtons.forEach(button => {
        button.addEventListener('click', function() {
            const productId = this.getAttribute('data-product-id');
            const cartItemRow = this.closest('.tf-cart-item');
            const formData = new URLSearchParams();
            formData.append('productId', productId);            
            fetch('removeCartItem', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/x-www-form-urlencoded',
                },
                body: formData.toString(),
                cache: 'no-store'
            })
            .then(response => {
                if (!response.ok) {
                    throw new Error('Network response was not ok: ' + response.status);
                }
                return response.json();
            })
            .then(data => {
                if (data.success) {

                    cartItemRow.style.opacity = '0';
                    setTimeout(() => {
                        cartItemRow.remove();
                        document.getElementById('cart-total').textContent = '$' + data.newTotal + ' USD';
                        
                        checkIfCartEmpty();
                    }, 300);
                } else {
                    alert('Failed to remove item: ' + data.message);
                }
            })
            .catch(error => {
                console.error('Error:', error);
        
                cartItemRow.style.opacity = '0';
                setTimeout(() => {
                    cartItemRow.remove();
                    checkIfCartEmpty();
                }, 300);
            });
        });
    });
    

    function checkIfCartEmpty() {
        const remainingItems = document.querySelectorAll('.tf-cart-item');
        if (remainingItems.length === 0) {
    
            const cartContainer = document.querySelector('.tf-page-cart-item');
            
            if (cartContainer) {
     
                cartContainer.innerHTML = '';
           
                const emptyMessage = document.createElement('div');
                emptyMessage.className = 'empty-cart-message';
                emptyMessage.style.textAlign = 'center';
                emptyMessage.style.padding = '30px';
                emptyMessage.innerHTML = `
                    <h3 style="margin-bottom: 15px;">Your cart is empty</h3>
                    <p style="margin-bottom: 20px;">Looks like you haven't added any items to your cart yet.</p>
                    <a href="shop" class="tf-button">Continue Shopping</a>
                `;
                
                cartContainer.appendChild(emptyMessage);
            }
        }
    }
});
     </script>




     <script>
        document.addEventListener('DOMContentLoaded', function() {
            const checkoutButton = document.getElementById('checkout-button');
            const checkbox = document.getElementById('check-agree');
            const errorMessage = document.getElementById('checkbox-error');
            
         
            const checkoutUrl = "${pageContext.request.contextPath}/checkout";
            
            checkoutButton.addEventListener('click', function(e) {
         
                if (!checkbox.checked) {
                    e.preventDefault();
                    errorMessage.style.display = 'block';
                    checkbox.parentElement.classList.add('shake');
             
                    setTimeout(function() {
                        checkbox.parentElement.classList.remove('shake');
                    }, 500);
                } else {
                
                    window.location.href = checkoutUrl;
                }
            });
            
           
            checkbox.addEventListener('change', function() {
                if (checkbox.checked) {
                    errorMessage.style.display = 'none';
                }
            });
        });
        </script>



</div>
</body>
</html>