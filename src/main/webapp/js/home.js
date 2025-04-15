$(document).ready(function () {
    renderProducts(window.products);
    updateFilterCount([], [], '', '');

    $('#quick_view').on('show.bs.modal', function (event) {
        const productId = $(event.relatedTarget).data('product-id');
        const product = window.products.find(p => p.id === productId);

        if(product.quantity <= 0){
            $('#quick-view-addToCart').prop('disabled', true)
                .html("<span class=\"btn-quick-add quick-add disabled\">OUT OF STOCK</span>");
        }else {
            $('#quick-view-addToCart').prop('disabled', false)
                .html(`<span>Add to cart -&nbsp;</span><span id="quick-view-total" class="tf-qty-price quick-product-total">$total</span>`);
        }


        quickProduct(product);


        let imageContainer = $('#quick-view-images');
        imageContainer.empty();
        let productImages = window.productsImages[productId] || [];
        productImages.forEach(img => {
            let imgTag = `<div class="swiper-slide"><div class="item"><img src="images/products/${productId}/${img}" alt=""></div></div>`;
            imageContainer.append(imgTag);
        });


        $('#quick-view-addToCart').off('click').on('click', function (e) {
            e.preventDefault();
            addToCart(productId , "view");
        });

    });

    $('#quick_add').on('show.bs.modal', function (event) {
        const productId = $(event.relatedTarget).data('product-id');
        const product = window.products.find(p => p.id === productId);
        quickProduct(product);
        const images = window.productsImages[productId] || [];
        $('#quick-add-image').attr('src', `images/products/${productId}/${images.at(0)}`);

        $('#quick-add-addToCart').off('click').on('click', function (e) {
            e.preventDefault();
            addToCart(productId , "add");
        });
    });

    $('#filter').on('click', function (e) {
        e.preventDefault();
        applyFilters();
    });

    $('#clear-filters').on('click', function () {
        resetInputs();
        applyFilters();
    });

});

function quickProduct(product){
    if (!product) return;
    $('.link-product-details').attr('href', `productDetail?id=${product.id}`);
    $('.quick-product-id').val(product.id);
    $('.quick-product-name').text(product.name);
    $('#quick-view-description').text(product.description);
    $('.quick-product-price').text(product.price);
    $('.quick-product-quantity').val(1);
    $('.quick-product-total').text(`$${(product.price * 1).toFixed(2)}`);

    $('.quick-add-btn').on('click', function () {
        const quantity = parseInt($('#quick-add-quantity').val(), 10);
        const total = (product.price * quantity).toFixed(2);
        $('#quick-add-total').text(`$${total}`);
    });

    $('.quick-view-btn').on('click', function () {
        const quantity = parseInt($('#quick-view-quantity').val(), 10);
        const total = (product.price * quantity).toFixed(2);
        $('#quick-view-total').text(`$${total}`);
    });

}

function addToCart(productId, type) {
    hideModal();
    if (!window.isLoggedIn) {
        swalFire()
    } else {
        $('.quick-product-addToCart').prop('disabled', true).text('Adding...');

        let quantity = 1;
        if(type === 'add') {
            quantity = parseInt($('#quick-add-quantity').val(), 10);
        }else if(type === 'view') {
            quantity = parseInt($('#quick-view-quantity').val(), 10);
        }
        console.log("productId=  " + productId + ": quantity=" + quantity + "add");

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

function renderProducts(products) {
    const $container = $('#product-list');
    $container.empty();

    if (products.length === 0) {
        $container.append('<p>No products found.</p>');
        return;
    }

    products.forEach(function (p) {
        const img1 = window.productsImages?.[p.id]?.[0] || 'fallback.jpg';
        const img2 = window.productsImages?.[p.id]?.[1] || img1;

        const outOfStock = p.quantity === 0 ? 'out-of-stock' : '';
        const $html = $(`
        <div class="card-product style-4">
            <div class="card-product-wrapper">
                <a href="productDetail?id=${p.id}" class="product-img ${outOfStock}">
                    <img class="lazyload img-product"
                         data-src="images/products/${p.id}/${img1}"
                         src="images/products/${p.id}/${img1}" 
                         alt="${p.name}" >
                    <img class="lazyload img-hover"
                         data-src="images/products/${p.id}/${img2}"
                         src="images/products/${p.id}/${img2}" 
                        src="images/placeholder.jpg"
                         alt="${p.name}">                   
                </a>
                 <div class="list-product-btn column-right">
                    <a href="javascript:void(0);" class="box-icon wishlist bg_white round btn-icon-action">
                        <span class="icon icon-heart"></span>
                        <span class="tooltip">Add to Wishlist</span>
                        <span class="icon icon-delete"></span>
                    </a>
                    <a href="#quick_view"
                       data-bs-toggle="modal"
                       class="box-icon quickview bg_white round tf-btn-loading"
                       data-product-id="${p.id}">
                        <span class="icon icon-view"></span>
                        <span class="tooltip">Quick View</span>
                    </a>
                </div>
                ${p.quantity > 0 ? `
                    <a href="#quick_add" data-bs-toggle="modal"
                       class="btn-quick-add quick-add"
                       data-product-id="${p.id}" 
                    >QUICK ADD </a>
                ` : `
                    <span class="btn-quick-add quick-add disabled">OUT OF STOCK</span>
                `}
            </div>
            <div class="card-product-info">
                <a href="productDetail?id=${p.id}" class="title link">${p.name}</a>
                <span class="price">$${p.price}</span>
            </div>
        </div>
        `);

        $container.append($html);
        if (window.lazySizes) {
            lazySizes.autoSizer.checkElems();
        }
    });
}

function applyFilters() {
    const min = parseInt($('#min-price').val()) || 0;
    const max = parseInt($('#max-price').val()) || Infinity;

    const selectedAvailability = $('input[name="availability"]:checked')
        .map(function () { return $(this).val(); })
        .get();

    const selectedCategories = $('input[name="categoryIds"]:checked')
        .map(function () { return $(this).val(); })
        .get();

    const filtered = window.products.filter(function (p) {
        const inPriceRange = p.price >= min && p.price <= max;
        const hasStock =
            selectedAvailability.length === 0 ||
            (selectedAvailability.includes('in') && p.quantity > 0) ||
            (selectedAvailability.includes('out') && p.quantity === 0);
        const inCategory =
            selectedCategories.length === 0 ||
            p.categories.some(c => selectedCategories.includes(c));
        return inPriceRange && hasStock && inCategory;
    });

    renderProducts(filtered);
    updateFilterCount(selectedAvailability, selectedCategories, $('#min-price').val(), $('#max-price').val());
    scrollToTop();

    const filterOffcanvas = bootstrap.Offcanvas.getInstance(document.getElementById('filterShop'));
    if (filterOffcanvas) filterOffcanvas.hide();
}

function updateFilterCount(availability, categories, min, max) {
    let count = 0;
    if (availability.length > 0) count++;
    if (categories.length > 0) count++;
    if (min) count++;
    if (max) count++;

    const $badge = $('#filter-count');
    $badge.text(`${count} Filter${count === 1 ? '' : 's'} Applied`);
    $badge.toggle(count > 0);
}

function scrollToTop() {
    $('html, body').animate({ scrollTop: 0 }, 'slow');
}

function resetInputs() {
    $('input[type=checkbox]').prop('checked', false);
    $('#min-price, #max-price').val('');
    $('#select-all-categories').prop('checked', false);
}

