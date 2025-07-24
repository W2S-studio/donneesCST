package io.github.t1willi.services;

import io.github.t1willi.brokers.UserBroker;
import io.github.t1willi.brokers.UserPasswordResetBroker;
import io.github.t1willi.context.JoltContext;
import io.github.t1willi.entities.User;
import io.github.t1willi.entities.UserPasswordReset;
import io.github.t1willi.exception.SharedException;
import io.github.t1willi.exception.SharedException.InvalidTokenException;
import io.github.t1willi.exception.SharedException.MissingTokenException;
import io.github.t1willi.exception.SharedException.UserNotFoundException;
import io.github.t1willi.form.Form;
import io.github.t1willi.injector.annotation.Autowire;
import io.github.t1willi.injector.annotation.Bean;
import io.github.t1willi.interfaces.IEmailService;
import io.github.t1willi.interfaces.IPasswordResetService;
import io.github.t1willi.interfaces.IPasswordResetValidator;
import io.github.t1willi.security.cryptography.Cryptography;
import io.github.t1willi.utils.Helper;

import javax.mail.MessagingException;
import freemarker.template.TemplateException;
import java.time.LocalDateTime;
import java.util.Optional;
import java.util.UUID;

@Bean
public class PasswordResetService implements IPasswordResetService {

    @Autowire
    private UserBroker userBroker;

    @Autowire
    private UserPasswordResetBroker passwordResetBroker;

    @Autowire
    private IEmailService emailService;

    @Autowire
    private IPasswordResetValidator passwordResetValidator;

    @Override
    public boolean sendPasswordResetEmail(Form form, JoltContext context) throws SharedException {
        if (!passwordResetValidator.validatePasswordResetRequest(form)) {
            return false;
        }

        System.out.println("Processing password reset request for email: " + form.field("email").get());

        String email = form.field("email").get();
        Optional<User> userOpt = userBroker.findByHashEmail(Cryptography.hmac(email));

        if (!userOpt.isPresent()) {
            form.addError("email", "Aucun utilisateur trouvé avec cette adresse email.");
            return false;
        }

        User user = userOpt.get();
        String token = generateResetToken();
        passwordResetBroker.save(UserPasswordReset.of(user.getId(), token));

        System.out.println("Generated reset token for user ID " + user.getId() + ": " + token);

        return sendResetEmail(user, token, context);
    }

    @Override
    public boolean resetPassword(Form form) throws SharedException {
        String token = form.field("token").get();
        if (token == null || token.isEmpty()) {
            throw new MissingTokenException();
        }

        Optional<UserPasswordReset> resetOpt = passwordResetBroker.findByToken(token);
        if (!resetOpt.isPresent() || isTokenExpired(resetOpt.get())) {
            throw new InvalidTokenException();
        }

        int userId = resetOpt.get().getId();
        Optional<User> userOpt = userBroker.findById(userId);

        if (!userOpt.isPresent()) {
            throw new UserNotFoundException();
        }

        if (!passwordResetValidator.validatePasswordReset(form, userOpt.get().getPassword())) {
            return false;
        }

        updateUserPassword(userOpt.get(), form.field("password").get());
        cleanupResetToken(userId);

        return true;
    }

    @Override
    public void validateResetToken(String token) throws SharedException {
        if (token == null || token.isEmpty()) {
            throw new MissingTokenException();
        }

        Optional<UserPasswordReset> resetOpt = passwordResetBroker.findByToken(token);
        if (!resetOpt.isPresent() || isTokenExpired(resetOpt.get())) {
            throw new InvalidTokenException();
        }
    }

    private boolean sendResetEmail(User user, String token, JoltContext context) throws SharedException {
        try {
            String resetLink = buildResetLink(context, token);
            emailService.sendPasswordReset(
                    Cryptography.decrypt(user.getEmail()),
                    Cryptography.decrypt(user.getUsername()),
                    resetLink,
                    context.clientIp(),
                    context.userAgent(),
                    30);
            return true;
        } catch (MessagingException | TemplateException e) {
            throw new SharedException("Impossible d'envoyer l'email de réinitialisation. " + e.getMessage());
        }
    }

    private void updateUserPassword(User user, String newPassword) {
        user.setPassword(Cryptography.hash(newPassword));
        userBroker.save(user);
    }

    private void cleanupResetToken(int userId) {
        passwordResetBroker.deleteById(userId);
    }

    private boolean isTokenExpired(UserPasswordReset reset) {
        return reset.getPasswordResetTokenExpiration().isBefore(LocalDateTime.now());
    }

    private String generateResetToken() {
        return UUID.randomUUID().toString();
    }

    private String buildResetLink(JoltContext context, String token) {
        return Helper.getDomain(context) + "/reset-password?token=" + token;
    }
}