<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Réinitialisation de mot de passe - Jolt Framework</title>
    <style>
        body {
            font-family: 'Arial', sans-serif;
            background-color: #f4f4f4;
            margin: 0;
            padding: 0;
        }
        .container {
            max-width: 600px;
            margin: 50px auto;
            background-color: #ffffff;
            border-radius: 10px;
            overflow: hidden;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        }
        .header {
            background: linear-gradient(135deg, #ff6b6b, #ee5a52);
            color: white;
            text-align: center;
            padding: 20px;
        }
        .content {
            padding: 30px;
            color: #333;
        }
        .content h1 {
            font-size: 24px;
            margin-top: 0;
        }
        .content p {
            line-height: 1.6;
            font-size: 16px;
        }
        .cta-button {
            display: inline-block;
            padding: 12px 25px;
            background-color: #ff6b6b;
            color: white;
            text-decoration: none;
            border-radius: 5px;
            font-weight: bold;
            margin: 20px 0;
        }
        .cta-button:hover {
            background-color: #ee5a52;
        }
        .security-notice {
            background-color: #f8d7da;
            border-left: 4px solid #dc3545;
            padding: 15px;
            margin: 20px 0;
            border-radius: 0 5px 5px 0;
        }
        .expiry-notice {
            background-color: #fff3cd;
            border-left: 4px solid #ffc107;
            padding: 10px 15px;
            margin: 20px 0;
            border-radius: 0 5px 5px 0;
        }
        .reset-info {
            background-color: #e7f3ff;
            border-radius: 5px;
            padding: 15px;
            margin: 20px 0;
        }
        .footer {
            text-align: center;
            padding: 20px;
            font-size: 12px;
            color: #777;
            background-color: #f8f8f8;
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="header">
            <h1>🔒 Réinitialisation de mot de passe</h1>
        </div>
        <div class="content">
            <h1>Bonjour ${userName},</h1>
            <p>Nous avons reçu une demande de réinitialisation du mot de passe pour votre compte Jolt Framework.</p>
            
            <div class="reset-info">
                <strong>Détails de la demande :</strong><br>
                Heure de la demande : ${requestTime}<br>
                Adresse IP : ${ipAddress}<br>
                Navigateur : ${userAgent}
            </div>
            
            <p>Si vous avez fait cette demande, cliquez sur le bouton ci-dessous pour réinitialiser votre mot de passe :</p>
            
            <a href="${resetLink}" class="cta-button">Réinitialiser le mot de passe</a>
            
            <div class="expiry-notice">
                <strong>⏰ Temps limité :</strong> Ce lien de réinitialisation expirera dans ${expiryMinutes} minutes pour des raisons de sécurité.
            </div>
            
            <div class="security-notice">
                <strong>🛡️ Avis de sécurité :</strong> Si vous n'avez pas demandé cette réinitialisation de mot de passe, veuillez ignorer cet email. Votre mot de passe restera inchangé. Considérez activer l'authentification à deux facteurs pour une meilleure sécurité.
            </div>
            
            <p>Si vous rencontrez des problèmes avec le bouton ci-dessus, copiez et collez le lien suivant dans votre navigateur :</p>
            <p style="word-break: break-all; color: #666;">${resetLink}</p>
            
            <p>Pour des raisons de sécurité, ce lien ne peut être utilisé qu'une seule fois. Si vous devez réinitialiser votre mot de passe à nouveau, veuillez demander un nouveau lien de réinitialisation.</p>
        </div>
        <div class="footer">
            <p>&copy; 2025 Jolt Framework. All rights reserved.</p>
            <p>Si vous avez des préoccupations de sécurité, veuillez contacter notre équipe de support immédiatement.</p>
        </div>
    </div>
</body>
</html>