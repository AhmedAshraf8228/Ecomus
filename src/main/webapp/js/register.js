$(document).ready(function () {
    $('#register-form').on('submit', async function (event) {
        console.log("submitted fun");
        event.preventDefault(); // Prevent form submission
        event.stopPropagation(); // Stop propagation of the event

        let isFormValid = true;

        // Iterate through all the validation functions and await them
        for (let i = 0; i < validationFunctions.length; i++) {
            let validationResult = await validationFunctions[i](); // Wait for each validation function's result
            console.log(validationFunctions[i] + ": " + validationResult);
            if (!validationResult) {
                isFormValid = false; // If any validation fails, set the form to invalid
                break; // Stop checking further validations if any one fails
            }
        }

        // If all validations pass, submit the form
        if (isFormValid) {
            $(this).off('submit').submit();  // Remove the submit handler and submit the form
        } else {
            console.log("Form validation failed.");
        }
    });

    // Email blur event (triggered when the email field loses focus)
    $('#email').on('blur', validateEmail);

});


function updateValid(field) {
    field.removeClass('is-invalid').addClass('is-valid');
    field.siblings('.invalid-feedback').hide(); // Hide the error message
    return true; // Valid input
}

function updateUnValid(field) {
    field.addClass('is-invalid').removeClass('is-valid');
    field.siblings('.invalid-feedback').show();
    field.focus();
    return false; // Invalid input
}

async function validateEmail() {
    let emailField = $('#email');
    $('#invalidStructure').hide();
    $('#invalidEmail').hide();
    $('#validEmail').hide();

    var email = emailField.val();
    var emailRegex = /^[a-zA-Z0-9._-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,6}$/;

    // Check if email is in correct format
    if (email && emailRegex.test(email)) {
        try {
            // Wait for the AJAX response
            let response = await $.ajax({
                url: 'validate-email',  // Backend URL for email validation
                method: 'GET',
                data: { email: email },  // Send the email to the server
            });

            // Handle the server response
            if (response === 'valid') {
                emailField.removeClass('is-invalid').addClass('is-valid');
                $('#validEmail').show();
                return true;  // Email is valid
            } else {
                emailField.removeClass('is-valid').addClass('is-invalid');
                $('#invalidEmail').show();
                emailField.focus()
                return false;  // Email is invalid
            }
        } catch (error) {
            // Handle AJAX error
            $('#emailValidationMessage').text('Error occurred while validating email').css('color', 'red');
            emailField.addClass('is-invalid').removeClass('is-valid');
            emailField.focus()
            return false;  // If there's an error with the AJAX request
        }
    } else {
        // If the email structure is invalid, mark it as invalid
        $('#invalidStructure').show();
        emailField.addClass('is-invalid').removeClass('is-valid');
        emailField.focus()
        return false;  // Invalid email format
    }
}




function validateUserName() {
    var userName = $('#userName');
    if (userName.val().trim() === "") {
        return updateUnValid(userName);
    } else {
        return updateValid(userName);
    }
}

function validatePassword() {
    let passwordField = $('#password');
    let password = passwordField.val();
    let passwordRegex = /^[a-zA-Z0-9]{6,}$/; // Example regex for password
    if (password.trim() !== "" && passwordRegex.test(password)) {
        return updateValid(passwordField);
    } else {
        return updateUnValid(passwordField);
    }
}

function validateConfirmPassword() {
    let passwordField = $('#password');
    let confirmPasswordField = $('#confirmPassword');
    let password = passwordField.val();
    let confirmPassword = confirmPasswordField.val();
    if (password.trim() !== "" && confirmPassword.trim() !== "" && password === confirmPassword) {
        return updateValid(confirmPasswordField);

    } else {
        return updateUnValid(confirmPasswordField);
    }

}

function validateBirthday() {
    let birthdayField = $('#BD');
    if (birthdayField.val().trim() === "") {
        return updateValid(birthdayField);
    } else {
        let birthday = new Date(birthdayField.val());
        let today = new Date();
        let age = today.getFullYear() - birthday.getFullYear();
        let month = today.getMonth() - birthday.getMonth();

        if (month < 0 || (month === 0 && today.getDate() < birthday.getDate())) {
            age--;
        }

        if (isNaN(birthday.getTime()) || age < 0) {
            return updateUnValid(birthdayField);

        } else {
            return updateValid(birthdayField);

        }
    }
}

function validateBuildingNo() {
    let buildingNoField = $('#buildingNo');
    let buildingNo = buildingNoField.val();

    // Check if the value is a valid positive number
    if (buildingNo.trim() !=="" && (isNaN(buildingNo) || buildingNo <= 0)) {
        return updateUnValid(buildingNoField);
    } else {
        return updateValid(buildingNoField)
    }
}

function validateCreditNo() {
    let creditNoField = $('#creditNo');
    let creditNo = creditNoField.val().trim();
    // Pattern for credit number like 1234 5678 9876 5432 or 1234-5678-9876-5432
    let creditNoRegex = /^(\d{4}[-\s]?){3}\d{4}$/;
    if (creditNo <= 0 || creditNoRegex.test(creditNo)) {
        return updateValid(creditNoField);
    } else {
        return updateUnValid(creditNoField);
    }
}

function validateCreditLimit() {
    let creditLimitField = $('#creditLimit');
    let creditLimit = creditLimitField.val();

    // Check if the value is a valid number and greater than 0
    if (isNaN(creditLimit) || creditLimit < 0) {
        return updateUnValid(creditLimitField); // Mark as invalid if not a number or <= 0
    } else {
        return updateValid(creditLimitField); // Mark as valid if it passes the conditions
    }
}

function validatePhone() {
    let phoneField = $('#phone2');
    let phone = phoneField.val();

    // Regular expression for validating the phone number format
    let phoneRegex = /^01([5201])\d{8}$/;

    // Check if the phone number matches the regex
    if (phone <= 0 || phoneRegex.test(phone)) {
        return updateValid(phoneField); // Mark as valid if it matches the pattern
    } else {
        return updateUnValid(phoneField); // Mark as invalid if it doesn't match
    }
}

// Create an array of validation functions
const validationFunctions = [
    validateUserName,
    validateEmail,
    validatePassword,
    validateConfirmPassword,
    validateBirthday,
    validateBuildingNo,
    validateCreditNo,
    validateCreditLimit,
    validatePhone
];

