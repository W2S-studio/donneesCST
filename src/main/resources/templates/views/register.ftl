<!DOCTYPE html>
<html lang="fr">
<head>
  <#assign pageTitle = "Inscription" />
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
              <h2 class="text-center fw-bold mb-4">Inscription à DonnéesCST</h2>
              <p class="text-center text-muted mb-4">
                Créez votre compte étudiant pour accéder à l'API
              </p>

              <#if errors?? && errors.general??>
                <div class="alert alert-danger" role="alert">
                  ${errors.general[0]}
                </div>
              </#if>

              <form id="registerForm" method="POST">
                <!-- Username -->
                <div class="mb-3 has-validation">
                  <label for="username" class="form-label">Nom d'utilisateur</label>
                  <input
                    type="text"
                    class="form-control <#if errors?? && errors.username??>is-invalid</#if>"
                    id="username"
                    name="username"
                    placeholder="Votre nom d'utilisateur"
                    value="${(formData?? && formData.username??)?then(formData.username, '')}"
                    required
                    data-bs-toggle="tooltip"
                    data-bs-placement="right"
                    data-bs-trigger="focus"
                    title="Doit contenir entre 3 et 20 caractères"
                  >
                  <#if errors?? && errors.username??>
                    <div class="invalid-feedback">
                      ${errors.username[0]}
                    </div>
                  </#if>
                </div>

                <!-- Email -->
                <div class="mb-3 has-validation">
                  <label for="email" class="form-label">Adresse email</label>
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
                    title="Entrez une adresse email valide"
                  >
                  <#if errors?? && errors.email??>
                    <div class="invalid-feedback">
                      ${errors.email[0]}
                    </div>
                  </#if>
                </div>

                <!-- Password -->
                <div class="mb-3 has-validation">
                  <label for="password" class="form-label">Mot de passe</label>
                  <input
                    type="password"
                    class="form-control <#if errors?? && errors.password??>is-invalid</#if>"
                    id="password"
                    name="password"
                    required
                    data-bs-toggle="tooltip"
                    data-bs-placement="right"
                    data-bs-trigger="focus"
                    title="Doit contenir au moins 8 caractères, une majuscule, une minuscule, un chiffre et un caractère spécial"
                  >
                  <#if errors?? && errors.password??>
                    <div class="invalid-feedback">
                      ${errors.password[0]}
                    </div>
                  </#if>
                  <div class="password-strength mt-2">
                    <div class="strength-bar" id="strengthBar1"></div>
                    <div class="strength-bar" id="strengthBar2"></div>
                    <div class="strength-bar" id="strengthBar3"></div>
                    <div class="strength-bar" id="strengthBar4"></div>
                  </div>
                  <div class="text-muted small mt-1" id="strengthText"></div>
                </div>

                <!-- Confirm Password -->
                <div class="mb-3 has-validation">
                  <label for="password_confirm" class="form-label">Confirmer le mot de passe</label>
                  <input
                    type="password"
                    class="form-control <#if errors?? && errors.password_confirm??>is-invalid</#if>"
                    id="password_confirm"
                    name="password_confirm"
                    required
                    data-bs-toggle="tooltip"
                    data-bs-placement="right"
                    data-bs-trigger="focus"
                    title="Doit correspondre au mot de passe saisi ci-dessus"
                  >
                  <#if errors?? && errors.password_confirm??>
                    <div class="invalid-feedback">
                      ${errors.password_confirm[0]}
                    </div>
                  </#if>
                </div>

                <!-- Terms of Service -->
                <div class="mb-3 form-check has-validation">
                  <input
                    type="checkbox"
                    class="form-check-input <#if errors?? && errors.has_accepted_tos??>is-invalid</#if>"
                    id="has_accepted_tos"
                    name="has_accepted_tos"
                    disabled
                    required
                  >
                  <label for="has_accepted_tos" class="form-check-label">
                    J'accepte les
                    <a href="/terms" class="text-decoration-none" target="_self">
                      conditions d'utilisation
                    </a>
                  </label>
                  <#if errors?? && errors.has_accepted_tos??>
                    <div class="invalid-feedback">
                      ${errors.has_accepted_tos[0]}
                    </div>
                  </#if>
                </div>

                <button type="submit" class="btn btn-primary btn-lg w-100" id="registerSubmitBtn">
                  S'inscrire
                </button>
                  <script nonce="${nonce()}" >
                      document.getElementById('registerSubmitBtn').addEventListener('submit', function(e) {
                          const submitBtn = document.getElementById('verificationSubmitBtn');
                          submitBtn.disabled = true;
                          submitBtn.innerHTML = '<span class="spinner-border spinner-border-sm me-2" role="status" aria-hidden="true"></span>Envoi en cours...';
                      });
                  </script>
              </form>

              <div class="text-center mt-4">
                <p class="text-muted">
                  Déjà un compte ?
                  <a href="/login" class="text-decoration-none auth-link">
                    Connectez-vous
                  </a>
                </p>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>

  <!-- Validation Modal -->
  <div
    class="modal fade"
    id="validationModal"
    tabindex="-1"
    aria-labelledby="validationModalLabel"
    aria-hidden="true"
  >
    <div class="modal-dialog modal-dialog-centered">
      <div class="modal-content">
        <div class="modal-header">
          <h5 class="modal-title" id="validationModalLabel">Erreur de validation</h5>
          <button
            type="button"
            class="btn-close"
            data-bs-dismiss="modal"
            aria-label="Fermer"
          ></button>
        </div>
        <div class="modal-body">
          Vous devez lire et accepter nos conditions d'utilisation avant de vous inscrire.
        </div>
        <div class="modal-footer">
          <button
            type="button"
            class="btn btn-secondary"
            data-bs-dismiss="modal"
          >
            Fermer
          </button>
          <a href="/terms" class="btn btn-primary">Voir les conditions</a>
        </div>
      </div>
    </div>
  </div>

  <script
    nonce="${nonce()}"
    src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"
    integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz"
    crossorigin="anonymous"
  ></script>
  <script nonce="${nonce()}" src="/js/views/register.js"></script>
</body>
</html>
