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

@Bean
public class UserService {

    private final UserBroker userBroker = new UserBroker();
    private final ApiKeysBroker apiKeysBroker = new ApiKeysBroker();

    public User authenticate(Form form) {
        String username = form.field("username").get();
        String password = form.field("password").get();

        return userBroker.authenticate(username, password)
                .orElseThrow(() -> new IllegalArgumentException("Invalid credentials"));
    }

    public User register(Form form) {
        String username = form.field("username").get();
        String password = form.field("password").get();

        if (userBroker.usernameExists(username)) {
            throw new IllegalArgumentException("Username already exists");
        }

        String hashedPassword = Cryptography.hash(password);
        return userBroker.createUser(username, hashedPassword);
    }

    public void updatePassword(int userId, Form form) {
        String oldPassword = form.field("oldPassword").get();
        String newPassword = form.field("newPassword").get();

        User user = getUserById(userId);

        if (!Cryptography.verify(user.getPassword(), oldPassword)) {
            throw new IllegalArgumentException("Current password is incorrect");
        }

        if (Cryptography.verify(user.getPassword(), newPassword)) {
            throw new IllegalArgumentException("New password cannot be the same as current password");
        }

        userBroker.updatePassword(userId, newPassword);
    }

    public ApiKeys createApiKey(int userId, String expirationDate) {
        String key = CryptographyUtils.randomHex(32);
        LocalDateTime expiration = parseExpirationDate(expirationDate);

        return apiKeysBroker.createApiKey(userId, key, expiration);
    }

    public boolean verifyPassword(int userId, String password) {
        Optional<User> userOpt = userBroker.findById(userId);
        return userOpt.map(user -> Cryptography.verify(user.getPassword(), password))
                .orElse(false);
    }

    public List<ApiKeys> getUserKeys(int userId) {
        return apiKeysBroker.findByUserId(userId);
    }

    public void deleteApiKey(int keyId) {
        apiKeysBroker.deleteById(keyId);
    }

    private User getUserById(int userId) {
        return userBroker.findById(userId)
                .orElseThrow(() -> new IllegalArgumentException("User not found"));
    }

    private LocalDateTime parseExpirationDate(String expirationDate) {
        if (expirationDate == null || expirationDate.isEmpty()) {
            return null;
        }

        try {
            LocalDate date = LocalDate.parse(expirationDate);
            if (date.isBefore(LocalDate.now())) {
                throw new IllegalArgumentException("Expiration date must be in the future");
            }
            return date.atStartOfDay();
        } catch (Exception e) {
            throw new IllegalArgumentException("Invalid date format");
        }
    }
}