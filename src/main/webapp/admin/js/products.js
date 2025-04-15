//todo --> alter category to get it from DB (DONE)
// todo --> insert product
// todo --> edit product

document.getElementById("edit-product-btn").disabled = true;

function searchProduct() {
    let input, filter, table, tr, td, i, txtValue;
    input = document.getElementById("search-input");
    filter = input.value.toUpperCase();
    table = document.getElementById("products-table");
    tr = table.getElementsByTagName("tr");

    for (i = 1; i < tr.length; i++) {
        td = tr[i].getElementsByTagName("td")[0]; // Product ID column
        if (td) {
            txtValue = td.textContent || td.innerText;
            if (txtValue.toUpperCase().indexOf(filter) > -1) {
                tr[i].style.display = "";
            } else {
                tr[i].style.display = "none";
            }
        }
    }
}

// const imageInput = document.getElementById("product-images");
// const imagePreviewBox = document.getElementById("image-preview-box");
//
// imageInput.addEventListener("change", function (event) {
//     const files = event.target.files;
//
//     // Clear the preview box
//     imagePreviewBox.innerHTML = "";
//
//     if (files.length > 5) {
//         alert("You can only select up to 5 images.");
//         return;
//     }
//
//     Array.from(files).forEach(file => {
//         const reader = new FileReader();
//         reader.onload = function(e) {
//             const imageContainer = document.createElement("div");
//             imageContainer.classList.add("image-container");
//
//             const img = document.createElement("img");
//             img.src = e.target.result;
//             img.classList.add("image-preview");
//
//             const removeBtn = document.createElement("button");
//             removeBtn.textContent = "Remove";
//             removeBtn.classList.add("remove-image-btn");
//
//             // Remove image functionality
//             removeBtn.addEventListener("click", function() {
//                 imageContainer.remove();
//             });
//
//             imageContainer.appendChild(img);
//             imageContainer.appendChild(removeBtn);
//             imagePreviewBox.appendChild(imageContainer);
//         };
//         reader.readAsDataURL(file);
//     });
// });

$(document).ready(function () {
    loadProducts();
});

function loadProducts() {
    var contextPath = '${pageContext.request.contextPath}';


    $.ajax({
        url: "/MindMaze/admin/products",
        type: "GET",
        dataType: "json",
        success: function (products) {
            let tableBody = $("#product-tbody");
            tableBody.empty();

            products.forEach(product => {
                var imageUrl = contextPath + "/products/" + product.productId + "/1.jpg";

                let row = `
                    <tr>
                        <td>${product.productId}</td>
                        <td><img src="MindMaze/admin/images/1.jpeg"></td> 
                        <td>${product.productName}</td>
                        <td>${product.quantity}</td>
                        <td>${product.price}</td>
                        <td>
                            <button class="edit-button" onclick="editProduct(${product.productId})">Edit</button>
                            <button class="delete-button" onclick="deleteProduct(${product.productId})">Delete</button>
                        </td>
                    </tr>
                `;
                tableBody.append(row);
            });
        },
        error: function () {
            alert("Failed to load customers.");
        }
    });
}

function editProduct(productId) {
    document.getElementById("edit-product-btn").disabled = false;
    document.getElementById("add-product-btn").disabled = true;


    $.ajax({
        url: `/MindMaze/admin/products/${productId}`,
        type: "GET",
        dataType: "json",
        success: function(product) {
            // Fill input fields with product data
            $("#product-name").val(product.productName);
            $("#product-description").val(product.description);
            $("#product-quantity").val(product.quantity);
            $("#product-price").val(product.price);

            // Optionally: store productId in a hidden field to track the edit
            if ($("#product-id").length === 0) {
                $("#product-info-form").append(`<input type="hidden" id="product-id" value="${productId}">`);
            } else {
                $("#product-id").val(productId);
            }

            // Optionally: pre-check categories if you have product.categories
            if (product.categories && product.categories.length > 0) {
                $(".categories-container input[type='checkbox']").prop("checked", false);
                product.categories.forEach(cat => {
                    $(`.categories-container input[value="${cat.categoryName}"]`).prop("checked", true);
                });
            }

            // // Scroll to form
            // $('html, body').animate({
            //     scrollTop: $(".add-product-container").offset().top
            // }, 500);
        },
        error: function() {
            alert("Failed to load product details.");
        }
    });
}

