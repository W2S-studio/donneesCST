package io.github.t1willi.services;

import io.github.t1willi.brokers.UserBroker;
import io.github.t1willi.brokers.UserEmailValidationBroker;
import io.github.t1willi.context.JoltContext;
import io.github.t1willi.entities.User;
import io.github.t1willi.entities.UserEmailValidation;
import io.github.t1willi.exception.SharedException;
import io.github.t1willi.exception.SharedException.EmailAlreadyValidatedException;
import io.github.t1willi.exception.SharedException.ExpiredTokenException;
import io.github.t1willi.exception.SharedException.InvalidTokenException;
import io.github.t1willi.exception.SharedException.MissingTokenException;
import io.github.t1willi.exception.SharedException.UserNotFoundException;
import io.github.t1willi.exception.SharedException.UserSessionExpiredException;
import io.github.t1willi.exception.SharedException.ValidationTokenStillValidException;
import io.github.t1willi.form.Form;
import io.github.t1willi.injector.annotation.Autowire;
import io.github.t1willi.injector.annotation.Bean;
import io.github.t1willi.interfaces.IEmailService;
import io.github.t1willi.interfaces.IEmailVerificationService;
import io.github.t1willi.interfaces.IEmailVerificationValidator;
import io.github.t1willi.interfaces.ISessionService;
import io.github.t1willi.security.cryptography.Cryptography;
import io.github.t1willi.utils.Helper;

import javax.mail.MessagingException;
import freemarker.template.TemplateException;
import java.time.LocalDateTime;
import java.util.Optional;
import java.util.UUID;

@Bean
public class EmailVerificationService implements IEmailVerificationService {

    @Autowire
    private UserBroker userBroker;

    @Autowire
    private UserEmailValidationBroker userEmailValidationBroker;

    @Autowire
    private IEmailService emailService;

    @Autowire
    private ISessionService sessionService;

    @Autowire
    private IEmailVerificationValidator emailVerificationValidator;

    @Override
    public boolean sendVerificationEmail(User user, JoltContext context) {
        try {
            String token = generateVerificationToken();
            UserEmailValidation validation = UserEmailValidation.of(user.getId(), token);
            userEmailValidationBroker.save(validation);

            String verificationLink = buildVerificationLink(context, token);
            emailService.sendEmailVerification(user.getEmail(), user.getUsername(), verificationLink, 24);
            return true;
        } catch (MessagingException | TemplateException e) {
            return false;
        }
    }

    @Override
    public boolean resendVerificationEmail(Form form, JoltContext context) throws SharedException {
        User user = resolveUserForResend(form);

        validateUserEmailStatus(user.getId());
        validateExistingToken(user.getId());

        return sendVerificationEmail(user, context);
    }

    @Override
    public void verifyEmail(String token) throws SharedException {
        if (token == null || token.isEmpty()) {
            throw new MissingTokenException();
        }

        Optional<UserEmailValidation> validation = userEmailValidationBroker.findByToken(token);
        if (!validation.isPresent()) {
            throw new InvalidTokenException();
        }

        UserEmailValidation emailValidation = validation.get();
        if (emailValidation.getEmailValidationTokenExpiration().isBefore(LocalDateTime.now())) {
            throw new ExpiredTokenException();
        }

        Optional<User> user = userBroker.findById(emailValidation.getId());
        if (!user.isPresent()) {
            throw new UserNotFoundException();
        }

        markEmailAsValidated(user.get(), emailValidation.getId());
    }

    private User resolveUserForResend(Form form) throws SharedException {
        String userId = sessionService.getCurrentUserId();

        if (userId != null) {
            return getUserFromSession(userId);
        } else {
            return getUserFromForm(form);
        }
    }

    private User getUserFromSession(String userId) throws SharedException {
        Optional<User> user = userBroker.findById(Integer.parseInt(userId));
        if (!user.isPresent()) {
            throw new UserSessionExpiredException();
        }
        return user.get();
    }

    private User getUserFromForm(Form form) throws SharedException {
        if (!emailVerificationValidator.validateEmailResendRequest(form)) {
            throw new InvalidTokenException();
        }

        String email = form.field("email").get();
        Optional<User> user = userBroker.findByHashEmail(Cryptography.hmac(email));

        if (!user.isPresent()) {
            form.addError("email", "Aucun utilisateur trouvé avec cette adresse email.");
            throw new InvalidTokenException();
        }

        return user.get();
    }

    private void validateUserEmailStatus(int userId) throws SharedException {
        if (userBroker.isEmailValidated(userId)) {
            throw new EmailAlreadyValidatedException();
        }
    }

    private void validateExistingToken(int userId) throws SharedException {
        Optional<UserEmailValidation> existingValidation = userEmailValidationBroker.findById(userId);

        if (existingValidation.isPresent() &&
                !existingValidation.get().getEmailValidationTokenExpiration().isBefore(LocalDateTime.now())) {
            throw new ValidationTokenStillValidException();
        }
    }

    private void markEmailAsValidated(User user, int validationId) {
        user.setEmailValidate(true);
        userBroker.save(user);
        userEmailValidationBroker.deleteById(validationId);
    }

    private String generateVerificationToken() {
        return UUID.randomUUID().toString();
    }

    private String buildVerificationLink(JoltContext context, String token) {
        return Helper.getDomain(context) + "/auth/verify-email?token=" + token;
    }
}