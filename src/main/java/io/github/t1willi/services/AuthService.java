package io.github.t1willi.services;

import io.github.t1willi.brokers.UserBroker;
import io.github.t1willi.entities.User;
import io.github.t1willi.form.Form;
import io.github.t1willi.injector.annotation.Autowire;
import io.github.t1willi.injector.annotation.Bean;
import io.github.t1willi.interfaces.IAuthService;
import io.github.t1willi.interfaces.IAuthValidator;
import io.github.t1willi.security.cryptography.Cryptography;

import java.util.Optional;

@Bean
public class AuthService implements IAuthService {

    @Autowire
    private IAuthValidator authValidator;

    @Autowire
    private UserBroker userBroker;

    @Override
    public User authenticate(Form form) {
        if (!authValidator.validateAuthentication(form)) {
            return null;
        }

        String email = form.field("email").get();
        String password = form.field("password").get();
        Optional<User> user = userBroker.findByHashEmail(Cryptography.hmac(email));

        if (user.isPresent() && Cryptography.verify(user.get().getPassword(), password)) {
            return decrypt(user.get());
        }

        form.addError("email", "L'email ou le mot de passe est incorrect.");
        return null;
    }

    @Override
    public User register(Form form) {
        if (!authValidator.validateRegistration(form)) {
            return null;
        }

        String email = form.field("email").get();
        Optional<User> existingUser = userBroker.findByHashEmail(Cryptography.hmac(email));
        if (existingUser.isPresent()) {
            form.addError("email", "L'adresse email est déjà utilisée.");
            return null;
        }

        User userToCreate = User.of(
                form.field("username").get(),
                email,
                Cryptography.hmac(email),
                Cryptography.hash(form.field("password").get()),
                Boolean.parseBoolean(form.field("has_accepted_tos").get()));
        User encrypted = encrypt(userToCreate);
        userBroker.save(encrypted);
        return decrypt(encrypted);
    }

    @Override
    public boolean isEmailValidated(int userId) {
        return userBroker.isEmailValidated(userId);
    }

    @Override
    public boolean updateEmail(int userId, Form form) {
        if (!authValidator.validateEmailUpdate(form)) {
            return false;
        }

        Optional<User> user = userBroker.findById(userId);
        if (user.isPresent()) {
            String newEmail = form.field("email").get();
            user.get().setEmail(Cryptography.encrypt(newEmail));
            user.get().setHashEmail(Cryptography.hmac(newEmail));
            userBroker.save(user.get());
            return true;
        }

        form.addError("email", "Erreur lors de la mise à jour de l'email.");
        return false;
    }

    @Override
    public boolean updatePassword(int userId, Form form) {
        if (!authValidator.validatePasswordUpdate(form)) {
            return false;
        }

        Optional<User> user = userBroker.findById(userId);
        if (user.isPresent()) {
            String currentPassword = form.field("current_password").get();
            if (!Cryptography.verify(user.get().getPassword(), currentPassword)) {
                form.addError("current_password", "Le mot de passe actuel est incorrect.");
                return false;
            }

            user.get().setPassword(Cryptography.hash(form.field("new_password").get()));
            userBroker.save(user.get());
            return true;
        }

        form.addError("password", "Erreur lors de la mise à jour du mot de passe.");
        return false;
    }

    private User encrypt(User user) {
        return User.of(
                user.getId(),
                Cryptography.encrypt(user.getUsername()),
                Cryptography.encrypt(user.getEmail()),
                user.getHashEmail(),
                user.getPassword(),
                user.getCreatedAt());
    }

    private User decrypt(User user) {
        return User.of(
                user.getId(),
                Cryptography.decrypt(user.getUsername()),
                Cryptography.decrypt(user.getEmail()),
                user.getHashEmail(),
                user.getPassword(),
                user.getCreatedAt());
    }
}