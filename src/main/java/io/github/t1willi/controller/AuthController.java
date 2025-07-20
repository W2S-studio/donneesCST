package io.github.t1willi.controller;

import io.github.t1willi.annotations.Controller;
import io.github.t1willi.annotations.Get;
import io.github.t1willi.annotations.Post;
import io.github.t1willi.annotations.Query;
import io.github.t1willi.annotations.ToForm;
import io.github.t1willi.core.MvcController;
import io.github.t1willi.entities.User;
import io.github.t1willi.exception.SharedException;
import io.github.t1willi.exception.SharedException.EmailAlreadyValidatedException;
import io.github.t1willi.exception.SharedException.ExpiredTokenException;
import io.github.t1willi.exception.SharedException.InvalidTokenException;
import io.github.t1willi.exception.SharedException.MissingTokenException;
import io.github.t1willi.exception.SharedException.UserNotFoundException;
import io.github.t1willi.exception.SharedException.UserSessionExpiredException;
import io.github.t1willi.exception.SharedException.ValidationTokenStillValidException;
import io.github.t1willi.form.Form;
import io.github.t1willi.http.ResponseEntity;
import io.github.t1willi.injector.annotation.Autowire;
import io.github.t1willi.interfaces.IAuthService;
import io.github.t1willi.interfaces.IEmailVerificationService;
import io.github.t1willi.interfaces.IPasswordResetService;
import io.github.t1willi.interfaces.ISessionService;
import io.github.t1willi.template.JoltModel;
import io.github.t1willi.utils.Flash;

@Controller("/auth")
public class AuthController extends MvcController {

    @Autowire
    private IAuthService authService;

    @Autowire
    private IEmailVerificationService emailVerificationService;

    @Autowire
    private IPasswordResetService passwordResetService;

    @Autowire
    private ISessionService sessionService;

    @Post("/login")
    public ResponseEntity<?> login(@ToForm Form form) {
        User user = authService.authenticate(form);

        if (user == null || !form.allErrors().isEmpty()) {
            return render("views/login", JoltModel.of("errors", form.allErrors(), "formData", form.buildModel()));
        }

        if (!authService.isEmailValidated(user.getId())) {
            Flash.error("Veuillez vérifier votre email pour pouvoir vous connecter.");
            return render("views/login", JoltModel.of("formData", form.buildModel()));
        }

        sessionService.createUserSession(user);
        Flash.success("Bienvenue " + user.getUsername() + "!");
        return redirect("/");
    }

    @Post("/register")
    public ResponseEntity<?> register(@ToForm Form form) {
        User user = authService.register(form);

        if (user == null || !form.allErrors().isEmpty()) {
            return render("views/register", JoltModel.of("errors", form.allErrors(), "formData", form.buildModel()));
        }

        boolean emailSent = emailVerificationService.sendVerificationEmail(user, context);

        if (emailSent) {
            Flash.success("Inscription réussie. Vérifiez votre email pour activer votre compte.");
            return redirect("/login");
        } else {
            Flash.error("Erreur lors de l'envoi de l'email de vérification.");
            return render("views/register", JoltModel.of("errors", form.allErrors(), "formData", form.buildModel()));
        }
    }

    @Post("/request-verification")
    public ResponseEntity<?> resendVerification(@ToForm Form form) {
        try {
            boolean emailSent = emailVerificationService.resendVerificationEmail(form, context);

            if (emailSent) {
                Flash.success("Un nouveau lien de vérification a été envoyé à votre email.");
                return redirect("/login");
            } else {
                return render("views/request_verification",
                        JoltModel.of("errors", form.allErrors(), "formData", form.buildModel()));
            }
        } catch (EmailAlreadyValidatedException e) {
            Flash.error("Cet email est déjà vérifié.");
            return redirect("/login");
        } catch (ValidationTokenStillValidException e) {
            Flash.error(
                    "Un lien de vérification valide a déjà été envoyé. Veuillez vérifier votre boîte de réception.");
            return redirect("/login");
        } catch (UserSessionExpiredException e) {
            sessionService.destroySession();
            Flash.error("Utilisateur non trouvé. Veuillez vous reconnecter.");
            return redirect("/login");
        } catch (SharedException e) {
            Flash.error("Erreur lors de l'envoi de l'email de vérification.");
            return render("views/request_verification",
                    JoltModel.of("errors", form.allErrors(), "formData", form.buildModel()));
        }
    }

    @Post("/reset-password")
    public ResponseEntity<?> handleReset(@ToForm Form form) {
        try {
            boolean resetSuccessful = passwordResetService.resetPassword(form);

            if (resetSuccessful) {
                Flash.success("Votre mot de passe a été réinitialisé avec succès.");
                return redirect("/login");
            } else {
                String token = form.field("token").get();
                return render("views/reset_password", JoltModel.of("errors", form.allErrors(), "token", token));
            }
        } catch (InvalidTokenException e) {
            Flash.error("Lien de réinitialisation invalide ou expiré.");
            return redirect("/request-reset");
        } catch (UserNotFoundException e) {
            Flash.error("Utilisateur introuvable.");
            return redirect("/login");
        } catch (MissingTokenException e) {
            Flash.error("Token de réinitialisation manquant.");
            return redirect("/request-reset");
        } catch (SharedException e) {
            Flash.error("Erreur lors de la réinitialisation du mot de passe.");
            return redirect("/request-reset");
        }
    }

    @Get("/logout")
    public ResponseEntity<?> logout() {
        sessionService.destroySession();
        Flash.success("Vous êtes désormais déconnecté.");
        return redirect("/");
    }

    @Get("/verify-email")
    public ResponseEntity<?> verifyEmail(@Query("token") String token) {
        try {
            emailVerificationService.verifyEmail(token);
            Flash.success("Votre email a été validé avec succès.");
        } catch (MissingTokenException e) {
            Flash.error("Token de vérification manquant.");
        } catch (InvalidTokenException e) {
            Flash.error("Token de vérification invalide.");
        } catch (ExpiredTokenException e) {
            Flash.error("Token de vérification expiré.");
        } catch (UserNotFoundException e) {
            Flash.error("Utilisateur non trouvé.");
        } catch (SharedException e) {
            Flash.error("Erreur lors de la validation de l'email.");
        }

        return redirect("/login");
    }

    @Post("/request-reset")
    public ResponseEntity<?> requestReset(@ToForm Form form) {
        boolean emailSent = false;
        try {
            emailSent = passwordResetService.sendPasswordResetEmail(form, context);
        } catch (Exception e) {
            Flash.error("Erreur lors de l'envoi de l'email de réinitialisation : " + e.getMessage());
            return render("views/request_password_reset",
                    JoltModel.of("errors", form.allErrors(), "formData", form.buildModel()));
        }

        if (emailSent) {
            Flash.success("Un lien de réinitialisation de mot de passe vous a été envoyé.");
            return redirect("/login");
        } else {
            return render("views/request_password_reset",
                    JoltModel.of("errors", form.allErrors(), "formData", form.buildModel()));
        }
    }

    @Get("/reset-password")
    public ResponseEntity<?> showResetForm(@Query("token") String token) {
        try {
            passwordResetService.validateResetToken(token);
            return render("views/reset_password", JoltModel.of("token", token));
        } catch (MissingTokenException | InvalidTokenException e) {
            Flash.error("Lien de réinitialisation invalide ou expiré.");
            return redirect("/request-reset");
        } catch (SharedException e) {
            Flash.error("Erreur lors de la validation du token.");
            return redirect("/request-reset");
        }
    }
}