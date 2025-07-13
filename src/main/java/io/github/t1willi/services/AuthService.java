package io.github.t1willi.services;

import java.util.Optional;

import io.github.t1willi.brokers.UserBroker;
import io.github.t1willi.entities.User;
import io.github.t1willi.form.Form;
import io.github.t1willi.injector.annotation.Autowire;
import io.github.t1willi.injector.annotation.Bean;
import io.github.t1willi.interfaces.IAuthService;
import io.github.t1willi.interfaces.IAuthValidator;
import io.github.t1willi.security.cryptography.Cryptography;

@Bean
public class AuthService implements IAuthService {

    @Autowire
    private IAuthValidator _authValidator;

    @Override
    public User authenticate(Form form) {
        // Validate the form
        if (!_authValidator.validateAuthentication(form)) {
            return null;
        }

        // Authenticate the user
        Optional<User> user = new UserBroker().findByEmail(Cryptography.encrypt(form.field("email").get()));

        if (user.isPresent()) {
            if (Cryptography.verify(user.get().getPassword(), form.field("password").get())) {
                return decrypt(user.get());
            }
        }
        form.addError("email", "Le email ou le mot de passe est incorrect");
        return null;
    }

    @Override
    public User register(Form form) {
        // Validate the form
        if (!_authValidator.validateRegistration(form)) {
            return null;
        }

        // Verify if the email is already used
        Optional<User> user = new UserBroker().findByEmail(Cryptography.encrypt(form.field("email").get()));
        if (user.isPresent()) {
            form.addError("email", "L'adresse email est déjà utilisée");
            return null;
        }

        // Create a new user
        User userToCreate = User.of(form.field("username").get(), form.field("email").get(),
                Cryptography.hash(form.field("password").get()));
        new UserBroker().save(encrypt(userToCreate));
        return decrypt(userToCreate);

    }

    @Override
    public boolean updateEmail(int userId, Form form) {
        // Validate the form
        if (!_authValidator.validateEmailUpdate(form)) {
            return false;
        }

        // Find the user
        Optional<User> user = new UserBroker().findById(userId);
        if (user.isPresent()) {
            user.get().setEmail(Cryptography.encrypt(form.field("email").get()));
            new UserBroker().save(user.get());
            return true;
        }

        form.addError("email", "Il y a eu une erreur lors de la mise à jour de l'email.");
    }

    @Override
    public boolean updatePassword(int userId, Form form) {
        // Validate the form
        if (!_authValidator.validatePasswordUpdate(form)) {
            return false;
        }

    }

    private User encrypt(User user) {
        return new User(
                user.getId(),
                Cryptography.encrypt(user.getUsername()),
                Cryptography.encrypt(user.getEmail()),
                user.getPassword(),
                user.getCreatedAt());
    }

    private User decrypt(User user) {
        return new User(
                user.getId(),
                Cryptography.decrypt(user.getUsername()),
                Cryptography.decrypt(user.getEmail()),
                user.getPassword(),
                user.getCreatedAt());
    }
}
