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

function loadDataToEdit(categoryId){

    $.ajax({
        url: "/MindMaze/api/category/id=${categoryId}", // جلب بيانات الفئة من API
        type: "GET",
        dataType: "json",
        success: function (category) {
            $("#edit-category-name").val(category.categoryName); // وضع الاسم داخل الإدخال
            $("#edit-category").attr("data-id", categoryId); // تخزين الـ ID لاستخدامه عند التعديل
        },
        error: function (xhr, status, error) {
           alert("Error loading category:");
        }
    });
}
function editCategory(){

}