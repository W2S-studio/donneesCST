document.addEventListener('DOMContentLoaded', function () {
    const form = document.getElementById('requestVerificationForm');
    const emailInput = document.getElementById('email');

    const tooltipTriggerList = [].slice.call(document.querySelectorAll('[data-bs-toggle="tooltip"]'));
    tooltipTriggerList.map(function (tooltipTriggerEl) {
        return new bootstrap.Tooltip(tooltipTriggerEl);
    });

    function validateEmail(email) {
        const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
        return emailRegex.test(email);
    }

    function showError(input, message) {
        input.classList.add('is-invalid');
        let errorDiv = input.parentNode.nextElementSibling;
        if (errorDiv && errorDiv.classList.contains('invalid-feedback')) {
            errorDiv.textContent = message;
        }
    }

    function clearError(input) {
        input.classList.remove('is-invalid');
    }

    if (emailInput) {
        emailInput.addEventListener('input', function () {
            const email = this.value.trim();

            if (email === '') {
                clearError(this);
                return;
            }

            if (!validateEmail(email)) {
                showError(this, 'Veuillez entrer une adresse email valide');
            } else {
                clearError(this);
            }
        });

        emailInput.addEventListener('blur', function () {
            const email = this.value.trim();

            if (email === '') {
                showError(this, 'L\'adresse email est obligatoire');
            } else if (!validateEmail(email)) {
                showError(this, 'Veuillez entrer une adresse email valide');
            }
        });
    }

    form.addEventListener('submit', function (e) {
        let isValid = true;

        if (emailInput) {
            const email = emailInput.value.trim();

            if (email === '') {
                showError(emailInput, 'L\'adresse email est obligatoire');
                isValid = false;
            } else if (!validateEmail(email)) {
                showError(emailInput, 'Veuillez entrer une adresse email valide');
                isValid = false;
            } else {
                clearError(emailInput);
            }
        }

        if (!isValid) {
            e.preventDefault();
        }
    });
});