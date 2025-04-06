function searchCustomer() {
    let input = document.getElementById("search-input").value.toLowerCase();
    let rows = document.getElementsByTagName("tr");

    for (let i = 1; i < rows.length; i++) {
        let id = rows[i].getElementsByTagName("td")[0].innerText.toLowerCase();
        if (id.includes(input)) {
            rows[i].style.display = "";
        } else {
            rows[i].style.display = "none";
        }
    }
}