<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>DonnéesCST - Tableau de bord</title>
    <link nonce="${nonce()}" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
    <link nonce="${nonce()}" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css" rel="stylesheet">
    <link nonce="${nonce()}" href="/style/home.css" rel="stylesheet">
</head>
<body class="d-flex flex-column min-vh-100">
    <header class="text-white">
        <div class="container d-flex justify-content-between align-items-center">
            <h1 class="fs-3 fw-bold">DonnéesCST</h1>
            <nav>
                <span class="navbar-text text-white me-3">Bienvenue, ${username}</span>
                <a href="/dashboard" class="btn btn-outline-light mx-2 active">Tableau de bord</a>
                <form action="/dashboard" method="post" class="d-inline">
                    <input type="hidden" name="action" value="logout">
                    <button type="submit" class="btn btn-outline-light mx-2">Déconnexion</button>
                </form>
            </nav>
        </div>
    </header>
    <main class="container flex-grow-1 py-5">
        <#if errors?? && errors?size gt 0>
            <div class="alert alert-danger alert-dismissible fade show" role="alert">
                <#list errors as error>
                    <div>${error}</div>
                </#list>
                <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
            </div>
        </#if>
        <!-- API Keys Section -->
        <section class="mb-5">
            <h2 class="h3 fw-bold mb-4">Gérer vos clés API</h2>

            <#if showKeys>
                <div class="card shadow-sm mb-4">
                    <div class="card-body">
                        <form action="/dashboard" method="post" class="row g-3 align-items-end">
                            <input type="hidden" name="action" value="createKey">
                            <div class="col-md-6">
                                <label for="key_expiration" class="form-label">Date d’expiration (optionnel)</label>
                                <input type="date"
                                       class="form-control"
                                       id="key_expiration"
                                       name="key_expiration"
                                       value="${(form.field('key_expiration').get())!''}">
                                <small class="form-text text-muted">
                                    Si aucune date d’expiration n’est choisie, la clé sera valide pour toujours.
                                    <span class="text-danger">
                                        Attention : une clé permanente ne peut être désactivée que par suppression.
                                    </span>
                                </small>
                            </div>
                            <div class="col-md-6">
                                <button type="submit" class="btn btn-primary w-100">
                                    Créer une nouvelle clé API
                                </button>
                            </div>
                        </form>
                    </div>
                </div>

                <#if apiKeys?size gt 0>
                    <div class="table-responsive">
                        <table class="table table-bordered table-hover">
                            <thead class="table-light">
                                <tr>
                                    <th>Clé</th>
                                    <th>Date de création</th>
                                    <th>Date d’expiration</th>
                                    <th>Action</th>
                                </tr>
                            </thead>
                            <tbody>
                                <#list apiKeys as key>
                                    <tr>
                                        <td>${key.key}</td>
                                        <td>${key.created}</td>
                                        <td>
                                            <#if key.expire??>
                                                ${key.expire}
                                            <#else>
                                                Jamais
                                            </#if>
                                        </td>
                                        <td>
                                            <form action="/dashboard" method="post" class="d-inline">
                                                <input type="hidden" name="action" value="deleteKey">
                                                <input type="hidden" name="keyId" value="${key.id}">
                                                <button type="submit" class="btn btn-danger btn-sm">
                                                    Supprimer
                                                </button>
                                            </form>
                                        </td>
                                    </tr>
                                </#list>
                            </tbody>
                        </table>
                    </div>
                <#else>
                    <p class="text-muted">Aucune clé API pour le moment.</p>
                </#if>

            <#else>
                <form action="/dashboard/reveal-keys" method="post" class="row g-3 align-items-end">
                    <div class="col-md-8">
                        <label for="confirmPassword" class="form-label">
                            Entrez votre mot de passe pour voir vos clés API
                        </label>
                        <input type="password"
                               class="form-control"
                               id="confirmPassword"
                               name="confirmPassword"
                               required>
                    </div>
                    <div class="col-md-4">
                        <button type="submit" class="btn btn-primary w-100">
                            Afficher les clés
                        </button>
                    </div>
                </form>
                <#if errorKeyAuth??>
                    <div class="alert alert-danger mt-3">${errorKeyAuth}</div>
                </#if>
            </#if>
        </section>
        <!-- Password Update Section -->
        <section>
            <h2 class="h3 fw-bold mb-4">Modifier le mot de passe</h2>
            <form action="/dashboard" method="post" id="passwordForm" novalidate>
                <input type="hidden" name="action" value="updatePassword">
                <div class="mb-3">
                    <label for="oldPassword" class="form-label">Ancien mot de passe</label>
                    <input type="password" class="form-control" id="oldPassword" name="oldPassword" required>
                </div>
                <div class="mb-3">
                    <label for="newPassword" class="form-label">Nouveau mot de passe</label>
                    <input type="password" class="form-control" id="newPassword" name="newPassword" required>
                    <small id="passwordFeedback" class="form-text text-muted"></small>
                </div>
                <div class="mb-3">
                    <label for="newPasswordConfirm" class="form-label">Confirmer le nouveau mot de passe</label>
                    <input type="password" class="form-control" id="newPasswordConfirm" name="newPasswordConfirm" required>
                    <small id="passwordMatchFeedback" class="form-text text-muted"></small>
                </div>
                <button type="submit" class="btn btn-primary" disabled id="submitButton">Modifier le mot de passe</button>
            </form>
        </section>
    </main>
    <footer class="bg-dark text-white">
        <div class="container">
            <div class="row gy-4">
                <div class="col-12 col-md-4 text-center text-md-start">
                    <h5 class="fw-bold mb-3">DonnéesCST</h5>
                    <p class="text-muted">Un projet gratuit pour les étudiants du Cégep de Sorel-Tracy, créé avec passion.</p>
                </div>
                <div class="col-12 col-md-4 text-center">
                    <h5 class="fw-bold mb-3">Liens rapides</h5>
                    <ul class="list-unstyled">
                        <li><a href="/connexion" class="text-white text-decoration-none">Connexion</a></li>
                        <li><a href="/inscription" class="text-white text-decoration-none">Inscription</a></li>
                        <li><a href="/documentation" class="text-white text-decoration-none">Documentation</a></li>
                    </ul>
                </div>
                <div class="col-12 col-md-4 text-center text-md-end">
                    <h5 class="fw-bold mb-3">Restez connecté</h5>
                    <div class="social-icons mb-3">
                        <a href="#" class="text-white"><i class="bi bi-github"></i></a>
                        <a href="#" class="text-white"><i class="bi bi-linkedin"></i></a>
                        <a href="mailto:contact@donneescst.quebec" class="text-white"><i class="bi bi-envelope-fill"></i></a>
                    </div>
                    <form class="d-flex justify-content-center justify-content-md-end">
                        <input type="email" class="form-control w-auto me-2" placeholder="Votre courriel" disabled>
                        <button type="submit" class="btn btn-primary" disabled>S'abonner</button>
                    </form>
                    <small class="text-muted d-block mt-2">(Bientôt disponible!)</small>
                </div>
            </div>
            <hr class="bg-white my-4">
            <p class="text-center mb-0">© 2025 DonnéesCST. Tous droits réservés.</p>
        </div>
    </footer>
    <script nonce="${nonce()}">
        const passwordInput = document.getElementById('newPassword');
        const passwordConfirmInput = document.getElementById('newPasswordConfirm');
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