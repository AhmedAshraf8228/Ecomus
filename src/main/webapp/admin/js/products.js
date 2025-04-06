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

const imageInput = document.getElementById("product-images");
const imagePreviewBox = document.getElementById("image-preview-box");

imageInput.addEventListener("change", function (event) {
    const files = event.target.files;

    // Clear the preview box
    imagePreviewBox.innerHTML = "";

    if (files.length > 5) {
        alert("You can only select up to 5 images.");
        return;
    }

    Array.from(files).forEach(file => {
        const reader = new FileReader();
        reader.onload = function(e) {
            const imageContainer = document.createElement("div");
            imageContainer.classList.add("image-container");

            const img = document.createElement("img");
            img.src = e.target.result;
            img.classList.add("image-preview");

            const removeBtn = document.createElement("button");
            removeBtn.textContent = "Remove";
            removeBtn.classList.add("remove-image-btn");

            // Remove image functionality
            removeBtn.addEventListener("click", function() {
                imageContainer.remove();
            });

            imageContainer.appendChild(img);
            imageContainer.appendChild(removeBtn);
            imagePreviewBox.appendChild(imageContainer);
        };
        reader.readAsDataURL(file);
    });
});


