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
    <#assign currentPage = "dashboard">
    <#include "components/header.ftl">

    <main class="container flex-grow-1 py-5">
        <#if errors?? && errors?size gt 0>
            <div class="alert alert-danger alert-dismissible fade show" role="alert">
                <#list errors as error>
                    <div>${error}</div>
                </#list>
                <button 
                    type="button" 
                    class="btn-close" 
                    data-bs-dismiss="alert" 
                    aria-label="Close">
                </button>
            </div>
        </#if>

        <section class="mb-5">
            <div class="d-flex justify-content-between align-items-center mb-4">
                <h2 class="h3 fw-bold mb-0">Gérer vos clés API</h2>
                <#if showKeys>
                    <form action="/dashboard/hide-keys" method="post" class="d-inline">
                        <button type="submit" class="btn btn-outline-secondary btn-sm">
                            <i class="bi bi-eye-slash"></i> Masquer les clés
                        </button>
                    </form>
                </#if>
            </div>

            <#if showKeys>
                <div class="card shadow-sm mb-4">
                    <div class="card-body">
                        <form action="/dashboard" method="post" class="row g-3 align-items-end">
                            <input type="hidden" name="action" value="createKey">
                            <div class="col-md-6">
                                <label for="key_expiration" class="form-label">Date d'expiration (optionnel)</label>
                                <input type="date"
                                       class="form-control"
                                       id="key_expiration"
                                       name="key_expiration"
                                       value="${(form.field('key_expiration').get())!''}">
                                <small class="form-text text-muted">
                                    Si aucune date d'expiration n'est choisie, la clé sera valide pour toujours.
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
                                    <th>Date d'expiration</th>
                                    <th>Action</th>
                                </tr>
                            </thead>
                            <tbody>
                                <#list apiKeys as key>
                                    <tr>
                                        <td>
                                            <code class="text-break">${key.key}</code>
                                            <button type="button" class="btn btn-sm btn-outline-secondary ms-2 copy-key-btn" data-key="${key.key}">
                                                <i class="bi bi-clipboard"></i>
                                            </button>
                                        </td>
                                        <td>
                                            <span data-date="${key.created}" class="format-date">${key.created}</span>
                                        </td>
                                        <td>
                                            <#if key.expire??>
                                                <span data-date="${key.expire}" class="format-date">${key.expire}</span>
                                            <#else>
                                                <span class="text-muted">Jamais</span>
                                            </#if>
                                        </td>
                                        <td>
                                            <form action="/dashboard" method="post" class="d-inline delete-key-form">
                                                <input type="hidden" name="action" value="deleteKey">
                                                <input type="hidden" name="keyId" value="${key.id}">
                                                <button type="submit" class="btn btn-danger btn-sm">
                                                    <i class="bi bi-trash"></i> Supprimer
                                                </button>
                                            </form>
                                        </td>
                                    </tr>
                                </#list>
                            </tbody>
                        </table>
                    </div>
                <#else>
                    <div class="alert alert-info">
                        <i class="bi bi-info-circle"></i> Aucune clé API pour le moment.
                    </div>
                </#if>

            <#else>
                <div class="card shadow-sm">
                    <div class="card-body">
                        <form action="/dashboard/reveal-keys" method="post" class="row g-3 align-items-end">
                            <div class="col-md-8">
                                <label for="confirmPassword" class="form-label">
                                    <i class="bi bi-shield-lock"></i> Entrez votre mot de passe pour voir vos clés API
                                </label>
                                <input type="password"
                                       class="form-control"
                                       id="confirmPassword"
                                       name="confirmPassword"
                                       required>
                            </div>
                            <div class="col-md-4">
                                <button type="submit" class="btn btn-primary w-100">
                                    <i class="bi bi-eye"></i> Afficher les clés
                                </button>
                            </div>
                        </form>
                    </div>
                </div>
                <#if errorKeyAuth??>
                    <div class="alert alert-danger mt-3">
                        <i class="bi bi-exclamation-triangle"></i> ${errorKeyAuth}
                    </div>
                </#if>
            </#if>
        </section>

        <!-- Password Update Section -->
        <section>
            <h2 class="h3 fw-bold mb-4">Modifier le mot de passe</h2>
            <div class="card shadow-sm">
                <div class="card-body">
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
                        <button type="submit" class="btn btn-primary" disabled id="submitButton">
                            <i class="bi bi-shield-check"></i> Modifier le mot de passe
                        </button>
                    </form>
                </div>
            </div>
        </section>
    </main>

    <#include "components/footer.ftl">

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

        function formatDate(dateString) {
            try {
                const date = new Date(dateString);
                return date.toLocaleString('fr-CA', {
                    timeZone: 'America/Montreal',
                    year: 'numeric',
                    month: '2-digit',
                    day: '2-digit',
                    hour: '2-digit',
                    minute: '2-digit',
                    second: '2-digit'
                });
            } catch (e) {
                return dateString;
            }
        }

        document.addEventListener('DOMContentLoaded', function() {
            const dateElements = document.querySelectorAll('.format-date');
            dateElements.forEach(element => {
                const originalDate = element.getAttribute('data-date');
                if (originalDate) {
                    element.textContent = formatDate(originalDate);
                }
            });

            const copyButtons = document.querySelectorAll('.copy-key-btn');
            copyButtons.forEach(button => {
                button.addEventListener('click', function() {
                    const keyValue = this.getAttribute('data-key');
                    copyToClipboard(keyValue, this);
                });
            });

            const deleteForms = document.querySelectorAll('.delete-key-form');
            deleteForms.forEach(form => {
                form.addEventListener('submit', function(e) {
                    if (!confirm('Êtes-vous sûr de vouloir supprimer cette clé API ?')) {
                        e.preventDefault();
                    }
                });
            });
        });

        function copyToClipboard(text, buttonElement) {
            navigator.clipboard.writeText(text).then(function() {
                const originalContent = buttonElement.innerHTML;
                buttonElement.innerHTML = '<i class="bi bi-check"></i>';
                buttonElement.classList.remove('btn-outline-secondary');
                buttonElement.classList.add('btn-success');
                
                setTimeout(() => {
                    buttonElement.innerHTML = originalContent;
                    buttonElement.classList.remove('btn-success');
                    buttonElement.classList.add('btn-outline-secondary');
                }, 2000);
            }).catch(function(err) {
                console.error('Erreur lors de la copie: ', err);
                alert('Impossible de copier la clé. Veuillez la sélectionner manuellement.');
            });
        }
    </script>
    <script nonce="${nonce()}" src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
</body>
</html>