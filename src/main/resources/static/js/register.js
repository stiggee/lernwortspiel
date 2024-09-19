// /////////////////////////////////////////////////////////////////

$(document).ready(function () {
    validateForm();
    initDatepicker();
});

///////////////////////////////////////////////////////////////////

function initDatepicker() {
    $('#datepicker').datepicker({
        format: 'dd/mm/yyyy',
        autoclose: true,
        todayHighlight: true,
        startDate: '01.01.1950',
        endDate: '01.01.2012',
        orientation: 'bottom auto',
        startView: 'years',
    });
}

function validateForm() {
    $('form.needs-validation').on('submit', function(event) {
        let isValid = true; // Сброс состояния валидации перед проверкой

        let firstname = $('#input_firstname');
        let lastname = $('#input_lastname');
        let email = $('#input_email');
        let birthdate = $('#datepicker');
        let password = $('#input_password');
        let password_confirm = $('#input_password_confirm');
        let phone = $('#input_phone');
        let agreement = $('#input_agreement');

        // Проверка всех полей
        isValid = isEmpty(firstname) && isValid;
        isValid = isEmpty(lastname) && isValid;
        isValid = isEmail(email) && isValid;
        isValid = isEmpty(birthdate) && isValid;
        isValid = isPassword(password) && isValid;
        isValid = isPasswordConfirm(password, password_confirm) && isValid;
        isValid = isAgree(agreement) && isValid;
        isValid = isPhone(phone) && isValid;

        // Привязка событий для полей
        firstname.on('input', function() { isEmpty($(this)) });
        lastname.on('input', function() { isEmpty($(this)) });
        email.on('input', function() { isEmail($(this)) });
        birthdate.on('change', function() { isEmpty($(this)) });
        password.on('input', function() { isPassword($(this)) });
        password_confirm.on('input', function() { isPasswordConfirm($('#input_password'), $(this)) });
        phone.on('input', function() { isPhone($(this)) });
        agreement.on('change', function() { isAgree($(this)) });

        // Если форма невалидна, предотвращаем отправку
        if (!isValid) {
            event.preventDefault();
            event.stopPropagation();
        }

    });


}

function isEmpty($item) {
    if ($item.val().length === 0) {
        $item.addClass('is-invalid');
        return false;
    } else {
        $item.removeClass('is-invalid');
        return true;
    }
}

function isEmail($email){
    const emailPattern = /^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/;
    if (!emailPattern.test($email.val())){
        $email.addClass('is-invalid');
        return false;
    } else {
        $email.removeClass('is-invalid');
        return true;
    }
}

function isPassword($password){
    const passwordPattern = /^(?=.*[A-Z])(?=.*\d)[A-Za-z\d]{8,}$/;
    if (!passwordPattern.test($password.val())) {
        $password.addClass('is-invalid');
        return false;
    } else {
        $password.removeClass('is-invalid');
        return true;
    }
}

function isPasswordConfirm($password, $password_confirm){
    if ($password_confirm.val() !== $password.val()) {
        $password_confirm.addClass('is-invalid');
        return false;
    } else {
        $password_confirm.removeClass('is-invalid');
        return true;
    }
}

function isAgree($agreement){
    if (!$agreement.is(':checked')) {
        $agreement.addClass('is-invalid');
        return false;
    } else {
        $agreement.removeClass('is-invalid');
        return true;
    }
}

function isPhone($phone) {
    const phone_pattern_de = /^[1-9]\d{1,3}\d{3,10}$/;
    const phone_pattern_ua = /^[1-9]\d{8,9}$/;
    const countryCode = $('#countrySelect').val();

    switch (countryCode){
        case '+49':
            if (!phone_pattern_de.test($phone.val())){
                $phone.addClass('is-invalid');
                return false;
            } else {
                $phone.removeClass('is-invalid');
                return true;
            }
        case '+380':
            if (!phone_pattern_ua.test($phone.val())){
                $phone.addClass('is-invalid');
                return false;
            } else {
                $phone.removeClass('is-invalid');
                return true;
            }
        default:
            $phone.addClass('is-invalid');
            return false;
    }
}
