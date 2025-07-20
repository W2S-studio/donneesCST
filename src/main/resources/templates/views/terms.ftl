<!DOCTYPE html>
<html lang="fr">
<head>
  <#assign pageTitle = "Conditions d'utilisation" />
  <#assign additionalCSS = [] />
  <#include "../macros/head.ftl"/>
</head>
<style nonce="${nonce()}">
  body {
    background: var(--cegep-gradient);
  }
</style>
<body>
  <div class="d-flex flex-column min-vh-100 py-5">
    <div class="container d-flex flex-column justify-content-center flex-grow-1">
      <div class="row justify-content-center">
        <div class="col-lg-10 col-xl-8">
          <div class="card shadow-lg">
            <div class="card-body p-5">
              <h2 class="text-center fw-bold mb-5">Conditions d'utilisation</h2>
              <div id="termsContent" class="accordion" id="termsAccordion">
                <div class="accordion-item">
                  <h5 class="accordion-header">
                    <button class="accordion-button" type="button" data-bs-toggle="collapse" data-bs-target="#collapseOne" aria-expanded="true" aria-controls="collapseOne">
                      1. Préambule et acceptation des conditions
                    </button>
                  </h5>
                  <div id="collapseOne" class="accordion-collapse collapse show" data-bs-parent="#termsAccordion">
                    <div class="accordion-body">
                      <p>
                        Les présentes Conditions d'utilisation (« Conditions ») régissent l'accès et l'utilisation du projet DonnéesCST (« le Projet »), une plateforme open-source gratuite disponible sur GitHub, ainsi que de ses services associés (collectivement, les « Services »). En accédant ou en utilisant les Services, vous (« l'Utilisateur » ou « vous ») acceptez d'être lié par ces Conditions et par la licence open-source applicable (disponible sur le référentiel GitHub du Projet). Si vous n'acceptez pas ces Conditions, vous ne devez pas utiliser les Services.
                      </p>
                    </div>
                  </div>
                </div>
                <div class="accordion-item">
                  <h5 class="accordion-header">
                    <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#collapseTwo" aria-expanded="false" aria-controls="collapseTwo">
                      2. Description du projet
                    </button>
                  </h5>
                  <div id="collapseTwo" class="accordion-collapse collapse" data-bs-parent="#termsAccordion">
                    <div class="accordion-body">
                      <p>
                        DonnéesCST est un projet open-source hébergé sur GitHub, offrant des fonctionnalités de gestion, stockage, analyse et visualisation de données. Les Services sont fournis gratuitement, sans garantie, dans le cadre d'une licence open-source. Les contributeurs du Projet peuvent modifier, améliorer ou interrompre des fonctionnalités à leur discrétion, conformément aux pratiques de la communauté open-source.
                      </p>
                    </div>
                  </div>
                </div>
                <div class="accordion-item">
                  <h5 class="accordion-header">
                    <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#collapseThree" aria-expanded="false" aria-controls="collapseThree">
                      3. Éligibilité et obligations de l'utilisateur
                    </button>
                  </h5>
                  <div id="collapseThree" class="accordion-collapse collapse" data-bs-parent="#termsAccordion">
                    <div class="accordion-body">
                      <p>
                        Pour utiliser les Services, vous devez :
                        <ul>
                          <li>Fournir des informations exactes et à jour lors de la création d'un compte, si applicable.</li>
                          <li>Maintenir la confidentialité de vos identifiants de connexion et nous informer immédiatement en cas d'utilisation non autorisée via <a href="mailto:support@jolt-framework.org">support@jolt-framework.org</a>.</li>
                          <li>Respecter la licence open-source du Projet (disponible sur GitHub) pour toute utilisation, modification ou distribution du code source.</li>
                          <li>Ne pas utiliser les Services à des fins illégales, nuisibles ou contraires à ces Conditions.</li>
                          <li>Ne pas tenter d'accéder sans autorisation aux systèmes ou données associés au Projet.</li>
                        </ul>
                      </p>
                    </div>
                  </div>
                </div>
                <div class="accordion-item">
                  <h5 class="accordion-header">
                    <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#collapseFour" aria-expanded="false" aria-controls="collapseFour">
                      4. Collecte et utilisation des données
                    </button>
                  </h5>
                  <div id="collapseFour" class="accordion-collapse collapse" data-bs-parent="#termsAccordion">
                    <div class="accordion-body">
                      <p>
                        Dans le cadre de ce projet open-source, nous pouvons collecter les informations suivantes :
                        <ul>
                          <li>Données personnelles : prénom, nom d'utilisateur, adresse email (si fournis pour l'inscription ou les communications).</li>
                          <li>Données techniques : adresse IP, chaîne User-Agent, type de navigateur, système d'exploitation, et journaux d'activité pour la sécurité et l'amélioration des Services.</li>
                          <li>Données d'utilisation : informations sur l'interaction avec les Services, telles que les fonctionnalités utilisées.</li>
                        </ul>
                        Ces données sont utilisées pour :
                        <ul>
                          <li>Gérer les comptes utilisateurs, si applicable.</li>
                          <li>Faciliter les communications avec la communauté open-source.</li>
                          <li>Améliorer les fonctionnalités du Projet.</li>
                          <li>Détecter et prévenir les abus ou activités non autorisées.</li>
                        </ul>
                      </p>
                    </div>
                  </div>
                </div>
                <div class="accordion-item">
                  <h5 class="accordion-header">
                    <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#collapseFive" aria-expanded="false" aria-controls="collapseFive">
                      5. Confidentialité et sécurité
                    </button>
                  </h5>
                  <div id="collapseFive" class="accordion-collapse collapse" data-bs-parent="#termsAccordion">
                    <div class="accordion-body">
                      <p>
                        Nous nous engageons à protéger vos données personnelles conformément à la licence open-source et aux pratiques de la communauté. Les données collectées ne seront partagées qu'avec :
                        <ul>
                          <li>Les contributeurs du Projet pour la maintenance et l'amélioration des Services.</li>
                          <li>Les autorités compétentes, si requis par la loi.</li>
                        </ul>
                        Nous utilisons des mesures de sécurité standard, telles que le cryptage TLS/SSL, pour protéger les données, mais aucune garantie absolue de sécurité n'est fournie en raison de la nature open-source du Projet.
                      </p>
                    </div>
                  </div>
                </div>
                <div class="accordion-item">
                  <h5 class="accordion-header">
                    <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#collapseSix" aria-expanded="false" aria-controls="collapseSix">
                      6. Propriété intellectuelle
                    </button>
                  </h5>
                  <div id="collapseSix" class="accordion-collapse collapse" data-bs-parent="#termsAccordion">
                    <div class="accordion-body">
                      <p>
                        Le code source, la documentation et les autres contenus du Projet sont régis par la licence open-source spécifiée dans le référentiel GitHub. Vous êtes libre d'utiliser, modifier et distribuer le code conformément à cette licence. Tout contenu que vous soumettez au Projet (par exemple, via des contributions sur GitHub) est soumis à la même licence, et vous garantissez que vous avez le droit de soumettre ce contenu.
                      </p>
                    </div>
                  </div>
                </div>
                <div class="accordion-item">
                  <h5 class="accordion-header">
                    <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#collapseSeven" aria-expanded="false" aria-controls="collapseSeven">
                      7. Durée de conservation des données
                    </button>
                  </h5>
                  <div id="collapseSeven" class="accordion-collapse collapse" data-bs-parent="#termsAccordion">
                    <div class="accordion-body">
                      <p>
                        Les données personnelles, si collectées, sont conservées uniquement pour la durée nécessaire à la fourniture des Services ou à la gestion des contributions. Vous pouvez demander la suppression de vos données en contactant <a href="mailto:support@jolt-framework.org">support@jolt-framework.org</a>. Certaines données peuvent être conservées dans les journaux publics du Projet (par exemple, les historiques GitHub) conformément à la licence open-source.
                      </p>
                    </div>
                  </div>
                </div>
                <div class="accordion-item">
                  <h5 class="accordion-header">
                    <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#collapseEight" aria-expanded="false" aria-controls="collapseEight">
                      8. Résiliation
                    </button>
                  </h5>
                  <div id="collapseEight" class="accordion-collapse collapse" data-bs-parent="#termsAccordion">
                    <div class="accordion-body">
                      <p>
                        Vous pouvez cesser d'utiliser les Services à tout moment. Nous nous réservons le droit de suspendre ou de restreindre l'accès à un utilisateur en cas de violation de ces Conditions, d'activités illégales ou d'abus, sans préavis. Les obligations liées à la licence open-source survivent à la cessation d'utilisation.
                      </p>
                    </div>
                  </div>
                </div>
                <div class="accordion-item">
                  <h5 class="accordion-header">
                    <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#collapseNine" aria-expanded="false" aria-controls="collapseNine">
                      9. Absence de garantie et limitation de responsabilité
                    </button>
                  </h5>
                  <div id="collapseNine" class="accordion-collapse collapse" data-bs-parent="#termsAccordion">
                    <div class="accordion-body">
                      <p>
                        Les Services sont fournis « tels quels », sans garantie d'aucune sorte, expresse ou implicite, y compris les garanties de qualité marchande ou d'adéquation à un usage particulier. En raison de la nature open-source du Projet, les contributeurs ne peuvent être tenus responsables des dommages directs, indirects, accessoires, spéciaux ou consécutifs découlant de l'utilisation ou de l'impossibilité d'utiliser les Services.
                      </p>
                    </div>
                  </div>
                </div>
                <div class="accordion-item">
                  <h5 class="accordion-header">
                    <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#collapseTen" aria-expanded="false" aria-controls="collapseTen">
                      10. Contributions au projet
                    </button>
                  </h5>
                  <div id="collapseTen" class="accordion-collapse collapse" data-bs-parent="#termsAccordion">
                    <div class="accordion-body">
                      <p>
                        Si vous contribuez au Projet (par exemple, via des pull requests sur GitHub), vous acceptez que vos contributions soient soumises à la licence open-source du Projet. Vous garantissez que vos contributions sont originales ou que vous avez les droits nécessaires pour les soumettre.
                      </p>
                    </div>
                  </div>
                </div>
                <div class="accordion-item">
                  <h5 class="accordion-header">
                    <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#collapseEleven" aria-expanded="false" aria-controls="collapseEleven">
                      11. Modifications des conditions
                    </button>
                  </h5>
                  <div id="collapseEleven" class="accordion-collapse collapse" data-bs-parent="#termsAccordion">
                    <div class="accordion-body">
                      <p>
                        Nous pouvons modifier ces Conditions à tout moment. Les modifications seront publiées sur cette page ou dans le référentiel GitHub. Votre utilisation continue des Services après la publication des modifications constitue votre acceptation de celles-ci. Si vous n'acceptez pas les nouvelles Conditions, vous devez cesser d'utiliser les Services.
                      </p>
                    </div>
                  </div>
                </div>
                <div class="accordion-item">
                  <h5 class="accordion-header">
                    <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#collapseTwelve" aria-expanded="false" aria-controls="collapseTwelve">
                      12. Droit applicable et règlement des litiges
                    </button>
                  </h5>
                  <div id="collapseTwelve" class="accordion-collapse collapse" data-bs-parent="#termsAccordion">
                    <div class="accordion-body">
                      <p>
                        Ces Conditions sont régies par les lois de la province de Québec, Canada, sans égard aux principes de conflits de lois. Tout litige découlant de ces Conditions ou de l'utilisation des Services sera soumis à la juridiction exclusive des tribunaux de la province de Québec, situés dans la ville de Québec.
                      </p>
                    </div>
                  </div>
                </div>
                <div class="accordion-item">
                  <h5 class="accordion-header">
                    <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#collapseThirteen" aria-expanded="false" aria-controls="collapseThirteen">
                      13. Dispositions diverses
                    </button>
                  </h5>
                  <div id="collapseThirteen" class="accordion-collapse collapse" data-bs-parent="#termsAccordion">
                    <div class="accordion-body">
                      <p>
                        <ul>
                          <li><strong>Force majeure :</strong> Les contributeurs du Projet ne sont pas responsables des retards ou interruptions des Services dus à des événements hors de leur contrôle, tels que des pannes de réseau ou des catastrophes naturelles.</li>
                          <li><strong>Intégralité de l'accord :</strong> Ces Conditions, combinées à la licence open-source du Projet, constituent l'intégralité de l'accord entre vous et les contributeurs du Projet.</li>
                          <li><strong>Divisibilité :</strong> Si une disposition de ces Conditions est jugée invalide, les autres dispositions resteront en vigueur.</li>
                        </ul>
                      </p>
                    </div>
                  </div>
                </div>
                <div class="accordion-item">
                  <h5 class="accordion-header">
                    <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#collapseFourteen" aria-expanded="false" aria-controls="collapseFourteen">
                      14. Contact
                    </button>
                  </h5>
                  <div id="collapseFourteen" class="accordion-collapse collapse" data-bs-parent="#termsAccordion">
                    <div class="accordion-body">
                      <p>
                        Pour toute question concernant ces Conditions ou le Projet, veuillez nous contacter à <a href="mailto:support@jolt-framework.org">support@jolt-framework.org</a>.
                      </p>
                    </div>
                  </div>
                </div>
              </div>
              <div class="text-center mt-4">
                <a href="/" class="btn btn-primary">Accueil</a>
              </div>
            </div>
          </div>
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
</body>
</html>