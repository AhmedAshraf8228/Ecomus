$(document).ready(function () {
    $('.invalid-old').hide();
    $('#form-account-update').on('submit', async function (event) {
        console.log("submitted fun");
        event.preventDefault(); // Prevent form submission
        event.stopPropagation(); // Stop propagation of the event

        let isFormValid = true;

        for (let i = 0; i < validationFunctions.length; i++) {
            let validationResult = await validationFunctions[i](true);
            if (!validationResult) {
                isFormValid = false;
                break;
            }
        }

        // If all validations pass, submit the form
        if (isFormValid) {
            $(this).off('submit').submit();
        } else {
            console.log("Form validation failed.");
        }
    });

    addOnBlur();
});


function updateValid(field) {
    field.removeClass('is-invalid').addClass('is-valid');
    field.siblings('.invalid-feedback').hide();
    field.siblings('.invalid-old').hide();
   // Hide the error message
    return true; // Valid input
}

function updateUnValid_old_new(field, flag) {
    field.addClass('is-invalid').removeClass('is-valid');
    field.siblings('.invalid-old').show();
    field.siblings('.invalid-feedback').hide();
    if (flag) {
        field.focus();
    }
    return false; // Invalid input
}

function updateUnValid(field, flag) {
    field.addClass('is-invalid').removeClass('is-valid');
    field.siblings('.invalid-feedback').show();
    field.siblings('.invalid-old').hide();
    if (flag) {
        field.focus();
    }
    return false; // Invalid input
}

// async function validateEmail(flag) {
//     let emailField = $('#email');
//     $('#invalidStructure').hide();
//     $('#invalidEmail').hide();
//     $('#validEmail').hide();

//     var email = emailField.val();
//     var emailRegex = /^[a-zA-Z0-9._-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,6}$/;

//     // Check if email is in correct format
//     if (email && emailRegex.test(email)) {
//         try {
//             // Wait for the AJAX response
//             let response = await $.ajax({
//                 url: 'validate-email',  // Backend URL for email validation
//                 method: 'GET',
//                 data: {email: email},  // Send the email to the server
//             });

//             // Handle the server response
//             if (response === 'valid') {
//                 emailField.removeClass('is-invalid').addClass('is-valid');
//                 $('#validEmail').show();
//                 return true;  // Email is valid
//             } else {
//                 emailField.removeClass('is-valid').addClass('is-invalid');
//                 $('#invalidEmail').show();
//                 if (flag) emailField.focus();
//                 return false;  // Email is invalid
//             }
//         } catch (error) {
//             // Handle AJAX error
//             $('#emailValidationMessage').text('Error occurred while validating email').css('color', 'red');
//             emailField.addClass('is-invalid').removeClass('is-valid');
//             if (flag) emailField.focus();
//             return false;  // If there's an error with the AJAX request
//         }
//     } else {
//         // If the email structure is invalid, mark it as invalid
//         $('#invalidStructure').show();
//         emailField.addClass('is-invalid').removeClass('is-valid');
//         if (flag) emailField.focus();
//         return false;  // Invalid email format
//     }
// }


function validateUserName(flag) {
    var userName = $('#userName');
    if (userName.val().trim() === "") {
        return updateUnValid(userName, flag);
    } else {
        return updateValid(userName);
    }
}



function validateOldPassword(flag) {
    let oldPasswordField = $('#oldpassword');
    let oldPassword = oldPasswordField.val().trim();
    
  
    if (oldPassword === "" && $('#password').val().trim() !== "") {
        return updateUnValid_old_new(oldPasswordField, flag);
    }

    if (oldPassword !== "") {
        let passwordRegex = /^[a-zA-Z0-9]{6,}$/;
        if (!passwordRegex.test(oldPassword)) {
            return updateUnValid(oldPasswordField, flag);
        }
    }
    
    return updateValid(oldPasswordField);
}



function validatePassword(flag) {
    let passwordField = $('#password');
    let password = passwordField.val();
    
    if (password.trim() === "") {
        return updateValid(passwordField);
    }
    
    let passwordRegex = /^[a-zA-Z0-9]{6,}$/;
    if (passwordRegex.test(password)) {
        return updateValid(passwordField);
    } else {
        return updateUnValid(passwordField, flag);
    }
}



