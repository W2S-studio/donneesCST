package io.github.t1willi.controller;

import java.util.Map;

import io.github.t1willi.annotations.Controller;
import io.github.t1willi.annotations.Get;
import io.github.t1willi.annotations.Post;
import io.github.t1willi.annotations.ToForm;
import io.github.t1willi.core.MvcController;
import io.github.t1willi.entities.User;
import io.github.t1willi.form.Form;
import io.github.t1willi.http.HttpStatus;
import io.github.t1willi.http.ModelView;
import io.github.t1willi.http.ResponseEntity;
import io.github.t1willi.injector.annotation.Autowire;
import io.github.t1willi.security.authentification.Authorize;
import io.github.t1willi.security.session.Session;
import io.github.t1willi.services.UserService;
import io.github.t1willi.template.JoltModel;
import io.github.t1willi.validators.UserValidator;

@Controller
public class HomeController extends MvcController {

    @Autowire
    private UserService userService;

    @Get
    public ResponseEntity<ModelView> index() {
        return render("home", JoltModel.of("username", getCurrentUsername()));
    }

    @Get("/dashboard")
    @Authorize
    public ResponseEntity<?> dashboard() {
        JoltModel model = createDashboardModel()
                .with("showKeys", getSessionShowKeys());
        return render("dashboard", model);
    }

    @Get("/connexion")
    public ResponseEntity<?> login() {
        return Session.isAuthenticated() ? redirect("/dashboard") : render("login", null);
    }

    @Get("/inscription")
    public ResponseEntity<?> register() {
        return Session.isAuthenticated() ? redirect("/dashboard") : render("register", null);
    }

    @Post("/connexion")
    public ResponseEntity<?> loginPost(@ToForm Form form) {
        try {
            UserValidator.validateLogin(form);
            User user = userService.authenticate(form);
            initializeUserSession(user);
            return redirect("/dashboard");
        } catch (IllegalArgumentException e) {
            return renderWithErrors("login", form);
        }
    }

    @Post("/inscription")
    public ResponseEntity<?> registerPost(@ToForm Form form) {
        try {
            UserValidator.validateRegistration(form);
            User user = userService.register(form);
            initializeUserSession(user);
            return redirect("/dashboard");
        } catch (IllegalArgumentException e) {
            return renderWithErrors("register", form);
        }
    }

    @Post("/dashboard")
    @Authorize
    public ResponseEntity<?> dashboardPost(@ToForm Form form) {
        try {
            String action = form.field("action").get();
            handleDashboardAction(action, form);
            JoltModel model = createDashboardModel()
                    .with("showKeys", getSessionShowKeys());
            return render("dashboard", model);
        } catch (LogoutException e) {
            return redirect("/");
        } catch (IllegalArgumentException e) {
            return renderDashboardWithErrors(form);
        }
    }

    @Post("/dashboard/reveal-keys")
    @Authorize
    public ResponseEntity<?> revealKeys(@ToForm Form form) {
        int userId = getCurrentUserId();
        String password = form.field("confirmPassword").get();

        if (userService.verifyPassword(userId, password)) {
            Session.set("showKeys", "true");
            return redirect("/dashboard");
        } else {
            JoltModel model = createDashboardModel()
                    .with("showKeys", false)
                    .with("errorKeyAuth", "Mot de passe incorrect.");
            return render("dashboard", model).status(HttpStatus.BAD_REQUEST);
        }
    }

    @Post("/dashboard/hide-keys")
    @Authorize
    public ResponseEntity<Void> hideKeys() {
        Session.set("showKeys", "false");
        return redirect("/dashboard");
    }

    private void handleDashboardAction(String action, Form form) {
        int userId = getCurrentUserId();

        switch (action) {
            case "createKey" -> {
                String expiration = form.field("key_expiration").get();
                UserValidator.validateApiKeyCreation(form);
                userService.createApiKey(userId, expiration.isEmpty() ? null : expiration);
            }
            case "deleteKey" -> {
                int keyId = Integer.parseInt(form.field("keyId").get());
                userService.deleteApiKey(keyId);
            }
            case "updatePassword" -> {
                UserValidator.validatePasswordUpdate(form);
                userService.updatePassword(userId, form);
            }
            case "logout" -> {
                Session.invalidate();
                throw new LogoutException();
            }
        }
    }

    private void initializeUserSession(User user) {
        Session.invalidate();
        Session.setAuthenticated(true);
        Session.set("userId", String.valueOf(user.getId()));
        Session.set("username", user.getUsername());
    }

    private JoltModel createDashboardModel() {
        return JoltModel.of(Map.of("username", getCurrentUsername()))
                .with("apiKeys", userService.getUserKeys(getCurrentUserId()));
    }

    private ResponseEntity<?> renderWithErrors(String view, Form form) {
        JoltModel model = JoltModel.of(Map.of("errors", form.errors().values()));
        return render(view, model).status(HttpStatus.BAD_REQUEST);
    }

    private ResponseEntity<?> renderDashboardWithErrors(Form form) {
        JoltModel model = createDashboardModel()
                .with("showKeys", getSessionShowKeys())
                .with("form", form)
                .with("errors", form.errors().values());
        return render("dashboard", model).status(HttpStatus.BAD_REQUEST);
    }

    private int getCurrentUserId() {
        return Integer.parseInt(Session.get("userId", "0"));
    }

    private String getCurrentUsername() {
        return Session.get("username");
    }

    private boolean getSessionShowKeys() {
        return Boolean.parseBoolean(Session.get("showKeys", "false"));
    }

    private static class LogoutException extends RuntimeException {
        // Used to break out of switch and trigger redirect
    }
}