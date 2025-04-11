
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
        url: "/MindMaze/api/category",
        type: "GET",
        dataType: "json",
        success: function (categories) {
            let tableBody = $("#category-tbody");
            tableBody.empty();

            categories.forEach(cat => {
                let row = `
                <tr>
                    <td>${cat.categoryId}</td>
                    <td>${cat.categoryName}</td>
                    <td>0</td>
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
            console.error("Error:", error);
        }
    });

}

function addCategory() {
    let categoryName = $("#category-name").val().trim();

    if (categoryName === "") {
        alert("Category name cannot be empty!");
        return;
    }

    $.ajax({
        url: "/MindMaze/api/category",
        type: "POST",
        contentType: "application/json",
        data: JSON.stringify({ categoryName: categoryName }),
        success: function (response) {
            alert("Category added successfully!");
            $("#category-name").val("");
            loadCategories();
        },
        error: function () {
            alert("Failed to add category.");
        }
    });
}


function deleteCategory(categoryId) {
    if (confirm("Are you sure you want to delete this category?")) {
        $.ajax({
            url: `/MindMaze/api/category?categoryId=${categoryId}`,
            type: "DELETE",
            success: function () {
                loadCategories();
            },
            error: function () {
                alert("Failed to delete the category.");
            }
        });
    }
}

// function loadDataToEdit(categoryId){
//
//     $.ajax({
//         url: `/MindMaze/api/category?id=${categoryId}`,
//         type: "GET",
//         dataType: "json",
//         success: function (category) {
//             $("#edit-category-name").val(category.categoryName); // وضع الاسم داخل الإدخال
//             $("#edit-category").attr("data-id", categoryId); // تخزين الـ ID لاستخدامه عند التعديل
//         },
//         error: function (xhr, status, error) {
//            alert("Error loading category:");
//         }
//     });
// }
$(document).ready(function () {
    let originalCategoryName = "";

    function loadDataToEdit(categoryId) {
        $.ajax({
            url: `/MindMaze/api/category?id=${categoryId}`,
            type: "GET",
            dataType: "json",
            success: function (category) {
                $("#edit-category-name").val(category.categoryName);
                originalCategoryName = category.categoryName; // تحديد الاسم الأصلي بعد تعبئة الحقل
                $("#edit-category").attr("data-id", categoryId);
                $("#save-edit-btn").prop("disabled", true);
                console.log("Loaded category ID:", categoryId);
            },
            error: function (xhr, status, error) {
                alert("Error loading category: " + error);
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
        }
    });

    // عند الضغط على زر التعديل، يتم إرسال الطلب إلى السيرفر
    function editCategory() {
        let categoryId = $("#edit-category").attr("data-id");
        let updatedName = $("#edit-category-name").val().trim();

        console.log("Category ID on edit:", categoryId);
        // التحقق من القيم قبل إرسال الطلب
        if (!categoryId) {
            alert("Error: Category ID not found.");
            return;
        }

        if (updatedName.length === 0) {
            alert("Please enter a valid category name.");
            return;
        }

        console.log("Updating category:", { categoryId, updatedName });

        $.ajax({
            url: "/MindMaze/api/category",
            type: "PUT",
            contentType: "application/json",
            data: JSON.stringify({
                categoryId: categoryId,
                categoryName: updatedName
            }),
            success: function (response) {
                alert("Category updated successfully!");
                $("#edit-category-name").val("");
                loadCategories();
                $("#save-edit-btn").prop("disabled", true);
            },
            error: function (xhr, status, error) {
                alert("Error updating category: " + error);
            }
        });
    }

    window.loadDataToEdit = loadDataToEdit;
    window.editCategory = editCategory;
});