function updateProductInfo() {

    document.getElementById("edit-product-btn").disabled = false;
    document.getElementById("add-product-btn").disabled = true;



    const productId = $("#product-id").val();
    const productName  = $("#product-name").val().trim();
    const description = $("#product-description").val().trim();
    const quantity = parseInt($("#product-quantity").val());
    const price = parseInt($("#product-price").val());
    let files = $("#product-images")[0].files;



    let errors = [];

    // Collect selected categories
    let selectedCategories = [];
    $(".categories-container input[type='checkbox']:checked").each(function () {
        selectedCategories.push({
            categoryName: $(this).val()
        });
    });

    if (!productName) errors.push("Product name is required.");
    if (!description) errors.push("Description is required.");
    if (description.length>255) errors.push("Description must be 255 character or less");
    if (!quantity) errors.push("Quantity is required.");
    if (quantity<1) errors.push("Quantity must be positive");
    if (price<1) errors.push("Price must be positive");
    if (!price) errors.push("Price is required.");
    if (selectedCategories.length === 0) errors.push("At least one category must be selected.");
    if (files.length < 2) errors.push("At least two images must be uploaded.");


    if (errors.length > 0) {
        let errorMessage = errors.join("<br>");
        toastr.error(errorMessage);
        return;
    }

    // Create product object
    const updatedProduct = {
        productId: parseInt(productId),
        productName: productName ,
        description: description,
        quantity: quantity,
        price: price,
        categories: selectedCategories
    };

    // Send PUT request
    $.ajax({
        url: "/MindMaze/admin/products",
        type: "PUT",
        contentType: "application/json",
        data: JSON.stringify(updatedProduct),
        success: function () {
            alert("Product updated successfully!");
            loadProducts();
            $("#edit-product-btn").prop("disabled", false);
            $("#add-product-btn").prop("disabled", false);
            $("#product-info-form")[0].reset();
            $("#product-id").remove();
            document.getElementById("edit-product-btn").disabled = true;

        },
        error: function () {
            alert("Failed to update product.");
            document.getElementById("edit-product-btn").disabled = true;

        }
    });

    // === IMAGES ===
    let imageData = new FormData();
    for (let i = 0; i < files.length; i++) {
        imageData.append("images", files[i]);
    }

    $.ajax({
        url: "/MindMaze/admin/uploadProductImages?productId=" + productId,
        type: "POST",
        data: imageData,
        processData: false,
        contentType: false,
        success: function(response) {
            alert("Images uploaded successfully!");
        },
        error: function(xhr, status, error) {
            console.error("Error uploading images:", error);
            alert("Failed to upload images.");
        }
    });

}

function deleteProduct(productId) {
    if (confirm("Are you sure you want to delete this product?")) {
        $.ajax({
            url: `/MindMaze/admin/products?productId=${productId}`,
            type: "DELETE",
            success: function () {
                loadProducts();
            },
            error: function () {
                alert("Failed to delete the product.");
            }
        });
    }
}

$(document).ready(function () {
    loadCategories();
    $('#save-product-info-button').on('click', function() {
        addProductInfo();
    });
});

function loadCategories() {
    $.ajax({
        url: "/MindMaze/admin/category",
        type: "GET",
        dataType: "json",
        success: function (categories) {
            console.log(categories);
            let container = $(".categories-container");
            container.empty();


            categories.forEach(category => {
                let checkbox = `
                    <label class="category-item">
                        <input type="checkbox" name="Categories" value="${category.categoryName}"> ${category.categoryName}
                    </label>
                `;
                container.append(checkbox);
            });
        },
        error: function (xhr, status, error) {
            alert("Error fetching categories");
        }
    });
}

function addProductInfo() {

    // Get values
    let productName = $("#product-name").val().trim();
    let description = $("#product-description").val().trim();
    let quantity = $("#product-quantity").val().trim();
    let price = $("#product-price").val().trim();
    let selectedCategories = $(".categories-container input[type='checkbox']:checked");
    let files = $("#product-images")[0].files;

    // === VALIDATIONS ===
    let errors = [];

    if (!productName) errors.push("Product name is required.");
    if (!description) errors.push("Description is required.");
    if (description.length>255) errors.push("Description must be 255 character or less");
    if (!quantity) errors.push("Quantity is required.");
    if(quantity<1) errors.push("Quantity must be positive");
    if(price<1) errors.push("Price must be positive");
    if (!price) errors.push("Price is required.");
    if (selectedCategories.length === 0) errors.push("At least one category must be selected.");
    if (files.length < 2) errors.push("At least two images must be uploaded.");

    if (errors.length > 0) {
        let errorMessage = errors.join("<br>");
        toastr.error(errorMessage);
        return;
    }

    // === Proceed if valid ===
    let formData = {
        productName: productName,
        description: description,
        quantity: parseInt(quantity, 10),
        price: parseInt(price, 10),
    };

    $.ajax({
        url: "/MindMaze/admin/products",
        type: "POST",
        contentType: "application/json",
        data: JSON.stringify(formData),
        success: function(response) {
            alert("Product info saved successfully!");
            let insertedProductId = response.productId;
            console.log("insertedProductId:", insertedProductId);

            // === CATEGORIES ===
            let catData = {
                id: insertedProductId,
                categories: []
            };

            selectedCategories.each(function () {
                catData.categories.push($(this).val());
            });

            $.ajax({
                url: "/MindMaze/admin/productCategory",
                type: "POST",
                contentType: "application/json",
                data: JSON.stringify(catData),
                success: function(response) {
                    alert("Product assigned to categories successfully!");
                    $(".categories-container input[type='checkbox']").prop("checked", false);
                },
                error: function(xhr, status, error) {
                    console.error("Error saving category info:", error);
                    alert("Failed to save category info.");
                }
            });

            // === IMAGES ===
            let imageData = new FormData();
            for (let i = 0; i < files.length; i++) {
                imageData.append("images", files[i]);
            }

            $.ajax({
                url: "/MindMaze/admin/uploadProductImages?productId=" + insertedProductId,
                type: "POST",
                data: imageData,
                processData: false,
                contentType: false,
                success: function(response) {
                    alert("Images uploaded successfully!");
                },
                error: function(xhr, status, error) {
                    console.error("Error uploading images:", error);
                    alert("Failed to upload images.");
                }
            });

            // === RESET FORM ===
            $("#product-name").val("");
            $("#product-description").val("");
            $("#product-quantity").val("");
            $("#product-price").val("");
            $(".categories-container input[type='checkbox']").prop("checked", false);
            loadProducts();
        },
        error: function(xhr, status, error) {
            console.error("Error saving product info:", error);
            alert("Failed to save product info.");
        }
    });
}







