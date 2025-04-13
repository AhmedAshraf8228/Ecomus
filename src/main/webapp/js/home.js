$(document).ready(function () {

    $('#quick_view').on('show.bs.modal', function (event) {
        let button = $(event.relatedTarget); // Button that triggered the modal

        // Extract data from attributes
        let productId = button.data('product-id');
        let productName = button.data('product-name');
        let productPrice = button.data('product-price');
        let productDesc = button.data('product-description');
        $('#quick-view-quantity').val(1); // first, reset input value to 1
        let quantity = 1; // then use that number
        let total = (productPrice * quantity).toFixed(2);


        // Update modal content
        $('#quick-view-product-id').val(productId);
        $('#quick-view-name').text(productName);
        $('#quick-view-price').text(productPrice);
        $('#quick-view-description').text(productDesc);
        $("#quick-view-total").text(`$${total}`);
        let imageContainer = $('#quick-view-images');
        imageContainer.empty();

        let productImages = window.productsImages[productId] || [];
        productImages.forEach(img => {
            let imgTag = `<div class="swiper-slide"><div class="item"><img src="images/products/${productId}/${img}" alt=""></div></div>`;
            imageContainer.append(imgTag);
        });

        // $('#modal-detail-link').attr('href', `productDetail.jsp?id=${productId}`);

        $('.quick-view-btn').on('click', function () {
            let quantity = parseInt($('#quick-view-quantity').val(), 10);
            total = (productPrice * quantity).toFixed(2);
            $('#quick-view-total').text(`$${total}`);
        });


        $('#quick-view-addToCart').off('click').on('click', function (e) {
            e.preventDefault();
            addToCart(productId,"view");
        });
    });

    $('#quick_add').on('show.bs.modal', function (event) {
        let button = $(event.relatedTarget); // Button that triggered the modal
        // Extract data from attributes
        let productId = button.data('product-id');
        let productName = button.data('product-name');
        let productPrice = button.data('product-price');
        $('#quick-add-quantity').val(1);
        let quantity = 1;
        let total = (productPrice * quantity).toFixed(2);


        // Update modal content
        $('#quick-add-product-id').val(productId);
        $('#quick-add-name').text(productName);
        $('#quick-add-price').text(productPrice);
        $("#quick-add-total").text(`$${total}`);

        // $('#modal-detail-link').attr('href', `productDetail.jsp?id=${productId}`);

        $('.quick-add-btn').on('click', function () {
            let quantity = parseInt($('#quick-add-quantity').val(), 10);
            total = (productPrice * quantity).toFixed(2);
            $('#quick-add-total').text(`$${total}`);
        });

        const productImages = window.productsImages[productId] || [];
        $('#quick-add-image').attr('src', `images/products/${productId}/${productImages.at(0)}`);

        $('#quick-add-addToCart').off('click').on('click', function (e) {
            e.preventDefault();
            addToCart(productId,"add");
        });
    });
});

function addToCart(productId,type) {
    hideModal();
    if (!window.isLoggedIn) {
        swalFire()
    } else {
        $('#quick-add-addToCart').prop('disabled', true).text('Adding...');
        $('#quick-view-addToCart').prop('disabled', true).text('Adding...');
        let quantity = 1;
        if (type === "add") {
            quantity = parseInt($('#quick-add-quantity').val(), 10);
            console.log("productId=  " + productId  + ": quantity=" + quantity + "add");
        } else if (type === "view") {
            quantity = parseInt($('#quick-view-quantity').val(), 10);
            console.log("productId=  " + productId  + ": quantity=" + quantity + "view");
        }

        $.ajax({
            url: 'addtocart',
            method: 'POST',
            data: {productId, quantity},
            success: function (){
                successAddToCart();
                updateCartCount(quantity);
                },
            error: errorAddToCart,
            complete: function (){
                $('#quick-add-addToCart').prop('disabled', false).text('Add to cart');
                $('#quick-view-addToCart').prop('disabled', false).text('Add to cart');
            }
        });
    }

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

function hideModal() {
    const wrapper = document.getElementById('wrapper');
    if (document.activeElement && wrapper?.contains(document.activeElement)) {
        document.activeElement.blur();
    }
    const quickAdd = bootstrap.Modal.getInstance(document.getElementById('quick_add'));
    const quickView = bootstrap.Modal.getInstance(document.getElementById('quick_view'));
    if (quickAdd) quickAdd.hide();
    if (quickView) quickView.hide();
    setTimeout(() => {
        document.body.focus();
    }, 300);
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
