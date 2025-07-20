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
            trigger: 'focus',
            placement: 'right'
        })
    );

    const validationModal = new bootstrap.Modal(
        document.getElementById('validationModal')
    );

    const hasAcceptedTos = () => localStorage.getItem('termsAccepted') === 'true';

    function updateCheckbox() {
        tos.disabled = !hasAcceptedTos();
    }
    updateCheckbox();

    function updateSubmitState() {
        submitBtn.disabled = !(hasAcceptedTos() && tos.checked);
    }
    updateSubmitState();

    tos.addEventListener('change', () => {
        if (tos.checked) {
            localStorage.setItem('termsAccepted', 'true');
        }
        updateSubmitState();
    });

    function updatePasswordStrength(pwd) {
        const req = /^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[!@#$%^&*(),.?":{}|<>]).{8,}$/;
        let strength = 0;
        if (!req.test(pwd)) strength = 0;
        else if (pwd.length < 10) strength = 1;
        else if (pwd.length < 12) strength = 2;
        else if (pwd.length < 15) strength = 3;
        else strength = 4;

        bars.forEach((bar, i) => {
            bar.classList.remove('bg-danger', 'bg-warning', 'bg-success');
            if (i < strength) {
                bar.classList.add(
                    strength <= 1 ? 'bg-danger' :
                        strength <= 3 ? 'bg-warning' : 'bg-success'
                );
            }
        });

        strengthText.textContent =
            strength === 0 ? 'Minimum requis' :
                strength === 1 ? 'Moyen' :
                    strength === 2 ? 'Bon' :
                        strength === 3 ? 'Fort' : 'Très fort';

        const tip = tooltips.find(t => t._element === password);
        if (tip) {
            tip.setContent({
                '.tooltip-inner': pwd.length === 0
                    ? 'Doit contenir 8+ caractères, une maj, une min, un chiffre & un spécial.'
                    : !req.test(pwd)
                        ? 'Le mot de passe ne respecte pas les exigences minimales.'
                        : 'Mot de passe valide ! Pour plus de sécurité, allongez-le.'
            });
        }
    }

    username.addEventListener('input', () => {
        const ok = username.value.length >= 3 && username.value.length <= 20;
        username.classList.toggle('is-valid', ok);
        username.classList.toggle('is-invalid', !ok);
    });

    email.addEventListener('input', () => {
        const ok = /^[^\s@]+@[^\s@]+\.[^\s@]+$/.test(email.value);
        email.classList.toggle('is-valid', ok);
        email.classList.toggle('is-invalid', !ok);
    });

    password.addEventListener('input', () => {
        updatePasswordStrength(password.value);
        const ok = /^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[!@#$%^&*(),.?":{}|<>]).{8,}$/.test(password.value);
        password.classList.toggle('is-valid', ok);
        password.classList.toggle('is-invalid', !ok);
        if (confirmPwd.value) confirmPwd.dispatchEvent(new Event('input'));
    });

    confirmPwd.addEventListener('input', () => {
        const ok = confirmPwd.value === password.value && password.value !== '';
        confirmPwd.classList.toggle('is-valid', ok);
        confirmPwd.classList.toggle('is-invalid', !ok);
    });

    form.addEventListener('submit', e => {
        if (!hasAcceptedTos() || !tos.checked) {
            e.preventDefault();
            validationModal.show();
            return;
        }
    });
});
