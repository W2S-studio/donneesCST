<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${pageTitle!"Erreur - Quelque chose s'est mal passé"}</title>
    <link nonce="${nonce()}" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
    <link nonce="${nonce()}" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn-icons-png.flaticon.com/512/3872/3872759.png">
    <style nonce="${nonce()}">
        :root {
            --primary-color: #0d6efd;
            --danger-color: #dc3545;
            --warning-color: #ffc107;
            --success-color: #198754;
            --dark-color: #212529;
        }

        body {
            background: linear-gradient(135deg, #f8f9fa 0%, #e9ecef 100%);
            font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif;
        }

        .error-container {
            background: white;
            border-radius: 15px;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
            border: 1px solid #dee2e6;
            overflow: hidden;
        }

        .error-header {
            background: linear-gradient(135deg, var(--danger-color), #c82333);
            color: white;
            padding: 2rem;
            text-align: center;
        }

        .status-code {
            font-size: 3rem;
            font-weight: 700;
            margin: 0;
            text-shadow: 0 2px 4px rgba(0, 0, 0, 0.3);
        }

        .error-title {
            font-size: 1.5rem;
            margin: 0.5rem 0 0 0;
            font-weight: 500;
        }

        .error-content {
            padding: 2rem;
        }

        .info-card {
            background: #f8f9fa;
            border: 1px solid #e9ecef;
            border-radius: 8px;
            padding: 1rem;
            margin: 1rem 0;
        }

        .suggestion-list {
            list-style: none;
            padding: 0;
        }

        .suggestion-item {
            background: #e3f2fd;
            border-left: 4px solid var(--primary-color);
            padding: 0.75rem;
            margin: 0.5rem 0;
            border-radius: 0 5px 5px 0;
        }

        .btn-action {
            padding: 0.75rem 1.5rem;
            border-radius: 8px;
            font-weight: 500;
            text-decoration: none;
            display: inline-flex;
            align-items: center;
            gap: 0.5rem;
            transition: all 0.2s ease;
        }

        .btn-action:hover {
            transform: translateY(-1px);
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.15);
        }

        .technical-details {
            background: #2d3748;
            color: #68d391;
            font-family: 'Courier New', monospace;
            font-size: 0.85rem;
            padding: 1.5rem;
            border-radius: 8px;
            margin-top: 1rem;
            max-height: 400px;
            overflow-y: auto;
            border: 1px solid #4a5568;
        }

        .error-id-display {
            font-family: 'Courier New', monospace;
            background: #f8f9fa;
            padding: 0.5rem 1rem;
            border-radius: 20px;
            font-size: 0.9rem;
            border: 1px solid #dee2e6;
            display: inline-block;
        }

        .countdown-display {
            font-family: 'Courier New', monospace;
            font-weight: bold;
            color: var(--warning-color);
            font-size: 1.1rem;
        }

        .category-badge {
            background: var(--warning-color);
            color: #000;
            padding: 0.25rem 0.75rem;
            border-radius: 15px;
            font-size: 0.8rem;
            font-weight: 600;
            text-transform: uppercase;
        }

        .metadata-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 1rem;
            margin: 1rem 0;
        }

        .metadata-item {
            background: #f8f9fa;
            padding: 1rem;
            border-radius: 8px;
            border: 1px solid #e9ecef;
        }

        .metadata-label {
            font-weight: 600;
            color: #6c757d;
            font-size: 0.85rem;
            text-transform: uppercase;
            letter-spacing: 0.5px;
            margin-bottom: 0.25rem;
        }

        .metadata-value {
            color: var(--dark-color);
            font-family: 'Courier New', monospace;
            font-size: 0.9rem;
            word-break: break-all;
        }

        @media (max-width: 768px) {
            .error-header {
                padding: 1.5rem 1rem;
            }
            
            .error-content {
                padding: 1.5rem 1rem;
            }
            
            .status-code {
                font-size: 2.5rem;
            }
        }
    </style>
