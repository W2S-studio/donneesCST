document.addEventListener('DOMContentLoaded', function () {
    const mfaMethod = document.getElementById('mfaMethod');
    const appConfig = document.getElementById('appMfaConfig');
    const enableGracePeriod = document.getElementById('enableGracePeriod');
    const gracePeriodSettings = document.getElementById('gracePeriodSettings');

    updateMfaConfigVisibility(mfaMethod.value);
    updateGracePeriodVisibility(enableGracePeriod.checked);
    generateQRCode();
    initChart();

    // Form submissions
    document.getElementById('changePasswordForm').addEventListener('submit', function (e) {
        e.preventDefault();
        const formData = new FormData(this);
        updateAccountSetting('/api/update-password', formData, 'Mot de passe mis à jour avec succès!');
    });

    document.getElementById('changeEmailForm').addEventListener('submit', function (e) {
        e.preventDefault();
        const formData = new FormData(this);
        updateAccountSetting('/api/update-email', formData, 'Email mis à jour avec succès!');
    });

    document.getElementById('mfaForm').addEventListener('submit', function (e) {
        e.preventDefault();
        const formData = new FormData(this);
        updateAccountSetting('/api/update-mfa', formData, 'MFA mis à jour avec succès!');
    });

    document.getElementById('createKeyForm').addEventListener('submit', function (e) {
        e.preventDefault();
        const formData = new FormData(this);
        createNewKey(formData);
    });

    // Reveal keys
    document.getElementById('revealKeysBtn').addEventListener('click', function () {
        const modal = new bootstrap.Modal(document.getElementById('passwordModal'));
        modal.show();
    });

    document.getElementById('confirmReveal').addEventListener('click', function () {
        const password = document.getElementById('passwordInput').value;
        if (password === 'securepassword') {
            revealKeys();
            bootstrap.Modal.getInstance(document.getElementById('passwordModal')).hide();
        } else {
            alert('Mot de passe incorrect. Veuillez réessayer.');
        }
    });

    document.getElementById('maskKeysBtn').addEventListener('click', maskKeys);

    // Delete key
    document.querySelectorAll('.delete-key').forEach(button => {
        button.addEventListener('click', function () {
            const keyId = this.getAttribute('data-key-id');
            if (confirm('Êtes-vous sûr de vouloir supprimer cette clé API ?')) {
                deleteKey(keyId);
            }
        });
    });
});

function updateMfaConfigVisibility(method) {
    const appConfig = document.getElementById('appMfaConfig');
    appConfig.classList.toggle('app-mfa-config-visible', method === 'app');
    appConfig.classList.toggle('app-mfa-config-hidden', method !== 'app');
}

function updateGracePeriodVisibility(isEnabled) {
    const gracePeriodSettings = document.getElementById('gracePeriodSettings');
    gracePeriodSettings.classList.toggle('app-mfa-config-visible', isEnabled);
    gracePeriodSettings.classList.toggle('app-mfa-config-hidden', !isEnabled);
}

document.getElementById('mfaMethod').addEventListener('change', function () {
    updateMfaConfigVisibility(this.value);
});

document.getElementById('enableGracePeriod').addEventListener('change', function () {
    updateGracePeriodVisibility(this.checked);
});

function revealKeys() {
    const keyValues = document.querySelectorAll('.api-key-value');
    keyValues.forEach(key => key.classList.remove('masked'));
    document.getElementById('revealKeysBtn').classList.add('reveal-keys-hidden');
    document.getElementById('revealKeysBtn').classList.remove('reveal-keys-visible');
    document.getElementById('maskKeysBtn').classList.add('reveal-keys-visible');
    document.getElementById('maskKeysBtn').classList.remove('reveal-keys-hidden');
}

function maskKeys() {
    const keyValues = document.querySelectorAll('.api-key-value');
    keyValues.forEach(key => key.classList.add('masked'));
    document.getElementById('revealKeysBtn').classList.add('reveal-keys-visible');
    document.getElementById('revealKeysBtn').classList.remove('reveal-keys-hidden');
    document.getElementById('maskKeysBtn').classList.add('reveal-keys-hidden');
    document.getElementById('maskKeysBtn').classList.remove('reveal-keys-visible');
}

