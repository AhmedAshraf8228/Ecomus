$(document).ready(function() {
    updateTotalPrice();

    $('.btn-quantity').on('click', function() {
        updateTotalPrice();
    });

    $('#form-1').on('submit', function (e) {
        e.preventDefault();
        let quantity = parseInt($('#quantity-1').val(), 10);
        addToCart(quantity );
    });

    $('#form-2').on('submit', function (e) {
        e.preventDefault();
        let quantity = parseInt($('#quantity-2').val(), 10);
        addToCart(quantity );
    });





function addToCart( quantity) {
    let productId = p.productId;
    if (!window.isLoggedIn) {
        swalFire()
    } else {
        $('.quick-product-addToCart').prop('disabled', true).text('Adding...');
        $.ajax({
            url: 'addtocart',
            method: 'POST',
            data: {productId, quantity},
            success: function () {
                successAddToCart();
                updateCartCount(quantity);
            },
            error: errorAddToCart,
            complete: function () {
                $('.quick-product-addToCart').prop('disabled', false).text('Add to cart');
            }
        });
    }
}

function updateTotalPrice() {
    const quantity = parseInt($('#quantity-1').val(), 10);
    const total = (p.price * quantity).toFixed(2);  // Calculate total
    $('#total-price').text(`$${total}`);  // Update the total price in the button
    console.log(quantity);
    console.log(p.price);
}

function successAddToCart(res) {
    toastr.success("Item added to cart!✅");
}
function errorAddToCart(xhr) {
    if (xhr.status === 401) {
        swalFire()
    } else {
        try {
            const res = JSON.parse(xhr.responseText);
            toastr.error(res.error || "Something went wrong!");
        } catch (err) {
            toastr.error("Unexpected error.");
        }
    }
}
function swalFire() {
    Swal.fire({
        title: 'Login Required',
        text: "You need to log in to add this item to your cart.",
        icon: 'warning',
        showCancelButton: true,
        confirmButtonText: 'Login',
        cancelButtonText: 'Cancel',
        reverseButtons: true
    }).then((result) => {
        if (result.isConfirmed) {
            window.location.href = "login.jsp";
        } else {
            toastr.info("You can continue browsing.");
        }
    });
}
function updateCartCount(newCount) {
    let currentCount = parseInt($('.nav-cart .count-box').text(), 10) || 0;
    let updatedCount = currentCount + newCount;
    $('.nav-cart .count-box')
        .text(updatedCount)
        .addClass('animate__animated animate__pulse');

    setTimeout(() => {
        $('.nav-cart .count-box').removeClass('animate__animated animate__pulse');
    }, 500);
}

});

