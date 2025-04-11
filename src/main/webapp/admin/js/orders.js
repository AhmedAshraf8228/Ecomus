function searchOrder() {
    let input = document.getElementById("search-input").value.toLowerCase();
    let table = document.querySelector("table");
    let rows = table.getElementsByTagName("tbody")[0].getElementsByTagName("tr");

    for (let i = 0; i < rows.length; i++) {
    let orderId = rows[i].getElementsByTagName("td")[0].innerText.toLowerCase();
    rows[i].style.display = orderId.includes(input) ? "" : "none";
}
}

$(document).ready(
    function (){
        loadOrders()
    }
);

function loadOrders(){
    $.ajax({
        url: "/MindMaze/api/orders",
        type: "GET",
        dataType: "json",
        // success: function (response) {
        //     console.log("Response:", response);
        //     if (Array.isArray(response)) {
        //         response.forEach(order => console.log(order));
        //     } else {
        //         console.error("Not an array:", response);
        //     }
        // },
        success: function (orders) {
            let tableBody = $("#order-tbody");
            tableBody.empty(); // Clear existing rows

            orders.forEach(order => {
                let payTypeClass = order.payType === "COD" ? "status COD" : "status CREDIT";
                let statusClass;
                if (order.status === "COMPLETED") {
                    statusClass = "fulfillment completed";
                } else if (order.status === "CANCELED") {
                    statusClass = "fulfillment Canceled";
                } else if (order.status === "PROCESSING") {
                    statusClass = "fulfillment processed";
                }
                let row = `
                <tr>
                    <td>${order.orderId}</td>
                    <td>${order.date}</td>
                    <td>#${order.user.userId}</td>
                    <td><span class="${payTypeClass}">${order.payType}</span></td>
                    <td><span class="${statusClass}">${order.status}</span></td>
                    <td>${order.price} <b>EGP</b></td>
                </tr>
    `;
                tableBody.append(row); // Assuming tableBody is a reference to your <tbody> element
            });

        },
        error: function (xhr, status, error) {
            console.error("Error:", error);
        }
    });

}
