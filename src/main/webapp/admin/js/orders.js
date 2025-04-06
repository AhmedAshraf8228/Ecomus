function searchOrder() {
    let input = document.getElementById("search-input").value.toLowerCase();
    let table = document.querySelector("table");
    let rows = table.getElementsByTagName("tbody")[0].getElementsByTagName("tr");

    for (let i = 0; i < rows.length; i++) {
    let orderId = rows[i].getElementsByTagName("td")[0].innerText.toLowerCase();
    rows[i].style.display = orderId.includes(input) ? "" : "none";
}
}
