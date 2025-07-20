<!DOCTYPE html>
<html lang="fr">
<head>
    <#assign pageTitle = "Réinitialisation du mot de passe" />
    <#assign additionalCSS = ["/style/views/auth.css"] />
    <#include "../macros/head.ftl"/>
</head>
<body class="d-flex flex-column h-100">
    <#include "../components/flash.ftl">

    <div class="auth-section h-100 d-flex flex-column flex-grow-1 py-5">
        <div class="container d-flex flex-column justify-content-center flex-grow-1">
            <div class="row justify-content-center">
                <div class="col-lg-5 col-md-7">
                    <div class="card shadow-lg auth-card">
                        <div class="card-body p-4">
                            <h2 class="text-center fw-bold mb-4">Définir un nouveau mot de passe</h2>

                            <#-- Affiche toute erreur générale -->
                            <#if errors?? && errors.general??>
                                <div class="alert alert-danger" role="alert">
                                    ${errors.general[0]}
                                </div>
                            </#if>

                            <form id="resetPasswordForm"
                                  action="/auth/reset-password"
                                  method="POST"
                                  novalidate>
                                <input type="hidden" name="token" value="${token}" />

                                <div class="mb-3 has-validation">
                                    <label for="password" class="form-label">
                                        Nouveau mot de passe
                                    </label>
                                    <div class="input-group has-validation">
                                        <span class="input-group-text">
                                            <i class="bi bi-lock-fill"></i>
                                        </span>
                                        <input
                                            type="password"
                                            class="form-control <#if errors?? && errors.password??>is-invalid</#if>"
                                            id="password"
                                            name="password"
                                            placeholder="8 caractères min"
                                            required
                                            data-bs-toggle="tooltip"
                                            data-bs-placement="right"
                                            title="Entrez votre nouveau mot de passe"
                                        >
                                        <#if errors?? && errors.password??>
                                            <div class="invalid-feedback">
                                                ${errors.password[0]}
                                            </div>
                                        </#if>
                                    </div>
                                </div>

                                <div class="mb-3 has-validation">
                                    <label for="confirm_password" class="form-label">
                                        Confirmation du mot de passe
                                    </label>
                                    <div class="input-group has-validation">
                                        <span class="input-group-text">
                                            <i class="bi bi-lock-fill"></i>
                                        </span>
                                        <input
                                            type="password"
                                            class="form-control <#if errors?? && errors.confirm_password??>is-invalid</#if>"
                                            id="confirm_password"
                                            name="confirm_password"
                                            placeholder="Confirmez le mot de passe"
                                            required
                                            data-bs-toggle="tooltip"
                                            data-bs-placement="right"
                                            title="Confirmez votre mot de passe"
                                        >
                                        <#if errors?? && errors.confirm_password??>
                                            <div class="invalid-feedback">
                                                ${errors.confirm_password[0]}
                                            </div>
                                        </#if>
                                    </div>
                                </div>

                                <button
                                    type="submit"
                                    class="btn btn-primary btn-lg w-100"
                                >
                                    Réinitialiser
                                </button>
                            </form>

                            <div class="text-center mt-4">
                                <p class="text-muted">
                                    <a href="/login" class="text-decoration-none auth-link">
                                        Retour à la connexion
                                    </a>
                                </p>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script nonce="${nonce()}"
            src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"
            integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz"
            crossorigin="anonymous">
    </script>
    <script nonce="${nonce()}" src="/js/views/reset_password.js"></script>
</body>
</html>