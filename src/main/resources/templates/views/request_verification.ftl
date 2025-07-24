<!DOCTYPE html>
<html lang="fr">
<head>
    <#assign pageTitle = "Demander un nouveau lien de vérification" />
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
                            <h2 class="text-center fw-bold mb-4">Nouveau lien de vérification</h2>
                            <p class="text-center text-muted mb-4">
                                <#if email??>
                                    Un nouveau lien de vérification sera envoyé à votre adresse email.
                                <#else>
                                    Entrez votre adresse email pour recevoir un nouveau lien de vérification.
                                </#if>
                            </p>
                            
                            <#if errors?? && errors.general??>
                                <div class="alert alert-danger" role="alert">
                                    ${errors.general[0]}
                                </div>
                            </#if>

                            <form id="requestVerificationForm" method="POST">
                                <#if !email??>
                                    <div class="mb-3">
                                        <label for="email" class="form-label">Adresse email</label>
                                        <div class="input-group has-validation">
                                            <span class="input-group-text"><i class="bi bi-envelope"></i></span>
                                            <input
                                                type="email"
                                                class="form-control <#if errors?? && errors.email??>is-invalid</#if>"
                                                id="email"
                                                name="email"
                                                placeholder="votre.email@cegep-st.qc.ca"
                                                value="${(formData?? && formData.email??)?then(formData.email, '')}"
                                                required
                                                data-bs-toggle="tooltip"
                                                data-bs-placement="right"
                                                data-bs-trigger="focus"
                                                title="Entrez une adresse email valide (ex. utilisateur@cegep-st.qc.ca)"
                                            >
                                            <#if errors?? && errors.email??>
                                                <div class="invalid-feedback">
                                                    ${errors.email[0]}
                                                </div>
                                            </#if>
                                        </div>
                                    </div>
                                <#else>
                                    <div class="mb-3">
                                        <div class="alert alert-info" role="alert">
                                            <i class="bi bi-info-circle me-2"></i>
                                            Le lien sera envoyé à votre adresse email associée à votre compte.
                                        </div>
                                    </div>
                                </#if>
                                
                                <button type="submit" class="btn btn-primary btn-lg w-100" id="verificationSubmitBtn">
                                    <#if email??>
                                        Renvoyer le lien de vérification
                                    <#else>
                                        Envoyer le lien
                                    </#if>
                                </button>
                                <script nonce="${nonce()}" >
                                    document.getElementById('requestVerificationForm').addEventListener('submit', function(e) {
                                        const submitBtn = document.getElementById('verificationSubmitBtn');
                                        submitBtn.disabled = true;
                                        submitBtn.innerHTML = '<span class="spinner-border spinner-border-sm me-2" role="status" aria-hidden="true"></span>Envoi en cours...';
                                    });
                                </script>
                            </form>
                            
                            <div class="text-center mt-4">
                                <p class="text-muted">
                                    Retour à la <a href="/login" class="text-decoration-none auth-link">connexion</a>
                                </p>
                                <#if !email??>
                                    <p class="text-muted">
                                        Pas encore de compte ? <a href="/register" class="text-decoration-none auth-link">Inscrivez-vous</a>
                                    </p>
                                </#if>
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
    <script nonce="${nonce()}" src="/js/views/requestVerificationValidation.js"></script>
</body>
</html>
