<!DOCTYPE html>
<html lang="fr">
<head>
    <#assign pageTitle = "Tableau de bord" />
    <#assign additionalCSS = ["style/views/dashboard.css"] />
    <#include "macros/head.ftl"/>
</head>
<body>
    <#assign currentPage = "dashboard" />
    <#include "components/flash.ftl">
    <#include "components/navbar.ftl">

    <div class="dashboard-hero text-white py-5">
        <div class="container">
            <div class="row">
                <div class="col-lg-10 mx-auto text-center">
                    <h1 class="display-4 fw-bold mb-3">Tableau de bord</h1>
                    <p class="lead">Gérez vos clés API et surveillez votre utilisation avec DonnéesCST</p>
                </div>
                 <div class="dashboard-overview py-5 mt-5">
                    <div class="container">
                        <div class="row g-5">
                            <div class="col-md-4">
                                <div class="card h-100 shadow-sm stat-card">
                                    <div class="card-body text-center">
                                        <i class="bi bi-calendar-check fs-1"></i>
                                        <h3 class="mt-3">1,847</h3>
                                        <p class="text-muted">Utilisation mensuelle</p>
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-4">
                                <div class="card h-100 shadow-sm stat-card">
                                    <div class="card-body text-center">
                                        <i class="bi bi-clock-fill fs-1"></i>
                                        <h3 class="mt-3">73</h3>
                                        <p class="text-muted">Utilisation quotidienne</p>
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-4">
                                <div class="card h-100 shadow-sm stat-card">
                                    <div class="card-body text-center">
                                        <i class="bi bi-key-fill fs-1"></i>
                                        <h3 class="mt-3">5</h3>
                                        <p class="text-muted">Clés API actives</p>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <div class="usage-limits py-5">
        <div class="container">
            <div class="row g-4">
                <div class="col-md-6">
                    <div class="card h-100 shadow-sm">
                        <div class="card-body">
                            <h5 class="card-title fw-bold">Limite mensuelle <i class="bi bi-calendar-check ms-2"></i></h5>
                            <p class="text-muted mb-3">1,847 / 2,500</p>
                            <div class="progress mb-2">
                                <div class="progress-bar bg-success" role="progressbar" style="width: 73.9%;" aria-valuenow="73.9" aria-valuemin="0" aria-valuemax="100"></div>
                            </div>
                            <span class="badge bg-success">73.9%</span>
                        </div>
                    </div>
                </div>
                <div class="col-md-6">
                    <div class="card h-100 shadow-sm">
                        <div class="card-body">
                            <h5 class="card-title fw-bold">Limite quotidienne <i class="bi bi-clock-fill ms-2"></i></h5>
                            <p class="text-muted mb-3">73 / 250</p>
                            <div class="progress mb-2">
                                <div class="progress-bar bg-primary" role="progressbar" style="width: 29.2%;" aria-valuenow="29.2" aria-valuemin="0" aria-valuemax="100"></div>
                            </div>
                            <span class="badge bg-primary">29.2%</span>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <div class="dashboard-sections py-5">
        <div class="container">
            <div class="row g-4">
                <div class="col-lg-6">
                    <div class="card h-100 shadow-sm">
                        <div class="card-body">
                            <h5 class="card-title fw-bold">Paramètres du compte <i class="bi bi-gear-fill ms-2"></i></h5>

                            <div class="mb-4">
                                <h6 class="fw-bold mb-3">Changer le mot de passe</h6>
                                <form id="changePasswordForm">
                                    <div class="mb-3">
                                        <label class="form-label">Mot de passe actuel</label>
                                        <input type="password" class="form-control" name="currentPassword" required>
                                    </div>
                                    <div class="mb-3">
                                        <label class="form-label">Nouveau mot de passe</label>
                                        <input type="password" class="form-control" name="newPassword" required>
                                    </div>
                                    <div class="mb-3">
                                        <label class="form-label">Confirmer le nouveau mot de passe</label>
                                        <input type="password" class="form-control" name="confirmPassword" required>
                                    </div>
                                    <button type="submit" class="btn btn-primary">Mettre à jour</button>
                                </form>
                            </div>

                            <hr>

                            <div class="mb-4">
                                <h6 class="fw-bold mb-3">Changer l'adresse email</h6>
                                <form id="changeEmailForm">
                                    <div class="mb-3">
                                        <label class="form-label">Nouvelle adresse email</label>
                                        <input type="email" class="form-control" name="newEmail" value="john.doe@example.com" required>
                                    </div>
                                    <button type="submit" class="btn btn-primary">Mettre à jour l'email</button>
                                </form>
                            </div>

                            <hr>

                            <div class="mb-4">
                                <h6 class="fw-bold mb-3">Authentification à deux facteurs (MFA)</h6>
                                <form id="mfaForm">
                                    <div class="mb-3">
                                        <label class="form-label">Méthode MFA</label>
                                        <select class="form-select" id="mfaMethod" name="mfaMethod">
                                            <option value="disabled">Désactivée</option>
                                            <option value="email" selected>Email</option>
                                            <option value="app">Application d'authentification</option>
                                        </select>
                                    </div>
                                    <div id="appMfaConfig" class="app-mfa-config-hidden">
                                        <button type="button" class="btn btn-outline-primary" data-bs-toggle="modal" data-bs-target="#qrModal">
                                            <i class="bi bi-qr-code"></i> Configurer l'application
                                        </button>
                                    </div>
                                    <div class="mb-3">
                                        <div class="form-check form-switch">
                                            <input class="form-check-input" type="checkbox" id="enableGracePeriod" name="enableGracePeriod" checked>
                                            <label class="form-check-label" for="enableGracePeriod">Activer la période de grâce</label>
                                        </div>
                                    </div>
                                    <div id="gracePeriodSettings" class="app-mfa-config-visible">
                                        <label class="form-label">Durée de la période de grâce</label>
                                        <select class="form-select" name="gracePeriod">
                                            <option value="0">À chaque connexion</option>
                                            <option value="3">3 jours</option>
                                            <option value="7" selected>7 jours</option>
                                            <option value="14">14 jours</option>
                                            <option value="30">30 jours</option>
                                        </select>
                                    </div>
                                    <button type="submit" class="btn btn-primary">Sauvegarder MFA</button>
                                </form>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="col-lg-6">
                    <div class="card h-100 shadow-sm">
                        <div class="card-body">
                            <h5 class="card-title fw-bold">Gestion des clés API <i class="bi bi-key-fill ms-2"></i></h5>
                            <div class="d-flex justify-content-between align-items-center mb-4">
                                <button class="btn btn-success" data-bs-toggle="modal" data-bs-target="#createKeyModal">
                                    <i class="bi bi-plus"></i> Créer une nouvelle clé
                                </button>
                                <div>
                                    <button id="revealKeysBtn" class="btn btn-outline-secondary me-2 reveal-keys-visible">
                                        <i class="bi bi-eye"></i> Révéler les clés
                                    </button>
                                    <button id="maskKeysBtn" class="btn btn-outline-secondary reveal-keys-hidden">
                                        <i class="bi bi-eye-slash"></i> Masquer les clés
                                    </button>
                                </div>
                            </div>

                            <div id="apiKeysList">
                                <div class="card mb-3">
                                    <div class="card-body">
                                        <div class="d-flex justify-content-between align-items-start mb-2">
                                            <h6 class="card-title mb-1">Clé API #1</h6>
                                            <button class="btn btn-outline-danger btn-sm delete-key" data-key-id="1">
                                                <i class="bi bi-trash"></i>
                                            </button>
                                        </div>
                                        <div class="api-key-value bg-dark text-light p-2 rounded mb-2 masked" data-key-id="1">
                                            ak_test_51HyKGwBGqkqk7v9Vn7Ec4v6v5vP1VcR2Q8cZLz9Rx8v7vS6sT5sU4uW3wX2xY1z
                                        </div>
                                        <div class="row small text-muted">
                                            <div class="col-4">
                                                <strong>Créée le:</strong><br>15/01/2024
                                            </div>
                                            <div class="col-4">
                                                <strong>Dernière utilisation:</strong><br>20/07/2025
                                            </div>
                                            <div class="col-4">
                                                <strong>Utilisations:</strong><br><span class="fw-bold text-primary">847</span>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="card mb-3">
                                    <div class="card-body">
                                        <div class="d-flex justify-content-between align-items-start mb-2">
                                            <h6 class="card-title mb-1">Clé API #2</h6>
                                            <button class="btn btn-outline-danger btn-sm delete-key" data-key-id="2">
                                                <i class="bi bi-trash"></i>
                                            </button>
                                        </div>
                                        <div class="api-key-value bg-dark text-light p-2 rounded mb-2 masked" data-key-id="2">
                                            ak_test_51HyKGwBGqkqk7v9Vn8Fd5v7v6vQ2WdS3R9dAM0Sy9v8vT7sV6sX5xZ4yW3vU2t
                                        </div>
                                        <div class="row small text-muted">
                                            <div class="col-4">
                                                <strong>Créée le:</strong><br>10/02/2024
                                            </div>
                                            <div class="col-4">
                                                <strong>Dernière utilisation:</strong><br>20/07/2025
                                            </div>
                                            <div class="col-4">
                                                <strong>Utilisations:</strong><br><span class="fw-bold text-primary">523</span>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <div class="usage-analytics py-5">
        <div class="container">
            <div class="row g-4">
                <div class="col-lg-8">
                    <div class="card h-100 shadow-sm">
                        <div class="card-body">
                            <h5 class="card-title fw-bold">Utilisation mensuelle globale <i class="bi bi-graph-up ms-2"></i></h5>
                            <div class="chart-container">
                                <canvas id="monthlyUsageChart"></canvas>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-lg-4">
                    <div class="card h-100 shadow-sm">
                        <div class="card-body">
                            <h5 class="card-title fw-bold">Utilisation par clé <i class="bi bi-table ms-2"></i></h5>
                            <div class="table-responsive">
                                <table class="table table-sm">
                                    <thead>
                                        <tr>
                                            <th>Clé</th>
                                            <th>Utilisations</th>
                                            <th>%</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <tr>
                                            <td>Clé #1</td>
                                            <td>847</td>
                                            <td><span class="badge bg-primary">45.9%</span></td>
                                        </tr>
                                        <tr>
                                            <td>Clé #2</td>
                                            <td>523</td>
                                            <td><span class="badge bg-success">28.3%</span></td>
                                        </tr>
                                        <tr>
                                            <td>Clé #3</td>
                                            <td>312</td>
                                            <td><span class="badge bg-info">16.9%</span></td>
                                        </tr>
                                        <tr>
                                            <td>Clé #4</td>
                                            <td>145</td>
                                            <td><span class="badge bg-warning">7.8%</span></td>
                                        </tr>
                                        <tr>
                                            <td>Clé #5</td>
                                            <td>20</td>
                                            <td><span class="badge bg-secondary">1.1%</span></td>
                                        </tr>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- QR Code Modal -->
    <div class="modal fade" id="qrModal" tabindex="-1" aria-labelledby="qrModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="qrModalLabel"><i class="bi bi-qr-code me-2"></i>Configuration de l'authentificateur</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body text-center">
                    <p>Scannez ce code QR avec votre application d'authentification :</p>
                    <div class="bg-white p-3 rounded mx-auto mb-3 d-inline-block">
                        <canvas id="qrCanvas"></canvas>
                    </div>
                    <p class="small text-muted">Ou entrez manuellement cette clé secrète :<br><code>JBSWY3DPEHPK3PXP</code></p>
                    <div class="alert alert-info">
                        <i class="bi bi-info-circle me-2"></i>Une fois configuré, vous devrez entrer le code de votre application pour vous connecter.
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Fermer</button>
                    <button type="button" class="btn btn-primary" data-bs-dismiss="modal">Terminé</button>
                </div>
            </div>
        </div>
    </div>

    <!-- Create API Key Modal -->
    <div class="modal fade" id="createKeyModal" tabindex="-1" aria-labelledby="createKeyModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="createKeyModalLabel"><i class="bi bi-plus me-2"></i>Créer une nouvelle clé API</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <div class="alert alert-info">
                        <i class="bi bi-info-circle me-2"></i>Les clés API n'expirent jamais et restent valides jusqu'à leur suppression.
                    </div>
                    <form id="createKeyForm">
                        <div class="mb-3">
                            <label class="form-label">Nom de la clé</label>
                            <input type="text" class="form-control" name="keyName" required>
                        </div>
                        <button type="submit" class="btn btn-success">Créer la clé</button>
                    </form>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Annuler</button>
                </div>
            </div>
        </div>
    </div>

    <!-- Reveal Keys Password Modal -->
    <div class="modal fade" id="passwordModal" tabindex="-1" aria-labelledby="passwordModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered modal-sm">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="passwordModalLabel"><i class="bi bi-lock me-2"></i>Confirmation</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <p>Entrez votre mot de passe pour révéler les clés API :</p>
                    <div class="mb-3">
                        <input type="password" class="form-control" id="passwordInput" placeholder="Mot de passe" required>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Annuler</button>
                    <button type="button" class="btn btn-primary" id="confirmReveal">Révéler</button>
                </div>
            </div>
        </div>
    </div>

    <#include "components/footer.ftl">
    <script nonce="${nonce()}" src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
    <script nonce="${nonce()}" src="/js/views/dashboard.js"></script>
</body>
</html>