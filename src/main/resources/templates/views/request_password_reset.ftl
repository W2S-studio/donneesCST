<!DOCTYPE html>
<html lang="fr">
<head>
    <#assign pageTitle = "Mot de passe oublié" />
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
                            <h2 class="text-center fw-bold mb-4">Mot de passe oublié</h2>
                            <p class="text-center text-muted mb-4">
                                Entrez votre email pour recevoir un lien de réinitialisation.
                            </p>

                            <form id="requestResetForm"
                                  method="POST"
                                  novalidate>
                                <div class="mb-3 has-validation">
                                    <label for="email" class="form-label">Adresse email</label>
                                    <div class="input-group has-validation">
                                        <span class="input-group-text">
                                            <i class="bi bi-envelope"></i>
                                        </span>
                                        <input
                                            type="email"
                                            class="form-control <#if errors?? && errors.email??>is-invalid</#if>"
                                            id="email"
                                            name="email"
                                            placeholder="votre.email@exemple.com"
                                            value="${(formData?? && formData.email??)?then(formData.email, '')}"
                                            required
                                            data-bs-toggle="tooltip"
                                            data-bs-placement="right"
                                            title="Entrez votre adresse email"
                                        >
                                        <#if errors?? && errors.email??>
                                            <div class="invalid-feedback">
                                                ${errors.email[0]}
                                            </div>
                                        </#if>
                                    </div>
                                </div>

                                <button
                                    type="submit"
                                    class="btn btn-primary btn-lg w-100"
                                    id="resetSubmitBtn"
                                >
                                    Envoyer le lien
                                </button>
                                <script nonce="${nonce()}" >
                                    document.getElementById('requestResetForm').addEventListener('submit', function(e) {
                                        const submitBtn = document.getElementById('resetSubmitBtn');
                                        submitBtn.disabled = true;
                                        submitBtn.innerHTML = '<span class="spinner-border spinner-border-sm me-2" role="status" aria-hidden="true"></span>Envoi en cours...';
                                    });
                                </script>
                            </form>

                            <div class="text-center mt-4">
                                <p class="text-muted mb-2">
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
    <script nonce="${nonce()}" src="/js/views/request_password_reset.js"></script>
</body>
</html>