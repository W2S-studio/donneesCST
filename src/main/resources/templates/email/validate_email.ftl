<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Validation d'email - Jolt Framework</title>
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
            background: linear-gradient(135deg, #4facfe, #00f2fe);
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
            background-color: #4facfe;
            color: white;
            text-decoration: none;
            border-radius: 5px;
            font-weight: bold;
            margin: 20px 0;
        }
        .cta-button:hover {
            background-color: #3a8bd8;
        }
        .expiry-notice {
            background-color: #fff3cd;
            border-left: 4px solid #ffc107;
            padding: 10px 15px;
            margin: 20px 0;
            border-radius: 0 5px 5px 0;
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
            <h1>Validation d'email</h1>
        </div>
        <div class="content">
            <h1>Bonjour ${userName},</h1>
            <p>Merci de vous être inscrit sur Jolt Framework ! Pour finaliser votre inscription, veuillez vérifier votre adresse email.</p>
            
            <p>Cliquez sur le bouton ci-dessous pour vérifier votre adresse email :</p>
            
            <a href="${verificationLink}" class="cta-button">Vérifier l'adresse email</a>
            
            <div class="expiry-notice">
                <strong>⚠️ Important :</strong> Ce lien de vérification expirera dans ${expiryHours} heures pour des raisons de sécurité.
            </div>
            
            <p>Si vous n'avez pas créé de compte chez nous, veuillez ignorer cet email.</p>
            
            <p>Si vous rencontrez des problèmes avec le bouton ci-dessus, copiez et collez le lien suivant dans votre navigateur :</p>
            <p style="word-break: break-all; color: #666;">${verificationLink}</p>
        </div>
        <div class="footer">
            <p>&copy; 2025 Jolt Framework. All rights reserved.</p>
            <p>Si vous avez des questions, veuillez contacter notre équipe de support.</p>
        </div>
    </div>
</body>
</html>