function generateQRCode() {
    const canvas = document.getElementById('qrCanvas');
    if (canvas) {
        const ctx = canvas.getContext('2d');
        ctx.canvas.width = 200;
        ctx.canvas.height = 200;
        ctx.fillStyle = '#000';
        for (let i = 0; i < 20; i++) {
            for (let j = 0; j < 20; j++) {
                if ((i + j) % 3 === 0 || (i * j) % 7 === 0) {
                    ctx.fillRect(i * 10, j * 10, 10, 10);
                }
            }
        }
    }
}

function initChart() {
    const ctx = document.getElementById('monthlyUsageChart');
    if (ctx && typeof Chart !== 'undefined') {
        new Chart(ctx, {
            type: 'line',
            data: {
                labels: ['Jan', 'Fév', 'Mar', 'Avr', 'Mai', 'Juin', 'Juil'],
                datasets: [{
                    label: 'Utilisation mensuelle',
                    data: [1200, 1456, 1847, 1623, 1789, 1934, 1847],
                    borderColor: 'var(--cegep-primary)',
                    backgroundColor: 'rgba(43, 95, 107, 0.1)',
                    tension: 0.4
                }]
            },
            options: {
                responsive: true,
                maintainAspectRatio: false,
                plugins: { legend: { display: false } },
                scales: { y: { beginAtZero: true, max: 2500 } }
            }
        });
    }
}

function updateAccountSetting(url, formData, successMessage) {
    fetch(url, {
        method: 'POST',
        body: formData
    })
        .then(response => response.json())
        .then(data => {
            if (data.success) alert(successMessage);
            else alert('Erreur : ' + data.message);
        })
        .catch(error => alert('Une erreur est survenue : ' + error));
}

function createNewKey(formData) {
    fetch('/api/create-key', {
        method: 'POST',
        body: formData
    })
        .then(response => response.json())
        .then(data => {
            if (data.success) {
                alert('Clé créée avec succès : ' + data.key);
                bootstrap.Modal.getInstance(document.getElementById('createKeyModal')).hide();
                // Add new key to list (simulated)
                addNewKeyToList(data.key, data.keyId, '20/07/2025', 0);
            } else {
                alert('Erreur : ' + data.message);
            }
        })
        .catch(error => alert('Une erreur est survenue : ' + error));
}

function addNewKeyToList(keyValue, keyId, createdDate, usage) {
    const apiKeysList = document.getElementById('apiKeysList');
    const newKeyCard = document.createElement('div');
    newKeyCard.className = 'card mb-3';
    newKeyCard.innerHTML = `
                <div class="card-body">
                    <div class="d-flex justify-content-between align-items-start mb-2">
                        <h6 class="card-title mb-1">Clé API #${keyId}</h6>
                        <button class="btn btn-outline-danger btn-sm delete-key" data-key-id="${keyId}">
                            <i class="bi bi-trash"></i>
                        </button>
                    </div>
                    <div class="api-key-value bg-dark text-light p-2 rounded mb-2 masked" data-key-id="${keyId}">
                        ${keyValue}
                    </div>
                    <div class="row small text-muted">
                        <div class="col-4"><strong>Créée le:</strong><br>${createdDate}</div>
                        <div class="col-4"><strong>Dernière utilisation:</strong><br>${createdDate}</div>
                        <div class="col-4"><strong>Utilisations:</strong><br><span class="fw-bold text-primary">${usage}</span></div>
                    </div>
                </div>
            `;
    apiKeysList.appendChild(newKeyCard);
    document.querySelector(`.delete-key[data-key-id="${keyId}"]`).addEventListener('click', function () {
        if (confirm('Êtes-vous sûr de vouloir supprimer cette clé API ?')) {
            deleteKey(keyId);
        }
    });
}

function deleteKey(keyId) {
    fetch(`/api/delete-key/${keyId}`, { method: 'DELETE' })
        .then(response => response.json())
        .then(data => {
            if (data.success) {
                document.querySelector(`.card .api-key-value[data-key-id="${keyId}"]`).closest('.card').remove();
                alert('Clé supprimée avec succès.');
            } else {
                alert('Erreur : ' + data.message);
            }
        })
        .catch(error => alert('Une erreur est survenue : ' + error));
}