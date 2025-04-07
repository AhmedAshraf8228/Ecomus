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
                        <button class="edit-button">Edit</button>
                        <button class="delete-button">Delete</button>
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