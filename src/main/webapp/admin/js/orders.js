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

function loadOrders() {
    $.ajax({
        url: "/MindMaze/admin/orders",
        type: "GET",
        dataType: "json",
        success: function (orders) {
            let tableBody = $("#order-tbody");
            tableBody.empty();

            orders.forEach(order => {
                let payTypeClass = order.payType === "COD" ? "status.COD" : "status.CREDIT";
                let statusClass;
                let statusContent;
                let actionButtons = "";

                if (order.status === "COMPLETED") {
                    statusClass = "fulfillment completed";
                    statusContent = `<span class="${statusClass}">${order.status}</span>`;
                    actionButtons = `<span class="no-action">--</span>`;
                } else if (order.status === "CANCELED") {
                    statusClass = "fulfillment Canceled";
                    statusContent = `<span class="${statusClass}">${order.status}</span>`;
                    actionButtons = `<span class="no-action">--</span>`;
                } else if (order.status === "PROCESSING") {
                    statusClass = "fulfillment processed";
                    statusContent = `<span class="${statusClass}">${order.status}</span>`;
                    actionButtons = `
                        <button class="status-button complete-btn" onclick="updateOrderStatus(${order.orderId}, 'COMPLETED')">Complete</button>
                        <button class="status-button cancel-btn" onclick="updateOrderStatus(${order.orderId}, 'CANCELED')">Cancel</button>
                    `;
                }




                let row = `
                    <tr>
                        <td>${order.orderId}</td>
                        <td>${order.date}</td>
                        <td>#${order.user.userId}</td>
                        <td><span class="${payTypeClass}">${order.payType}</span></td>
                        <td>${statusContent}</td>
                        <td>${order.price} <b>EGP</b></td>
                        <td>${actionButtons}</td>
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

function updateOrderStatus(orderId, newStatus) {
    $.ajax({
        url: "/MindMaze/admin/orders",
        type: "PUT",
        contentType: "application/json",
        data: JSON.stringify({ orderId: orderId, status: newStatus }),
        success: function(response) {
            alert("Order status updated!");
            loadOrders();
        },
        error: function(xhr, status, error) {
            console.error("Failed to update status:", error);
            alert("Error updating order status.");
        }
    });
}

