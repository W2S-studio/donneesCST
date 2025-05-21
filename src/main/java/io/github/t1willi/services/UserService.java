package io.github.t1willi.services;

import io.github.t1willi.brokers.ApiKeysBroker;
import io.github.t1willi.brokers.UserBroker;
import io.github.t1willi.entities.ApiKeys;
import io.github.t1willi.entities.User;
import io.github.t1willi.form.Form;
import io.github.t1willi.injector.annotation.Bean;
import io.github.t1willi.security.cryptography.Cryptography;
import io.github.t1willi.security.cryptography.CryptographyUtils;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.List;
import java.util.Optional;
import java.util.regex.Pattern;

@Bean
public class UserService {

    private final UserBroker userBroker = new UserBroker();
    private final ApiKeysBroker apiKeysBroker = new ApiKeysBroker();

    // Password validation regex: 8+ chars, 1 upper, 1 lower, 1 number, 1 special
    private static final Pattern PASSWORD_PATTERN = Pattern.compile(
            "^(?=.*[A-Z])(?=.*[a-z])(?=.*\\d)(?=.*[!@#$%^&*])[A-Za-z\\d!@#$%^&*]{8,}$");

    public Optional<User> login(Form form) {
        String username = form.field("username").get();
        String password = form.field("password").get();
        System.out.println("username = " + username);
        System.out.println("password = " + password);
        Optional<User> userOpt = userBroker.authenticate(username, password);
        if (userOpt.isEmpty()) {
            form.addError("username", "Nom d'utilisateur ou mot de passe incorrect");
            form.addError("password", "Nom d'utilisateur ou mot de passe incorrect");
        }
        if (!form.validate()) {
            throw new IllegalArgumentException(String.join("; ", form.errors().values()));
        }
        return userOpt;
    }

    public User register(Form form) {
        String username = form.field("username").get();
        String password = form.field("password").get();
        String passwordConfirm = form.field("passwordConfirm").get();

        if (userBroker.usernameExists(username)) {
            form.addError("username", "Ce nom d'utilisateur est déjà pris");
        }
        if (!password.equals(passwordConfirm)) {
            form.addError("password", "Les mots de passe ne correspondent pas");
            form.addError("passwordConfirm", "Les mots de passe ne correspondent pas");
        }
        if (!PASSWORD_PATTERN.matcher(password).matches()) {
            form.addError("password",
                    "Le mot de passe doit contenir au moins 8 caractères, 1 majuscule, 1 minuscule, 1 chiffre, 1 caractère spécial (!@#$%^&*)");
        }
        if (!form.validate()) {
            throw new IllegalArgumentException(String.join("; ", form.errors().values()));
        }

        String hashedPassword = Cryptography.hash(password);
        return userBroker.createUser(username, hashedPassword);
    }

    public void updatePassword(Form form) {
        int userId = form.field("userId").asInt();
        String oldPassword = form.field("oldPassword").get();
        String newPassword = form.field("newPassword").get();
        String newPasswordConfirm = form.field("newPasswordConfirm").get();

        Optional<User> userOpt = userBroker.findById(userId);
        if (userOpt.isEmpty()) {
            form.addError("userId", "Utilisateur non trouvé");
        } else {
            User user = userOpt.get();
            if (Cryptography.verify(user.getPassword(), oldPassword)) {
                form.addError("oldPassword", "L'ancien mot de passe est incorrect");
            }
            if (Cryptography.verify(user.getPassword(), newPassword)) {
                form.addError("newPassword", "Le nouveau mot de passe ne peut pas être le même que l'ancien");
            }
        }
        if (!newPassword.equals(newPasswordConfirm)) {
            form.addError("newPassword", "Les nouveaux mots de passe ne correspondent pas");
            form.addError("newPasswordConfirm", "Les nouveaux mots de passe ne correspondent pas");
        }
        if (!PASSWORD_PATTERN.matcher(newPassword).matches()) {
            form.addError("newPassword",
                    "Le nouveau mot de passe doit contenir au moins 8 caractères, 1 majuscule, 1 minuscule, 1 chiffre, 1 caractère spécial (!@#$%^&*)");
        }
        if (!form.validate()) {
            throw new IllegalArgumentException(String.join("; ", form.errors().values()));
        }

        userBroker.updatePassword(userId, newPassword);
    }

    public ApiKeys createApiKey(int userId, String expirationDate, Form form) {
        String key = CryptographyUtils.randomHex(32);
        LocalDateTime expiration = null;
        if (expirationDate != null && !expirationDate.isEmpty()) {
            try {
                LocalDate date = LocalDate.parse(expirationDate);
                if (date.isBefore(LocalDate.now())) {
                    form.addError("key_expiration", "La date d'expiration doit être dans le futur");
                } else {
                    expiration = date.atStartOfDay();
                }
            } catch (Exception e) {
                form.addError("key_expiration", "Format de date invalide");
            }
        }
        if (!form.validate()) {
            throw new IllegalArgumentException(String.join("; ", form.errors().values()));
        }
        return apiKeysBroker.createApiKey(userId, key, expiration);
    }

    public boolean verifyPassword(int userId, String password) {
        Optional<User> userOpt = userBroker.findById(userId);
        if (userOpt.isEmpty()) {
            System.out.println("User not found with ID: " + userId);
            return false;
        }
        User user = userOpt.get();
        System.out.println("User = " + user);
        return Cryptography.verify(user.getPassword(), password);
    }

    public List<ApiKeys> getUserKeys(int userId) {
        return apiKeysBroker.findByUserId(userId);
    }

    public void deleteKey(int keyId) {
        apiKeysBroker.deleteById(keyId);
    }
}