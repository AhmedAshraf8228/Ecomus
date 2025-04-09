$(document).ready(function() {
    // Handle plus and minus buttons
    $('.btn-quantity').on('click', function() {
        const userId = $(this).data('user-id');
        const productId = $(this).data('product-id');
        const action = $(this).data('action');
        
        updateCartItem(userId, productId, action);
    });
    
    // Handle direct input changes
    $('.quantity-input').on('change', function() {
        const userId = $(this).data('user-id');
        const productId = $(this).data('product-id');
        let quantity = parseInt($(this).val());
        
        // Ensure quantity is at least 1
        if (isNaN(quantity) || quantity < 1) {
            quantity = 1;
            $(this).val(1);
        }
        
        updateCartItem(userId, productId, 'set', quantity);
    });
    
    // Prevent direct typing of invalid values in quantity input
    $('.quantity-input').on('keydown', function(e) {
        // Allow: backspace, delete, tab, escape, enter and .
        if ($.inArray(e.keyCode, [46, 8, 9, 27, 13, 110, 190]) !== -1 ||
            // Allow: Ctrl+A, Command+A
            (e.keyCode === 65 && (e.ctrlKey === true || e.metaKey === true)) ||
            // Allow: home, end, left, right, down, up
            (e.keyCode >= 35 && e.keyCode <= 40)) {
            return;
        }
        // Ensure that it's a number and stop the keypress if not
        if ((e.shiftKey || (e.keyCode < 48 || e.keyCode > 57)) && (e.keyCode < 96 || e.keyCode > 105)) {
            e.preventDefault();
        }
    });
    
    function updateCartItem(userId, productId, action, quantity = null) {
        let data = {
            userId: userId,
            productId: productId,
            action: action
        };
        
        if (quantity !== null) {
            data.quantity = quantity;
        }
        
        $.ajax({
            url: 'updateCart',
            type: 'POST',
            data: data,
            dataType: 'json',
            success: function(response) {
                if (response.success) {
                    // Update the quantity input
                    const quantityInput = $('input.quantity-input[data-user-id="' + userId + '"][data-product-id="' + productId + '"]');
                    quantityInput.val(response.quantity);
                    
                    // Disable minus button if quantity is 1
                    const minusBtn = $('.btn-quantity.minus-btn[data-user-id="' + userId + '"][data-product-id="' + productId + '"]');
                    if (response.quantity <= 1) {
                        minusBtn.addClass('disabled').css('opacity', '0.5');
                    } else {
                        minusBtn.removeClass('disabled').css('opacity', '1');
                    }
                    
                    // Check if itemTotal and cartTotal are defined before updating
                    if (response.itemTotal !== undefined) {
                        $('#item-total-' + productId).text('$' + response.itemTotal);
                    }
                    
                    if (response.cartTotal !== undefined) {
                        $('#cart-total').text('$' + response.cartTotal + ' USD');
                    }
                } else {
                    alert('Error: ' + response.message);
                }
            },
            error: function(xhr, status, error) {
                console.error("AJAX Error:", status, error);
                alert('Failed to update the cart. Please try again later.');
            }
        });
    }
    
    // Initialize minus buttons state on page load
    $('.quantity-input').each(function() {
        const userId = $(this).data('user-id');
        const productId = $(this).data('product-id');
        const quantity = parseInt($(this).val());
        
        const minusBtn = $('.btn-quantity.minus-btn[data-user-id="' + userId + '"][data-product-id="' + productId + '"]');
        if (quantity <= 1) {
            minusBtn.addClass('disabled').css('opacity', '0.5');
        }
    });
    
    // Add additional validation for zero input on blur
    $('.quantity-input').on('blur', function() {
        let quantity = parseInt($(this).val());
        
        if (isNaN(quantity) || quantity < 1) {
            $(this).val(1);
            
            // Trigger change event to update cart
            const userId = $(this).data('user-id');
            const productId = $(this).data('product-id');
            updateCartItem(userId, productId, 'set', 1);
        }
    });
});