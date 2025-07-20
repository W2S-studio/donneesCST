document.addEventListener("DOMContentLoaded", () => {
    const form = document.getElementById("requestResetForm");
    const email = form.querySelector("#email");
    const submit = form.querySelector('button[type="submit"]');

    email.addEventListener("input", () => {
        if (email.checkValidity()) {
            email.classList.remove("is-invalid");
            submit.disabled = false;
        } else {
            email.classList.add("is-invalid");
            submit.disabled = true;
        }
    });
});
