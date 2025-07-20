document.addEventListener('DOMContentLoaded', () => {
    const loginForm = document.getElementById('loginForm');
    const emailInput = document.getElementById('email');
    const passwordInput = document.getElementById('password');

    const tooltipTriggerList = document.querySelectorAll('[data-bs-toggle="tooltip"]');
    const tooltips = [...tooltipTriggerList].map(el => {
        return new bootstrap.Tooltip(el, {
            trigger: 'focus',
            placement: 'right',
            customClass: 'custom-tooltip'
        });
    });

    const emailPattern = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;

    loginForm.addEventListener('submit', (e) => {
        let valid = true;

        emailInput.classList.remove('is-invalid', 'is-valid');
        passwordInput.classList.remove('is-invalid', 'is-valid');

        if (!emailPattern.test(emailInput.value)) {
            emailInput.classList.add('is-invalid');
            valid = false;
            const emailTooltip = tooltips.find(t => t._element === emailInput);
            if (emailTooltip) {
                emailTooltip.setContent({ '.tooltip-inner': 'Entrez une adresse email valide.' });
            }
        } else {
            emailInput.classList.add('is-valid');
        }

        if (passwordInput.value.length < 8) {
            passwordInput.classList.add('is-invalid');
            valid = false;
            const passwordTooltip = tooltips.find(t => t._element === passwordInput);
            if (passwordTooltip) {
                passwordTooltip.setContent({ '.tooltip-inner': 'Le mot de passe doit contenir au moins 8 caractères.' });
            }
        } else {
            passwordInput.classList.add('is-valid');
        }

        if (!valid) {
            e.preventDefault();
        }
    });

    emailInput.addEventListener('input', () => {
        const emailTooltip = tooltips.find(t => t._element === emailInput);
        if (emailPattern.test(emailInput.value)) {
            emailInput.classList.remove('is-invalid');
            emailInput.classList.add('is-valid');
            if (emailTooltip) {
                emailTooltip.setContent({ '.tooltip-inner': 'Adresse email valide !' });
            }
        } else {
            emailInput.classList.remove('is-valid');
            emailInput.classList.add('is-invalid');
            if (emailTooltip) {
                emailTooltip.setContent({ '.tooltip-inner': 'Entrez une adresse email valide.' });
            }
        }
    });

    passwordInput.addEventListener('input', () => {
        const passwordTooltip = tooltips.find(t => t._element === passwordInput);
        if (passwordInput.value.length >= 8) {
            passwordInput.classList.remove('is-invalid');
            passwordInput.classList.add('is-valid');
            if (passwordTooltip) {
                passwordTooltip.setContent({ '.tooltip-inner': 'Longueur de mot de passe valide !' });
            }
        } else {
            passwordInput.classList.remove('is-valid');
            passwordInput.classList.add('is-invalid');
            if (passwordTooltip) {
                passwordTooltip.setContent({ '.tooltip-inner': 'Le mot de passe doit contenir au moins 8 caractères.' });
            }
        }
    });

    [emailInput, passwordInput].forEach(input => {
        input.addEventListener('touchstart', () => {
            const tooltip = tooltips.find(t => t._element === input);
            if (tooltip) tooltip.show();
        });
        input.addEventListener('touchend', () => {
            const tooltip = tooltips.find(t => t._element === input);
            if (tooltip) tooltip.hide();
        });
    });
});