</head>
<body class="min-vh-100 d-flex flex-column">
    <main class="container flex-grow-1 d-flex align-items-center py-4">
        <div class="w-100 mx-auto" style="max-width: 800px;">
            <div class="error-container">
                <div class="error-header">
                    <div class="d-flex justify-content-center align-items-center gap-3 mb-2">
                        <h1 class="status-code">${status!"500"}</h1>
                        <#if category??>
                            <span class="category-badge">${category}</span>
                        </#if>
                    </div>
                    
                    <h2 class="error-title">
                        <#if status?? && status == 404>
                            Page Introuvable
                        <#elseif status?? && status == 500>
                            Erreur Serveur Interne
                        <#elseif status?? && status == 403>
                            Accès Interdit
                        <#elseif status?? && status == 401>
                            Authentification Requise
                        <#elseif status?? && status == 429>
                            Trop de Requêtes
                        <#else>
                            Une Erreur s'est Produite
                        </#if>
                    </h2>
                </div>

                <div class="error-content">
                    <div class="alert alert-danger border-0 mb-4">
                        <div class="d-flex align-items-start">
                            <i class="bi bi-exclamation-triangle-fill me-3 mt-1" style="font-size: 1.2rem;"></i>
                            <div>
                                <h5 class="alert-heading mb-2">Que s'est-il passé ?</h5>
                                <#if userMessage??>
                                    <p class="mb-0">${userMessage}</p>
                                <#else>
                                    <p class="mb-0">Une erreur inattendue s'est produite lors du traitement de votre demande.</p>
                                </#if>
                            </div>
                        </div>
                    </div>

                    <div class="metadata-grid">
                        <div class="metadata-item">
                            <div class="metadata-label">ID d'Erreur</div>
                            <div class="metadata-value">${errorId!"N/A"}</div>
                        </div>
                        <div class="metadata-item">
                            <div class="metadata-label">Horodatage</div>
                            <div class="metadata-value">${timestamp!"Non disponible"}</div>
                        </div>
                        <#if statusReason??>
                        <div class="metadata-item">
                            <div class="metadata-label">Statut HTTP</div>
                            <div class="metadata-value">${status} - ${statusReason}</div>
                        </div>
                        </#if>
                    </div>

                    <#if suggestions?? && suggestions?has_content>
                        <div class="info-card">
                            <h5 class="mb-3">
                                <i class="bi bi-lightbulb text-warning me-2"></i>
                                Que pouvez-vous faire ?
                            </h5>
                            <ul class="suggestion-list">
                                <#list suggestions as suggestion>
                                    <li class="suggestion-item">
                                        <i class="bi bi-arrow-right me-2 text-primary"></i>
                                        ${suggestion}
                                    </li>
                                </#list>
                            </ul>
                        </div>
                    </#if>

                    <div class="d-flex flex-wrap gap-3 justify-content-center mt-4">
                        <a href="/" class="btn btn-primary btn-action">
                            <i class="bi bi-house-fill"></i>
                            Retour à l'Accueil
                        </a>
                        
                        <#if canRetry?? && canRetry>
                            <button class="btn btn-outline-primary btn-action" id="retryBtn">
                                <i class="bi bi-arrow-clockwise"></i>
                                Réessayer
                            </button>
                        </#if>
                        
                        <button class="btn btn-outline-secondary btn-action">
                            <i class="bi bi-arrow-left"></i>
                            Page Précédente
                        </button>
                    </div>

                    <#if canRetry?? && canRetry>
                        <div class="text-center mt-3" id="autoRetrySection">
                            <small class="text-muted">
                                <i class="bi bi-clock me-1"></i>
                                Nouvelle tentative automatique dans 
                                <span class="countdown-display" id="countdown">30</span> secondes
                                <button class="btn btn-link btn-sm p-0 ms-2">
                                    (Annuler)
                                </button>
                            </small>
                        </div>
                    </#if>

                    <#if showTechnicalDetails?? && showTechnicalDetails>
                        <div class="mt-4">
                            <button class="btn btn-outline-dark btn-sm" id="technicalBtn">
                                <i class="bi bi-code-slash me-2"></i>
                                Afficher les Détails Techniques
                            </button>
                            
                            <div id="technicalDetails" class="technical-details" style="display: none;">
                                <div class="mb-3">
                                    <strong class="text-white">🔧 Informations Techniques</strong>
                                </div>
                                
                                <div class="row">
                                    <div class="col-md-6 mb-3">
                                        <div><strong>Code de Statut:</strong> ${status!"N/A"}</div>
                                        <div><strong>Message d'Erreur:</strong> ${message!"N/A"}</div>
                                        <div><strong>ID d'Erreur:</strong> ${errorId!"N/A"}</div>
                                        <div><strong>Horodatage:</strong> ${timestamp!"N/A"}</div>
                                    </div>
                                    <div class="col-md-6 mb-3">
                                        <div><strong>Chemin de Requête:</strong> <span id="requestPath">${requestPath!window.location.pathname}</span></div>
                                        <div><strong>User-Agent:</strong> <span id="userAgent"></span></div>
                                        <div><strong>Référent:</strong> <span id="referrer"></span></div>
                                        <div><strong>URL Complète:</strong> <span id="fullUrl"></span></div>
                                    </div>
                                </div>
                                
                                <#if stackTrace?? && stackTrace?has_content>
                                    <div class="mt-3">
                                        <strong>Stack Trace:</strong>
                                        <pre class="mt-2" style="background: #1a202c; padding: 1rem; border-radius: 5px; font-size: 0.8rem; overflow-x: auto;">${stackTrace}</pre>
                                    </div>
                                </#if>
                                
                                <div class="mt-3">
                                    <strong>Variables d'Environnement:</strong>
                                    <div id="environmentInfo" class="mt-2">
                                        <div><strong>Navigateur:</strong> <span id="browserInfo"></span></div>
                                        <div><strong>Plateforme:</strong> <span id="platformInfo"></span></div>
                                        <div><strong>Langue:</strong> <span id="languageInfo"></span></div>
                                        <div><strong>Résolution d'Écran:</strong> <span id="screenInfo"></span></div>
                                        <div><strong>Fuseau Horaire:</strong> <span id="timezoneInfo"></span></div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </#if>
                </div>
            </div>
        </div>
    </main>

    <footer class="bg-light py-3 mt-auto">
        <div class="container text-center">
            <small class="text-muted">
                Si le problème persiste, contactez notre équipe de support en mentionnant l'ID d'erreur : 
                <strong>${errorId!"N/A"}</strong>
            </small>
        </div>
    </footer>

    <script nonce="${nonce()}" src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
    <script nonce="${nonce()}">
        let countdownInterval;
        let countdownValue = 30;
        const countdownElement = document.getElementById('countdown');
        const autoRetrySection = document.getElementById('autoRetrySection');

        function initializeAutoRetry() {
            <#if canRetry?? && canRetry>
            if (countdownElement && autoRetrySection) {
                countdownInterval = setInterval(() => {
                    countdownValue--;
                    countdownElement.textContent = countdownValue;
                    
                    if (countdownValue <= 0) {
                        clearInterval(countdownInterval);
                        window.location.reload();
                    }
                }, 1000);
            }
            </#if>
        }

        function cancelAutoRetry() {
            if (countdownInterval) {
                clearInterval(countdownInterval);
                countdownInterval = null;
            }
            const autoRetrySection = document.getElementById('autoRetrySection');
            if (autoRetrySection) {
                autoRetrySection.style.display = 'none';
            }
        }

        function retryRequest() {
            const button = document.getElementById('retryBtn');
            if (button) {
                button.innerHTML = '<i class="bi bi-arrow-clockwise"></i> Chargement...';
                button.disabled = true;
            }
            
            cancelAutoRetry();
            
            setTimeout(() => {
                window.location.reload();
            }, 1000);
        }

        function goBack() {
            if (window.history.length > 1) {
                window.history.back();
            } else {
                window.location.href = '/';
            }
        }

        function toggleTechnicalDetails() {
            const details = document.getElementById('technicalDetails');
            const button = document.getElementById('technicalBtn');
            
            if (!details || !button) return;
            
            const isVisible = details.style.display !== 'none';
            details.style.display = isVisible ? 'none' : 'block';
            
            button.innerHTML = isVisible 
                ? '<i class="bi bi-code-slash me-2"></i>Afficher les Détails Techniques'
                : '<i class="bi bi-eye-slash me-2"></i>Masquer les Détails Techniques';
        }

        function populateTechnicalInfo() {
            const userAgentEl = document.getElementById('userAgent');
            if (userAgentEl) {
                userAgentEl.textContent = navigator.userAgent.substring(0, 100) + '...';
            }

            const referrerEl = document.getElementById('referrer');
            if (referrerEl) {
                referrerEl.textContent = document.referrer || 'Aucun';
            }

            const fullUrlEl = document.getElementById('fullUrl');
            if (fullUrlEl) {
                fullUrlEl.textContent = window.location.href;
            }

            const browserInfoEl = document.getElementById('browserInfo');
            if (browserInfoEl) {
                browserInfoEl.textContent = getBrowserInfo();
            }

            const platformInfoEl = document.getElementById('platformInfo');
            if (platformInfoEl) {
                platformInfoEl.textContent = navigator.platform;
            }

            const languageInfoEl = document.getElementById('languageInfo');
            if (languageInfoEl) {
                languageInfoEl.textContent = navigator.language;
            }

            const screenInfoEl = document.getElementById('screenInfo');
            if (screenInfoEl) {
                screenInfoEl.textContent = screen.width + 'x' + screen.height;
            }

            const timezoneInfoEl = document.getElementById('timezoneInfo');
            if (timezoneInfoEl) {
                timezoneInfoEl.textContent = Intl.DateTimeFormat().resolvedOptions().timeZone;
            }
        }

        function getBrowserInfo() {
            const ua = navigator.userAgent;
            if (ua.includes('Chrome')) return 'Chrome';
            if (ua.includes('Firefox')) return 'Firefox';
            if (ua.includes('Safari')) return 'Safari';
            if (ua.includes('Edge')) return 'Edge';
            if (ua.includes('Opera')) return 'Opera';
            return 'Inconnu';
        }

        document.addEventListener('click', () => {
            if (countdownInterval && event.target.id !== 'countdown') {
                cancelAutoRetry();
            }
        });

        document.addEventListener('DOMContentLoaded', () => {
            populateTechnicalInfo();
            initializeAutoRetry();
        });
    </script>
</body>
</html>