document.addEventListener("DOMContentLoaded", () => {
    const form = document.getElementById("resetPasswordForm");
    const pwd = form.querySelector("#password");
    const cpwd = form.querySelector("#confirm_password");
    const submit = form.querySelector('button[type="submit"]');

    function validate() {
        let valid = true;

        if (pwd.value.length < 8) {
            pwd.classList.add("is-invalid");
            valid = false;
        } else {
            pwd.classList.remove("is-invalid");
        }

        if (pwd.value !== cpwd.value || cpwd.value === "") {
            cpwd.classList.add("is-invalid");
            valid = false;
        } else {
            cpwd.classList.remove("is-invalid");
        }

        submit.disabled = !valid;
    }

    pwd.addEventListener("input", validate);
    cpwd.addEventListener("input", validate);
});
