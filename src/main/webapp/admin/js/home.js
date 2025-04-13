$(document).ready(function () {
    $.ajax({
        url: '/MindMaze/admin/dashboard',
        type: 'GET',
        dataType: 'json',
        success: function (data) {
            if (data.totalOrders !== undefined && data.totalUsers !== undefined && data.totalCategories !== undefined) {
                $('#totalOrders').text(data.totalOrders);
                $('#totalCustomers').text(data.totalUsers);
                $('#totalCategories').text(data.totalCategories);
                console.log("Dashboard data loaded successfully!");
            } else {
                alert('Invalid response data');
            }
        },
        error: function (xhr, status, error) {
            console.error('AJAX Error:', status, error);
            alert('Failed to fetch data. Status: ' + xhr.status);
        }
    });
});
