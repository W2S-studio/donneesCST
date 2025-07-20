<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Code de vérification - Jolt Framework</title>
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
            background: linear-gradient(135deg, #28a745, #20c997);
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
        .verification-code {
            background-color: #f8f9fa;
            border: 2px solid #28a745;
            border-radius: 8px;
            padding: 20px;
            margin: 20px 0;
            text-align: center;
        }
        .code-display {
            font-size: 32px;
            font-weight: bold;
            letter-spacing: 8px;
            color: #28a745;
            font-family: 'Courier New', monospace;
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
        .login-info {
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
            <h1>🔐 Code de vérification</h1>
        </div>
        <div class="content">
            <h1>Bonjour ${userName},</h1>
            <p>Nous avons détecté une tentative de connexion à votre compte Jolt Framework.</p>
            
            <div class="login-info">
                <strong>Détails de la connexion :</strong><br>
                Heure de la tentative : ${loginTime}<br>
                Adresse IP : ${ipAddress}<br>
                Navigateur : ${userAgent}
            </div>
            
            <p>Pour des raisons de sécurité, veuillez utiliser le code de vérification ci-dessous pour finaliser votre connexion :</p>
            
            <div class="verification-code">
                <p style="margin: 0; font-size: 16px; color: #666;">Votre code de vérification :</p>
                <div class="code-display">${verificationCode}</div>
            </div>
            
            <div class="expiry-notice">
                <strong>⏰ Temps limité :</strong> Ce code de vérification expirera dans ${expiryMinutes} minutes.
            </div>
            
            <div class="security-notice">
                <strong>🛡️ Avis de sécurité :</strong> Si vous n'avez pas tenté de vous connecter, veuillez ignorer cet email et considérez changer votre mot de passe immédiatement. Ne partagez jamais ce code avec personne.
            </div>
            
            <p>Saisissez ce code dans la page de connexion pour accéder à votre compte. Ce code est à usage unique et ne peut être utilisé qu'une seule fois.</p>
            
            <p>Si vous rencontrez des problèmes, veuillez contacter notre équipe de support.</p>
        </div>
        <div class="footer">
            <p>&copy; 2025 Jolt Framework. All rights reserved.</p>
            <p>Si vous avez des préoccupations de sécurité, veuillez contacter notre équipe de support immédiatement.</p>
        </div>
    </div>
</body>
</html>