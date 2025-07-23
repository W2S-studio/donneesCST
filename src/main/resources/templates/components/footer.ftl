<link nonce="${nonce()}" rel="stylesheet" href="/style/shared/footer.css">

<footer>
    <div class="footer-content">
        <div class="container">
            <div class="footer-brand">
                <h5>
                    <i class="bi bi-database"></i>
                    DonnéesCST
                </h5>
                <p class="footer-description">
                    API REST gratuite et open-source pour les étudiants du Cégep de Sorel-Tracy
                </p>
                <p class="footer-location">
                    <i class="bi bi-geo-alt"></i>
                    Sorel-Tracy, Québec
                </p>
            </div>

            <div class="row">
                <div class="col-lg-8 col-md-7">
                    <div class="footer-links">
                        <h6 class="footer-section-title">Liens utiles</h6>
                        <div class="footer-nav">
                            <a href="https://github.com/votre-repo">
                                <i class="bi bi-github"></i> Code source
                            </a>
                            <a href="/docs">
                                <i class="bi bi-book"></i> Documentation
                            </a>
                            <a href="/about">
                                <i class="bi bi-info-circle"></i> À propos
                            </a>
                            <a href="/terms">
                                <i class="bi bi-file-earmark-text"></i> Conditions
                            </a>
                            <a href="/support">
                                <i class="bi bi-life-preserver"></i> Support
                            </a>
                            <a href="/api">
                                <i class="bi bi-cloud"></i> API
                            </a>
                        </div>
                    </div>
                </div>

                <div class="col-lg-4 col-md-5">
                    <div class="footer-institutional">
                        <h6 class="footer-section-title">Institution</h6>
                        <a href="https://www.cegepst.qc.ca" target="_blank" rel="noopener">
                            <i class="bi bi-building"></i>
                            Cégep de Sorel-Tracy
                        </a>
                    </div>
                </div>
            </div>

            <div class="footer-bottom">
                <div class="row align-items-center">
                    <div class="col-md-6">
                        <p class="footer-credits mb-md-0">
                            <i class="bi bi-code-slash"></i>
                            Développé avec <i class="bi bi-heart-fill text-danger"></i> par William Beaudin
                        </p>
                    </div>
                    <div class="col-md-6 text-md-end">
                        <p class="footer-copyright mb-0">
                            &copy; <span id="current-year"></span> DonnéesCST • Projet open-source
                        </p>
                    </div>
                </div>
            </div>
        </div>
    </div>
</footer>

<script nonce="${nonce()}">
    document.getElementById('current-year').textContent = new Date().getFullYear();
</script>
