<!DOCTYPE html>
<html lang="fr">
<head>
  <#assign pageTitle = "Support" />
  <#assign additionalCSS = ["style/views/support.css"] />
  <#include "/macros/head.ftl"/>
</head>
<body>
  <#assign errors   = errors!{} >
  <#assign formData = formData!{} >
  <#assign currentPage = "support" />

  <#include "/components/navbar.ftl">
  <#include "/components/flash.ftl"/>

  <!-- Hero Section -->
    <div class="hero-section support-hero text-white">
        <div class="container">
            <div class="row">
                <div class="col-lg-8 mx-auto text-center">
                    <i class="bi bi-headset display-1 mb-4"></i>
                    <h1 class="display-4 fw-bold mb-4">Centre d'aide</h1>
                    <p class="lead mb-4">Trouvez rapidement les réponses à vos questions ou contactez notre équipe de support</p>
                    <div class="row justify-content-center">
                        <div class="col-md-8">
                            <input
                                type="text"
                                id="globalSearch"
                                class="form-control faq-search"
                                placeholder="🔍 Rechercher dans toutes les questions..."
                            >
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Main FAQ Content -->
    <div class="faq-content">
        <div class="container">
            <!-- Primary FAQs - Always Open -->
            <div class="primary-faqs">
                <div class="section-title">
                    <h2>Questions essentielles</h2>
                    <p>Les réponses aux questions les plus importantes pour bien commencer</p>
                </div>

                <div class="faq-grid" id="primaryFAQ">
                    <!-- FAQ Item 1 -->
                    <div class="faq-card-open" data-keywords="inscription compte créer register">
                        <div class="faq-question-open">
                            <div class="faq-question-icon">
                                <i class="bi bi-person-plus"></i>
                            </div>
                            <div>Comment m'inscrire ?</div>
                        </div>
                        <div class="faq-answer-open">
                            <strong>C'est simple !</strong> Rendez-vous sur notre page d'inscription, remplissez vos informations personnelles (nom, email du Cégep, mot de passe), puis validez votre compte via l'email de confirmation que vous recevrez. L'inscription est gratuite et ne prend que quelques minutes.
                        </div>
                    </div>

                    <!-- FAQ Item 2 -->
                    <div class="faq-card-open" data-keywords="mot passe oublié changer reset password">
                        <div class="faq-question-open">
                            <div class="faq-question-icon">
                                <i class="bi bi-key"></i>
                            </div>
                            <div>Comment changer mon mot de passe ?</div>
                        </div>
                        <div class="faq-answer-open">
                            Sur la page de connexion, cliquez sur <em>"Mot de passe oublié"</em>, entrez votre adresse email, puis suivez le lien sécurisé que vous recevrez pour définir un nouveau mot de passe. Le processus est sécurisé et rapide.
                        </div>
                    </div>

                    <!-- FAQ Item 3 -->
                    <div class="faq-card-open" data-keywords="api token clé authentification key">
                        <div class="faq-question-open">
                            <div class="faq-question-icon">
                                <i class="bi bi-shield-lock"></i>
                            </div>
                            <div>Comment obtenir ma clé API ?</div>
                        </div>
                        <div class="faq-answer-open">
                            Connectez-vous à votre compte, allez dans votre <strong>tableau de bord</strong>, puis dans la section "API". Cliquez sur "Générer une nouvelle clé" et copiez votre token d'authentification. Gardez cette clé secrète et sécurisée.
                        </div>
                    </div>

                    <!-- FAQ Item 4 -->
                    <div class="faq-card-open" data-keywords="données horaire cours professeur data">
                        <div class="faq-question-open">
                            <div class="faq-question-icon">
                                <i class="bi bi-database"></i>
                            </div>
                            <div>Quelles données puis-je récupérer ?</div>
                        </div>
                        <div class="faq-answer-open">
                            L'API DonnéesCST vous permet d'accéder aux horaires de cours, informations sur les professeurs, calendrier académique, événements du Cégep, et bien d'autres données utiles. Consultez notre <strong>documentation complète</strong> pour découvrir toutes les possibilités.
                        </div>
                    </div>

                    <!-- FAQ Item 5 -->
                    <div class="faq-card-open" data-keywords="erreur 401 403 autorisation error">
                        <div class="faq-question-open">
                            <div class="faq-question-icon">
                                <i class="bi bi-exclamation-triangle"></i>
                            </div>
                            <div>Pourquoi j'ai une erreur d'autorisation ?</div>
                        </div>
                        <div class="faq-answer-open">
                            Vérifiez que votre token API est valide et correctement inclus dans l'en-tête <code>Authorization: Bearer YOUR_TOKEN</code>. Assurez-vous aussi que votre clé n'a pas expiré. Si le problème persiste, générez un nouveau token depuis votre tableau de bord.
                        </div>
                    </div>

                    <!-- FAQ Item 6 -->
                    <div class="faq-card-open" data-keywords="limite requête rate limit quota">
                        <div class="faq-question-open">
                            <div class="faq-question-icon">
                                <i class="bi bi-speedometer2"></i>
                            </div>
                            <div>Y a-t-il des limites d'utilisation ?</div>
                        </div>
                        <div class="faq-answer-open">
                            Pour assurer un service optimal à tous les utilisateurs, nous appliquons une limite de <strong>1000 requêtes par heure</strong> par utilisateur. Cette limite est largement suffisante pour la plupart des projets étudiants et applications courantes.
                        </div>
                    </div>
                </div>
            </div>

            <div class="additional-questions">
                <div class="additional-title">
                    <h3><i class="bi bi-lightbulb me-2"></i>Autres questions fréquentes</h3>
                    <p>Explorez d'autres sujets qui pourraient vous intéresser</p>
                </div>

                <div class="accordion" id="additionalQuestionsAccordion">
                    <div class="accordion-item" data-keywords="sécurité données protection privacy">
                        <h2 class="accordion-header">
                            <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#collapse1" aria-expanded="false" aria-controls="collapse1">
                                <i class="bi bi-shield-check me-2"></i>
                                Mes données sont-elles sécurisées ?
                            </button>
                        </h2>
                        <div id="collapse1" class="accordion-collapse collapse" data-bs-parent="#additionalQuestionsAccordion">
                            <div class="accordion-body">
                                <strong>Absolument !</strong> Nous prenons la sécurité très au sérieux. Toutes vos données sont chiffrées en transit et au repos, nous utilisons des protocoles de sécurité modernes (HTTPS, OAuth 2.0), et nous ne partageons jamais vos informations personnelles avec des tiers. Nos serveurs sont hébergés dans des centres de données sécurisés et nous effectuons des audits de sécurité réguliers.
                            </div>
                        </div>
                    </div>

                    <div class="accordion-item" data-keywords="support technique aide help">
                        <h2 class="accordion-header">
                            <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#collapse2" aria-expanded="false" aria-controls="collapse2">
                                <i class="bi bi-headset me-2"></i>
                                Comment contacter le support technique ?
                            </button>
                        </h2>
                        <div id="collapse2" class="accordion-collapse collapse" data-bs-parent="#additionalQuestionsAccordion">
                            <div class="accordion-body">
                                Vous pouvez nous contacter via le <strong>formulaire de contact</strong> sur cette page, par email à <a href="mailto:support@donneescst.ca">support@donneescst.ca</a>, ou directement via notre <strong>Discord</strong> communautaire. Notre équipe d'étudiants répond généralement en moins de 24h pendant les jours ouvrables.
                            </div>
                        </div>
                    </div>

                    <div class="accordion-item" data-keywords="documentation guide tutorial">
                        <h2 class="accordion-header">
                            <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#collapse3" aria-expanded="false" aria-controls="collapse3">
                                <i class="bi bi-book me-2"></i>
                                Où trouver la documentation complète ?
                            </button>
                        </h2>
                        <div id="collapse3" class="accordion-collapse collapse" data-bs-parent="#additionalQuestionsAccordion">
                            <div class="accordion-body">
                                Notre <strong>documentation complète</strong> est disponible dans la section <a href="/docs">/docs</a> du site. Elle contient des guides détaillés, des exemples de code, les endpoints disponibles, et des tutoriels étape par étape. Nous mettons régulièrement à jour cette documentation avec de nouveaux exemples et cas d'usage.
                            </div>
                        </div>
                    </div>

                    <div class="accordion-item" data-keywords="mise jour update version">
                        <h2 class="accordion-header">
                            <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#collapse4" aria-expanded="false" aria-controls="collapse4">
                                <i class="bi bi-arrow-clockwise me-2"></i>
                                À quelle fréquence les données sont mises à jour ?
                            </button>
                        </h2>
                        <div id="collapse4" class="accordion-collapse collapse" data-bs-parent="#additionalQuestionsAccordion">
                            <div class="accordion-body">
                                Les données sont mises à jour <strong>plusieurs fois par jour</strong> selon leur type : les horaires de cours sont synchronisés toutes les 6 heures, les informations sur les professeurs quotidiennement, et le calendrier académique en temps réel lors de modifications. Vous pouvez vérifier la dernière mise à jour via l'endpoint <code>/api/status</code>.
                            </div>
                        </div>
                    </div>

                    <div class="accordion-item" data-keywords="mobile application app">
                        <h2 class="accordion-header">
                            <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#collapse5" aria-expanded="false" aria-controls="collapse5">
                                <i class="bi bi-phone me-2"></i>
                                Y a-t-il une application mobile ?
                            </button>
                        </h2>
                        <div id="collapse5" class="accordion-collapse collapse" data-bs-parent="#additionalQuestionsAccordion">
                            <div class="accordion-body">
                                Actuellement, nous n'avons pas d'application mobile dédiée, mais notre <strong>API REST</strong> peut être facilement intégrée dans n'importe quelle application mobile. Nous fournissons des exemples d'intégration pour React Native, Flutter, et les applications natives iOS/Android dans notre documentation.
                            </div>
                        </div>
                    </div>

                    <div class="accordion-item" data-keywords="intégration integration webhook">
                        <h2 class="accordion-header">
                            <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#collapse6" aria-expanded="false" aria-controls="collapse6">
                                <i class="bi bi-plug me-2"></i>
                                Comment intégrer l'API dans mon projet ?
                            </button>
                        </h2>
                        <div id="collapse6" class="accordion-collapse collapse" data-bs-parent="#additionalQuestionsAccordion">
                            <div class="accordion-body">
                                L'intégration est simple ! Générez votre <strong>clé API</strong>, consultez notre documentation avec des exemples en JavaScript, Python, PHP, et autres langages. Nous proposons également des <strong>SDKs</strong> pour les frameworks populaires et des webhooks pour recevoir les mises à jour en temps réel.
                            </div>
                        </div>
                    </div>

                    <div class="accordion-item" data-keywords="erreur 500 serveur server">
                        <h2 class="accordion-header">
                            <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#collapse7" aria-expanded="false" aria-controls="collapse7">
                                <i class="bi bi-server me-2"></i>
                                Que faire en cas d'erreur serveur ?
                            </button>
                        </h2>
                        <div id="collapse7" class="accordion-collapse collapse" data-bs-parent="#additionalQuestionsAccordion">
                            <div class="accordion-body">
                                Si vous rencontrez une erreur 500, vérifiez d'abord notre <strong>page de statut</strong> pour voir s'il y a des problèmes connus. Réessayez votre requête après quelques minutes, et si le problème persiste, contactez-nous avec les détails de l'erreur (timestamp, endpoint utilisé, payload) pour un diagnostic rapide.
                            </div>
                        </div>
                    </div>

                    <div class="accordion-item" data-keywords="compte supprimer delete account">
                        <h2 class="accordion-header">
                            <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#collapse8" aria-expanded="false" aria-controls="collapse8">
                                <i class="bi bi-person-x me-2"></i>
                                Comment supprimer mon compte ?
                            </button>
                        </h2>
                        <div id="collapse8" class="accordion-collapse collapse" data-bs-parent="#additionalQuestionsAccordion">
                            <div class="accordion-body">
                                Vous pouvez supprimer votre compte depuis votre <strong>tableau de bord</strong> dans les paramètres du compte. Cette action est <strong>irréversible</strong> et supprimera toutes vos données, clés API, et historiques d'utilisation. Nous vous recommandons d'exporter vos données importantes avant la suppression.
                            </div>
                        </div>
                    </div>

                    <div class="accordion-item" data-keywords="export données data export">
                        <h2 class="accordion-header">
                            <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#collapse9" aria-expanded="false" aria-controls="collapse9">
                                <i class="bi bi-download me-2"></i>
                                Puis-je exporter mes données ?
                            </button>
                        </h2>
                        <div id="collapse9" class="accordion-collapse collapse" data-bs-parent="#additionalQuestionsAccordion">
                            <div class="accordion-body">
                                Oui ! Vous pouvez exporter vos données personnelles et l'historique d'utilisation de votre API depuis votre tableau de bord. L'export est disponible en formats <strong>JSON</strong> et <strong>CSV</strong>. Cette fonctionnalité respecte votre droit à la portabilité des données selon le RGPD.
                            </div>
                        </div>
                    </div>

                    <div class="accordion-item" data-keywords="notification email alert">
                        <h2 class="accordion-header">
                            <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#collapse10" aria-expanded="false" aria-controls="collapse10">
                                <i class="bi bi-bell me-2"></i>
                                Comment gérer mes notifications ?
                            </button>
                        </h2>
                        <div id="collapse10" class="accordion-collapse collapse" data-bs-parent="#additionalQuestionsAccordion">
                            <div class="accordion-body">
                                Dans votre <strong>tableau de bord</strong>, section "Notifications", vous pouvez personnaliser les alertes que vous recevez : mises à jour API, maintenance planifiée, dépassement de quotas, nouvelles fonctionnalités. Vous pouvez choisir de recevoir ces notifications par email, webhook, ou les désactiver complètement.
                            </div>
                        </div>
                    </div>

                    <div class="accordion-item" data-keywords="collaboration partage sharing">
                        <h2 class="accordion-header">
                            <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#collapse11" aria-expanded="false" aria-controls="collapse11">
                                <i class="bi bi-people me-2"></i>
                                Puis-je partager mes données avec d'autres ?
                            </button>
                        </h2>
                        <div id="collapse11" class="accordion-collapse collapse" data-bs-parent="#additionalQuestionsAccordion">
                            <div class="accordion-body">
                                Vous pouvez créer des <strong>clés API partagées</strong> avec des permissions limitées pour collaborer sur des projets. Il est également possible de configurer des <strong>webhooks</strong> pour synchroniser vos données avec d'autres services. Toutes les permissions de partage sont configurables depuis votre tableau de bord.
                            </div>
                        </div>
                    </div>

                    <div class="accordion-item" data-keywords="performance optimisation speed">
                        <h2 class="accordion-header">
                            <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#collapse12" aria-expanded="false" aria-controls="collapse12">
                                <i class="bi bi-lightning me-2"></i>
                                Comment optimiser les performances ?
                            </button>
                        </h2>
                        <div id="collapse12" class="accordion-collapse collapse" data-bs-parent="#additionalQuestionsAccordion">
                            <div class="accordion-body">
                                Pour de meilleures performances : utilisez la <strong>mise en cache</strong> côté client, implémentez la <strong>pagination</strong> pour les grandes listes, utilisez les paramètres de filtrage disponibles, et évitez les requêtes fréquentes identiques. Notre documentation contient un guide détaillé sur les meilleures pratiques de performance.
                            </div>
                        </div>
                    </div>
                </div>

                <!-- No Results Message -->
                <div class="no-results d-none" id="noResults">
                    <div class="text-center py-5">
                        <i class="bi bi-search display-4 text-muted"></i>
                        <h4 class="mt-3">Aucun résultat trouvé</h4>
                        <p class="text-muted">Essayez avec des mots-clés différents ou contactez notre équipe.</p>
                    </div>
                </div>
            </div>

            <!-- Contact CTA -->
            <div class="contact-cta bg-white rounded-3 p-4 mt-4 shadow">
              <div class="contact-content d-flex align-items-center gap-3 mb-4">
                <div class="contact-text">
                  <h4 class="text-primary fw-semibold mb-2">Vous ne trouvez pas votre réponse ?</h4>
                  <p class="text-secondary mb-0">Consultez notre documentation ou contactez-nous directement.</p>
                </div>
              </div>
              <div class="contact-buttons d-flex justify-content-center gap-3">
                <a href="/docs" class="btn btn-outline-primary d-flex align-items-center gap-2">
                  <i class="bi bi-book"></i>
                  Documentation
                </a>
                <a href="#contact" class="btn btn-primary d-flex align-items-center gap-2">
                  <i class="bi bi-envelope"></i>
                  Nous contacter
                </a>
              </div>
            </div>
        </div>
    </div>

  <div class="section-divider">
    <div class="divider-icon">
      <i class="bi bi-arrow-down text-primary"></i>
    </div>
  </div>

  <div class="support-form-section" id="contact">
    <div class="container">
      <div class="row mb-5">
        <div class="col-md-4">
          <div class="contact-stats">
            <i class="bi bi-clock"></i>
            <h4>Réponse rapide</h4>
            <p>Moins de 24h en moyenne</p>
          </div>
        </div>
        <div class="col-md-4">
          <div class="contact-stats">
            <i class="bi bi-people"></i>
            <h4>Équipe dédiée</h4>
            <p>Support par des étudiants</p>
          </div>
        </div>
        <div class="col-md-4">
          <div class="contact-stats">
            <i class="bi bi-shield-check"></i>
            <h4>Sécurisé</h4>
            <p>Données protégées</p>
          </div>
        </div>
      </div>

      <!-- Contact Form -->
      <div class="row justify-content-center">
        <div class="col-lg-8">
          <div class="form-card">
            <div class="form-header">
              <h2><i class="bi bi-envelope-heart me-2"></i>Contactez-nous</h2>
              <p>Notre équipe est là pour vous aider. Décrivez votre problème et nous vous répondrons rapidement.</p>
            </div>
            <div class="form-body">
              <form
                id="supportForm"
                method="POST"
                enctype="multipart/form-data"
              >
                <div class="row">
                  <div class="col-md-6">
                    <div class="form-group">
                      <label for="supportName" class="form-label">
                        <i class="bi bi-person me-1"></i>Nom d'utilisateur
                      </label>
                      <input
                        type="text"
                        class="form-control <#if errors.username??>is-invalid</#if>"
                        id="supportName"
                        name="username"
                        value="${formData.username!''}"
                        placeholder="Votre nom d'utilisateur"
                        required
                      >
                      <#if errors.username??>
                        <div class="invalid-feedback">${errors.username[0]}</div>
                      </#if>
                    </div>
                  </div>
                  <div class="col-md-6">
                    <div class="form-group">
                      <label for="supportEmail" class="form-label">
                        <i class="bi bi-envelope me-1"></i>Adresse email
                      </label>
                      <input
                        type="email"
                        class="form-control <#if errors.email??>is-invalid</#if>"
                        id="supportEmail"
                        name="email"
                        value="${formData.email!''}"
                        placeholder="votre.email@cstsr.qc.ca"
                        required
                      >
                      <#if errors.email??>
                        <div class="invalid-feedback">${errors.email[0]}</div>
                      </#if>
                    </div>
                  </div>
                </div>

                <div class="form-group">
                  <label for="supportSubject" class="form-label">
                    <i class="bi bi-tag me-1"></i>Sujet
                  </label>
                  <input
                    type="text"
                    class="form-control <#if errors.subject??>is-invalid</#if>"
                    id="supportSubject"
                    name="subject"
                    value="${formData.subject!''}"
                    placeholder="Décrivez brièvement votre problème"
                    required
                  >
                  <#if errors.subject??>
                    <div class="invalid-feedback">${errors.subject[0]}</div>
                  </#if>
                </div>

                <div class="form-group">
                  <label for="supportMessage" class="form-label">
                    <i class="bi bi-chat-text me-1"></i>Message
                  </label>
                  <textarea
                    class="form-control <#if errors.message??>is-invalid</#if>"
                    id="supportMessage"
                    name="message"
                    rows="6"
                    placeholder="Décrivez votre problème en détail. Plus vous donnerez d'informations, plus nous pourrons vous aider efficacement."
                    required
                  >${formData.message!''}</textarea>
                  <#if errors.message??>
                    <div class="invalid-feedback">${errors.message[0]}</div>
                  </#if>
                </div>

                <div class="form-group">
                  <label for="supportFiles" class="form-label">
                    <i class="bi bi-paperclip me-1"></i>Fichiers joints (optionnel)
                  </label>
                  <input
                    type="file"
                    class="form-control"
                    id="supportFiles"
                    name="files"
                    multiple
                    accept=".jpg,.jpeg,.png,.pdf,.txt,.log"
                  >
                  <div class="form-text">
                    <small>Formats acceptés: JPG, PNG, PDF, TXT, LOG (max 10 MB par fichier)</small>
                  </div>
                </div>

                <div class="d-grid">
                  <button type="submit" class="btn btn-primary btn-lg" id="supportSubmitBtn">
                    <i class="bi bi-send me-2"></i>Envoyer le message
                  </button>
                  <script nonce="${nonce()}" >
                    document.getElementById('supportForm').addEventListener('submit', function(e) {
                      const submitBtn = document.getElementById('supportSubmitBtn');
                      submitBtn.disabled = true;
                      submitBtn.innerHTML = '<span class="spinner-border spinner-border-sm me-2" role="status" aria-hidden="true"></span>Envoi en cours...';
                  });
                  </script>
                </div>
              </form>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>

  <#include "/components/footer.ftl"/>

  <script
    nonce="${nonce()}"
    src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"
    integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz"
    crossorigin="anonymous"
  ></script>
  <script nonce="${nonce()}" src="/js/views/support.js"></script>
</body>
</html>