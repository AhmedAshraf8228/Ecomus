//todo --> alter category to get it from DB (DONE)
// todo --> insert product
// todo --> edit product
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
    $.ajax({
        url: "/MindMaze/admin/products",
        type: "GET",
        dataType: "json",
        success: function (products) {
            let tableBody = $("#product-tbody");
            tableBody.empty();

            products.forEach(product => {
                let row = `
                    <tr>
                        <td>${product.productId}</td>
                         <td><img src="/MindMaze/admin/images/1.jpeg" alt="Product"></td> 
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
    if (!quantity) errors.push("Quantity is required.");
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