function validateConfirmPassword(flag) {
    let passwordField = $('#password');
    let confirmPasswordField = $('#confirmPassword');
    let password = passwordField.val();
    let confirmPassword = confirmPasswordField.val();
    
    if (password.trim() === "" && confirmPassword.trim() === "") {
        return updateValid(confirmPasswordField);
    }
    
    if (password === confirmPassword) {
        return updateValid(confirmPasswordField);
    } else {
        return updateUnValid(confirmPasswordField, flag);
    }
}

function validateBirthday(flag) {
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
        if (isNaN(birthday.getTime()) || age < 0 || age >100) {
            return updateUnValid(birthdayField, flag);

        } else {
            return updateValid(birthdayField);
        }
    }
}

function validateBuildingNo(flag) {
    let buildingNoField = $('#buildingNo');
    let buildingNo = buildingNoField.val();

    // Check if the value is a valid positive number
    if (buildingNo.trim() !== "" && (isNaN(buildingNo) || buildingNo <= 0)) {
        return updateUnValid(buildingNoField, flag);
    } else {
        return updateValid(buildingNoField)
    }
}

function validateCreditNo(flag) {
    let creditNoField = $('#creditNo');
    let creditNo = creditNoField.val().trim();
    // Pattern for credit number like 1234 5678 9876 5432 or 1234-5678-9876-5432
    let creditNoRegex = /^(\d{4}[-\s]?){3}\d{4}$/;
    if (creditNo <= 0 || creditNoRegex.test(creditNo)) {
        return updateValid(creditNoField);
    } else {
        return updateUnValid(creditNoField, flag);
    }
}

function validateCreditLimit(flag) {
    let creditLimitField = $('#creditLimit');
    let creditLimit = creditLimitField.val();

    // Check if the value is a valid number and greater than 0
    if (isNaN(creditLimit) || creditLimit < 0) {
        return updateUnValid(creditLimitField, flag); // Mark as invalid if not a number or <= 0
    } else {
        return updateValid(creditLimitField); // Mark as valid if it passes the conditions
    }
}

function validatePhone(flag) {
    let phoneField = $('#phone');
    let phone = phoneField.val();

    // Regular expression for validating the phone number format
    let phoneRegex = /^01([5201])\d{8}$/;

    // Check if the phone number matches the regex
    if (phoneRegex.test(phone)) {
        return updateValid(phoneField); // Mark as valid if it matches the pattern
    } else {
        return updateUnValid(phoneField, flag); // Mark as invalid if it doesn't match
    }
}

// Create an array of validation functions
const validationFunctions = [
    validateUserName,
    // validateEmail,
    validateOldPassword,
    validatePassword,
    validateConfirmPassword,
    validateBirthday,
    validateBuildingNo,
    validateCreditNo,
    validateCreditLimit,
    validatePhone
];

function addOnBlur() {
    // $('#email').on('blur', function () {
    //     validateEmail(false);  // Pass false to prevent focusing on the field during blur
    // });
    $('#userName').on('blur', function () {
        validateUserName(false);  // Pass false to prevent focusing on the field during blur
    });
 
        // Add this to your existing onBlur handlers
        $('#oldpassword').on('blur', function () {
            validateOldPassword(false);
        });
    $('#password').on('blur', function () {
        validatePassword(false);  // Pass false to prevent focusing on the field during blur
    });
    $('#confirmPassword').on('blur', function () {
        validateConfirmPassword(false);  // Pass false to prevent focusing on the field during blur
    });
    $('#BD').on('blur', function () {
        validateBirthday(false);  // Pass false to prevent focusing on the field during blur
    });
    $('#buildingNo').on('blur', function () {
        validateBuildingNo(false);  // Pass false to prevent focusing on the field during blur
    });
    $('#creditNo').on('blur', function () {
        validateCreditNo(false);  // Pass false to prevent focusing on the field during blur
    });
    $('#creditLimit').on('blur', function () {
        validateCreditLimit(false);  // Pass false to prevent focusing on the field during blur
    });
    $('#phone').on('blur', function () {
        validatePhone(false);  // Pass false to prevent focusing on the field during blur
    });

}