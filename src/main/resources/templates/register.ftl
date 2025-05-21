<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>DonnéesCST - Inscription</title>
    <link nonce="${nonce()}" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
    <link nonce="${nonce()}" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css" rel="stylesheet">
    <link nonce="${nonce()}" href="/style/home.css" rel="stylesheet">
</head>
<body class="d-flex flex-column min-vh-100">
    <main class="container flex-grow-1 d-flex align-items-center py-5">
        <div class="w-100 card-wrapper">
            <div class="card shadow-sm">
                <div class="card-body p-4">
                    <h2 class="h4 fw-bold text-center mb-4">Inscription</h2>
                    <#if errors?? && errors?size gt 0>
                        <div class="alert alert-danger alert-dismissible fade show" role="alert">
                            <#list errors as error>
                                <div>${error}</div>
                            </#list>
                            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                        </div>
                    </#if>
                    <form action="/inscription" method="post" id="registerForm" novalidate>
                        <div class="mb-3">
                            <label for="username" class="form-label">Nom d'utilisateur</label>
                            <input type="text" class="form-control" id="username" name="username" required>
                        </div>
                        <div class="mb-3">
                            <label for="password" class="form-label">Mot de passe</label>
                            <input type="password" class="form-control" id="password" name="password" required>
                            <small id="passwordFeedback" class="form-text text-muted"></small>
                        </div>
                        <div class="mb-3">
                            <label for="passwordConfirm" class="form-label">Confirmation du mot de passe</label>
                            <input type="password" class="form-control" id="passwordConfirm" name="passwordConfirm" required>
                            <small id="passwordMatchFeedback" class="form-text text-muted"></small>
                        </div>
                        <button type="submit" class="btn btn-primary w-100" disabled id="submitButton">S'inscrire</button>
                    </form>
                    <p class="text-center mt-3 mb-0">
                        Déjà un compte? <a href="/connexion" class="text-primary">Connectez-vous</a>
                    </p>
                </div>
            </div>
        </div>
    </main>
    <script nonce="${nonce()}">
        const passwordInput = document.getElementById('password');
        const passwordConfirmInput = document.getElementById('passwordConfirm');
        const passwordFeedback = document.getElementById('passwordFeedback');
        const passwordMatchFeedback = document.getElementById('passwordMatchFeedback');
        const submitButton = document.getElementById('submitButton');

        function validatePassword() {
            const password = passwordInput.value;
            const hasMinLength = password.length >= 8;
            const hasUpperCase = /[A-Z]/.test(password);
            const hasLowerCase = /[a-z]/.test(password);
            const hasNumber = /[0-9]/.test(password);
            const hasSpecialChar = /[!@#$%^&*]/.test(password);

            if (!hasMinLength) {
                passwordFeedback.textContent = 'Minimum 8 caractères requis.';
                passwordFeedback.className = 'form-text text-danger';
                return false;
            }
            if (!hasUpperCase) {
                passwordFeedback.textContent = 'Au moins une majuscule requise.';
                passwordFeedback.className = 'form-text text-danger';
                return false;
            }
            if (!hasLowerCase) {
                passwordFeedback.textContent = 'Au moins une minuscule requise.';
                passwordFeedback.className = 'form-text text-danger';
                return false;
            }
            if (!hasNumber) {
                passwordFeedback.textContent = 'Au moins un chiffre requis.';
                passwordFeedback.className = 'form-text text-danger';
                return false;
            }
            if (!hasSpecialChar) {
                passwordFeedback.textContent = 'Au moins un caractère spécial (!@#$%^&*) requis.';
                passwordFeedback.className = 'form-text text-danger';
                return false;
            }

            passwordFeedback.textContent = 'Mot de passe valide.';
            passwordFeedback.className = 'form-text text-success';
            return true;
        }

        function validatePasswordMatch() {
            const password = passwordInput.value;
            const passwordConfirm = passwordConfirmInput.value;

            if (password !== passwordConfirm) {
                passwordMatchFeedback.textContent = 'Les mots de passe ne correspondent pas.';
                passwordMatchFeedback.className = 'form-text text-danger';
                return false;
            }

            passwordMatchFeedback.textContent = 'Les mots de passe correspondent.';
            passwordMatchFeedback.className = 'form-text text-success';
            return true;
        }

        function updateSubmitButton() {
            submitButton.disabled = !(validatePassword() && validatePasswordMatch());
        }

        passwordInput.addEventListener('input', () => {
            validatePassword();
            validatePasswordMatch();
            updateSubmitButton();
        });

        passwordConfirmInput.addEventListener('input', () => {
            validatePasswordMatch();
            updateSubmitButton();
        });
    </script>
    <script nonce="${nonce()}" src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
</body>
</html>