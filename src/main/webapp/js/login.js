"use strict";
$(document).ready(function () {
    $('#login-form').on('submit', function (event) {
        event.preventDefault(); // Prevent the default form submission

        let email = $('#email').val();
        let password = $('#password').val();

        $.ajax({
            url: 'login',
            method: 'POST',
            data: {
                email: email,
                password: password
            },
            dataType: 'text', // Expect plain text response ('valid', 'invalid', or 'error')
            success: function(response) {
                check(response);
            },
            error: function(data) {
                console.log(data);
                alert("There was an error with the request. Please try again later.");
            }
        });
    });
});

function check(response) {
    if (response === 'valid') {
        $('#invalidLogin').hide();
        window.location.href = "home?ts=" + new Date().getTime();
    } else if (response === 'invalid') {
        $('#invalidLogin').show();
    } else if (response === 'error') {
        alert("Please try again later");
    }else {
        alert(response);
    }
}
