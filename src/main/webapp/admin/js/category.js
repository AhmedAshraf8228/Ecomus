
function searchCategory() {
    var input, filter, table, tr, td, i, txtValue;
    input = document.getElementById("search-input");
    filter = input.value.toUpperCase();
    table = document.getElementById("category-table");
    tr = table.getElementsByTagName("tr");

    for (i = 1; i < tr.length; i++) {
        td = tr[i].getElementsByTagName("td")[0];
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

$(document).ready(
    function (){
        loadCategories()
    }
);

function loadCategories(){
    $.ajax({
        url: "/MindMaze/admin/category?includeCounts=true",
        type: "GET",
        dataType: "json",
        success: function (response) {
            let categories = response.categories;
            let productCounts = response.productCounts;

            let tableBody = $("#category-tbody");
            tableBody.empty();

            categories.forEach((cat, index) => {
                let count = productCounts[index] || 0;
                let row = `
                    <tr>
                        <td>${cat.categoryId}</td>
                        <td>${cat.categoryName}</td>
                        <td>${count}</td>
                        <td>
                            <button class="edit-button" onclick="loadDataToEdit(${cat.categoryId})">Edit</button>
                            <button class="delete-button" onclick="deleteCategory(${cat.categoryId})">Delete</button>
                        </td>
                    </tr>
                `;
                tableBody.append(row);
            });
        },
        error: function (xhr, status, error) {
            toastr.error("Error: loading Categories");
        }
    });
}


function addCategory() {
    let categoryName = $("#category-name").val().trim();

    if (categoryName === "") {
        toastr.error("Category name cannot be empty!");
        return;
    }

    $.ajax({
        url: "/MindMaze/admin/category",
        type: "POST",
        contentType: "application/json",
        data: JSON.stringify({ categoryName: categoryName }),
        success: function (response) {
            Swal.fire({
                title: 'Category',
                text: ' Category added successfully! ',
                icon: 'info',
                confirmButtonText: 'OK'
            });
            $("#category-name").val("");
            loadCategories();
        },
        error: function () {
            toastr.error("Failed to add category.");
        }
    });
}


function deleteCategory(categoryId) {
    if (confirm("Are you sure you want to delete this category?")) {
        $.ajax({
            url: `/MindMaze/admin/category?categoryId=${categoryId}`,
            type: "DELETE",
            success: function () {
                loadCategories();
            },
            error: function () {
                toastr.error("Failed to delete the category.");
            }
        });
    }
}

$(document).ready(function () {
    let originalCategoryName = "";

    function loadDataToEdit(categoryId) {
        $.ajax({
            url: `/MindMaze/admin/category?id=${categoryId}`,
            type: "GET",
            dataType: "json",
            success: function (category) {
                $("#edit-category-name").val(category.categoryName);
                originalCategoryName = category.categoryName; // تحديد الاسم الأصلي بعد تعبئة الحقل
                $("#edit-category").attr("data-id", categoryId);
                $("#save-edit-btn").prop("disabled", true);
            },
            error: function (xhr, status, error) {
                toastr.error("Error loading category: " + error);
            }
        });
    }

    $("#edit-category-name").one("focus", function () {
        $(this).data("original", $(this).val().trim());
    });

    $("#edit-category-name").on("input", function () {
        let originalName = $(this).data("original");
        let newName = $(this).val().trim();

        if (newName !== originalName && newName.length > 0) {
            $("#save-edit-btn").prop("disabled", false);
        } else {
            $("#save-edit-btn").prop("disabled", true);
            toastr.error("Please enter a valid category name.");

        }
    });

    function editCategory() {
        let categoryId = $("#edit-category").attr("data-id");
        let updatedName = $("#edit-category-name").val().trim();

        if (!categoryId) {
            toastr.error("Error: Category ID not found.");
            return;
        }

        // if (updatedName.length === 0) {
        //     toastr.error("Please enter a valid category name.");
        //     return;
        // }


        $.ajax({
            url: "/MindMaze/admin/category",
            type: "PUT",
            contentType: "application/json",
            data: JSON.stringify({
                categoryId: categoryId,
                categoryName: updatedName
            }),
            success: function (response) {
                Swal.fire({
                    title: 'Category',
                    text: ' Category updated successfully! ',
                    icon: 'info',
                    confirmButtonText: 'OK'
                });
                $("#edit-category-name").val("");
                loadCategories();
                $("#save-edit-btn").prop("disabled", true);
            },
            error: function (xhr, status, error) {
                toastr.error("Error updating category: " + error);
            }
        });
    }

    window.loadDataToEdit = loadDataToEdit;
    window.editCategory = editCategory;
});
