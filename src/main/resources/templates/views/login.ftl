<!DOCTYPE html>
<html lang="fr">
<head>
    <#assign pageTitle = "Connexion" />
    <#assign additionalCSS = ["/style/views/auth.css"] />
    <#include "../macros/head.ftl"/>
</head>
<body class="d-flex flex-column h-100">
    <#include "../components/flash.ftl"/>

    <div class="auth-section h-100 d-flex flex-column flex-grow-1 py-5">
        <div class="container d-flex flex-column justify-content-center flex-grow-1">
            <div class="row justify-content-center">
                <div class="col-lg-5 col-md-7">
                    <div class="card shadow-lg auth-card">
                        <div class="card-body p-4">
                            <h2 class="text-center fw-bold mb-4">Connexion à DonnéesCST</h2>
                            <p class="text-center text-muted mb-4">Connectez-vous à votre compte étudiant</p>

                            <#if errors?? && errors.general??>
                                <div class="alert alert-danger" role="alert">
                                    ${errors.general[0]}
                                </div>
                            </#if>

                            <form id="loginForm" action="/auth/login" method="POST">
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
                                            title="Entrez votre adresse email"
                                        >
                                        <#if errors?? && errors.email??>
                                            <div class="invalid-feedback">
                                                ${errors.email[0]}
                                            </div>
                                        </#if>
                                    </div>
                                </div>

                                <div class="mb-3">
                                    <label for="password" class="form-label">Mot de passe</label>
                                    <div class="input-group has-validation">
                                        <span class="input-group-text"><i class="bi bi-lock"></i></span>
                                        <input
                                            type="password"
                                            class="form-control <#if errors?? && errors.password??>is-invalid</#if>"
                                            id="password"
                                            name="password"
                                            placeholder="Votre mot de passe"
                                            required
                                            data-bs-toggle="tooltip"
                                            data-bs-placement="right"
                                            data-bs-trigger="focus"
                                            title="Entrez votre mot de passe"
                                        >
                                        <#if errors?? && errors.password??>
                                            <div class="invalid-feedback">
                                                ${errors.password[0]}
                                            </div>
                                        </#if>
                                    </div>
                                </div>

                                <button type="submit" class="btn btn-primary btn-lg w-100">Se connecter</button>

                                <div class="text-center mt-3">
                                    <a href="/request-reset" class="btn btn-link p-0">
                                        Mot de passe oublié ?
                                    </a>
                                </div>
                            </form>

                            <div class="d-flex justify-content-center gap-2 mt-4">
                                <a href="/request-verification" class="btn btn-outline-success">
                                    Vérifier son Email
                                </a>
                                <a href="/register" class="btn btn-outline-secondary">
                                    Inscription
                                </a>
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
    <script nonce="${nonce()}" src="/js/views/login.js"></script>
</body>
</html>
