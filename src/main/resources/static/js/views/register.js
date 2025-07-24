document.addEventListener('DOMContentLoaded', () => {
    const form = document.getElementById('registerForm');
    const username = document.getElementById('username');
    const email = document.getElementById('email');
    const password = document.getElementById('password');
    const confirmPwd = document.getElementById('password_confirm');
    const tos = document.getElementById('has_accepted_tos');
    const submitBtn = form.querySelector('button[type=submit]');

    const bars = [
        document.getElementById('strengthBar1'),
        document.getElementById('strengthBar2'),
        document.getElementById('strengthBar3'),
        document.getElementById('strengthBar4')
    ];
    const strengthText = document.getElementById('strengthText');

    const tooltipTriggerList = document.querySelectorAll('[data-bs-toggle="tooltip"]');
    const tooltips = [...tooltipTriggerList].map(el =>
        new bootstrap.Tooltip(el, {
            trigger: 'focus blur',
            placement: 'right',
            delay: { show: 200, hide: 100 }
        })
    );

    const validationModal = new bootstrap.Modal(
        document.getElementById('validationModal')
    );

    const fieldStates = {
        username: { touched: false, valid: false },
        email: { touched: false, valid: false },
        password: { touched: false, valid: false },
        confirmPassword: { touched: false, valid: false },
        tos: { touched: false, valid: false }
    };

    const emailPattern = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;

    function updateTosState() {
        tos.disabled = false;

        const tooltip = tooltips.find(t => t._element === tos);
        if (tooltip) {
            tooltip.setContent({
                '.tooltip-inner': 'Cochez pour accepter les conditions d\'utilisation'
            });
        }

        updateSubmitState();
    }

    function validateUsername(value) {
        if (!value.trim()) {
            return { valid: false, message: 'Le nom d\'utilisateur est requis.' };
        }
        if (value.length < 3) {
            return { valid: false, message: 'Le nom d\'utilisateur doit contenir au moins 3 caractères.' };
        }
        if (value.length > 20) {
            return { valid: false, message: 'Le nom d\'utilisateur ne peut pas dépasser 20 caractères.' };
        }
        if (!/^[a-zA-Z0-9_-]+$/.test(value)) {
            return { valid: false, message: 'Seuls les lettres, chiffres, tirets et underscores sont autorisés.' };
        }
        return { valid: true, message: 'Nom d\'utilisateur valide !' };
    }

    function validateEmail(value) {
        if (!value.trim()) {
            return { valid: false, message: 'L\'adresse email est requise.' };
        }
        if (!emailPattern.test(value)) {
            return { valid: false, message: 'Format d\'email invalide.' };
        }
        return { valid: true, message: 'Adresse email valide !' };
    }

    function validatePassword(value) {
        if (!value) {
            return {
                valid: false,
                message: 'Le mot de passe est requis.',
                strength: 0
            };
        }

        const hasLower = /[a-z]/.test(value);
        const hasUpper = /[A-Z]/.test(value);
        const hasDigit = /\d/.test(value);
        const hasSpecial = /[!@#$%^&*(),.?":{}|<>]/.test(value);
        const minLength = value.length >= 8;

        const criteriaMet = [hasLower, hasUpper, hasDigit, hasSpecial, minLength].filter(Boolean).length;

        if (!minLength) {
            return {
                valid: false,
                message: 'Le mot de passe doit contenir au moins 8 caractères.',
                strength: 0
            };
        }

        if (!hasLower || !hasUpper || !hasDigit || !hasSpecial) {
            const missing = [];
            if (!hasLower) missing.push('une minuscule');
            if (!hasUpper) missing.push('une majuscule');
            if (!hasDigit) missing.push('un chiffre');
            if (!hasSpecial) missing.push('un caractère spécial');

            return {
                valid: false,
                message: `Manque: ${missing.join(', ')}.`,
                strength: Math.min(criteriaMet, 2)
            };
        }

        let strength = 2;
        if (value.length >= 10) strength = 3;
        if (value.length >= 12) strength = 4;
        if (value.length >= 15) strength = 4;

        return {
            valid: true,
            message: 'Mot de passe fort ! Vous pouvez l\'allonger pour plus de sécurité.',
            strength: strength
        };
    }

    function validateConfirmPassword(value, originalPassword) {
        if (!value) {
            return { valid: false, message: 'Veuillez confirmer votre mot de passe.' };
        }
        if (value !== originalPassword) {
            return { valid: false, message: 'Les mots de passe ne correspondent pas.' };
        }
        if (!originalPassword) {
            return { valid: false, message: 'Saisissez d\'abord le mot de passe principal.' };
        }
        return { valid: true, message: 'Les mots de passe correspondent !' };
    }

    function updateFieldState(input, validation, fieldName) {
        const tooltip = tooltips.find(t => t._element === input);

        if (fieldStates[fieldName].touched) {
            input.classList.remove('is-valid', 'is-invalid');
            input.classList.add(validation.valid ? 'is-valid' : 'is-invalid');
        }

        if (tooltip) {
            tooltip.setContent({ '.tooltip-inner': validation.message });
        }

        fieldStates[fieldName].valid = validation.valid;
        updateSubmitState();
    }

    function updatePasswordStrength(strength) {
        const colors = ['', 'bg-danger', 'bg-warning', 'bg-info', 'bg-success'];
        const labels = ['', 'Faible', 'Moyen', 'Bon', 'Très fort'];

        bars.forEach((bar, i) => {
            bar.classList.remove('bg-danger', 'bg-warning', 'bg-info', 'bg-success');
            if (i < strength) {
                bar.classList.add(colors[strength]);
            }
        });

        strengthText.textContent = labels[strength] || 'Minimum requis';
    }

    function updateSubmitState() {
        const allFieldsValid = Object.entries(fieldStates)
            .filter(([key]) => key !== 'tos')
            .every(([, state]) => state.valid);

        const tosValid = tos.checked;

        submitBtn.disabled = !(allFieldsValid && tosValid);
    }

    username.addEventListener('input', () => {
        const validation = validateUsername(username.value);
        updateFieldState(username, validation, 'username');
    });

    username.addEventListener('blur', () => {
        fieldStates.username.touched = true;
        const validation = validateUsername(username.value);
        updateFieldState(username, validation, 'username');
    });

    email.addEventListener('input', () => {
        const validation = validateEmail(email.value);
        updateFieldState(email, validation, 'email');
    });

    email.addEventListener('blur', () => {
        fieldStates.email.touched = true;
        const validation = validateEmail(email.value);
        updateFieldState(email, validation, 'email');
    });

    password.addEventListener('input', () => {
        const validation = validatePassword(password.value);
        updatePasswordStrength(validation.strength || 0);
        updateFieldState(password, validation, 'password');

        if (fieldStates.confirmPassword.touched) {
            const confirmValidation = validateConfirmPassword(confirmPwd.value, password.value);
            updateFieldState(confirmPwd, confirmValidation, 'confirmPassword');
        }
    });

    password.addEventListener('blur', () => {
        fieldStates.password.touched = true;
        const validation = validatePassword(password.value);
        updateFieldState(password, validation, 'password');
    });

    confirmPwd.addEventListener('input', () => {
        const validation = validateConfirmPassword(confirmPwd.value, password.value);
        updateFieldState(confirmPwd, validation, 'confirmPassword');
    });

    confirmPwd.addEventListener('blur', () => {
        fieldStates.confirmPassword.touched = true;
        const validation = validateConfirmPassword(confirmPwd.value, password.value);
        updateFieldState(confirmPwd, validation, 'confirmPassword');
    });

    tos.addEventListener('change', () => {
        fieldStates.tos.touched = true;
        fieldStates.tos.valid = tos.checked;
        updateSubmitState();
    });

    form.addEventListener('submit', e => {
        Object.keys(fieldStates).forEach(key => {
            fieldStates[key].touched = true;
        });

        const usernameValidation = validateUsername(username.value);
        const emailValidation = validateEmail(email.value);
        const passwordValidation = validatePassword(password.value);
        const confirmValidation = validateConfirmPassword(confirmPwd.value, password.value);

        updateFieldState(username, usernameValidation, 'username');
        updateFieldState(email, emailValidation, 'email');
        updateFieldState(password, passwordValidation, 'password');
        updateFieldState(confirmPwd, confirmValidation, 'confirmPassword');

        if (!tos.checked) {
            e.preventDefault();
            validationModal.show();
            return;
        }

        const allValid = [usernameValidation, emailValidation, passwordValidation, confirmValidation]
            .every(v => v.valid);

        if (!allValid) {
            e.preventDefault();

            const firstInvalid = [username, email, password, confirmPwd]
                .find(field => field.classList.contains('is-invalid'));
            if (firstInvalid) {
                firstInvalid.focus();
            }

            showFormError('Veuillez corriger les erreurs dans le formulaire.');
        } else {
            submitBtn.disabled = true;
            submitBtn.innerHTML = '<span class="spinner-border spinner-border-sm me-2" role="status" aria-hidden="true"></span>Inscription...';
        }
    });

    function showFormError(message) {
        const existingAlert = form.querySelector('.alert-danger:not([role="alert"])');
        if (existingAlert) existingAlert.remove();

        const errorAlert = document.createElement('div');
        errorAlert.className = 'alert alert-danger mt-3';
        errorAlert.innerHTML = `<i class="bi bi-exclamation-triangle-fill me-2"></i>${message}`;

        submitBtn.parentNode.insertBefore(errorAlert, submitBtn);

        setTimeout(() => {
            if (errorAlert.parentNode) errorAlert.remove();
        }, 5000);
    }

    [username, email, password, confirmPwd].forEach(input => {
        input.addEventListener('input', () => {
            const errorAlert = form.querySelector('.alert-danger:not([role="alert"])');
            if (errorAlert) errorAlert.remove();
        });
    });

    updateTosState();
    updatePasswordStrength(0);
});