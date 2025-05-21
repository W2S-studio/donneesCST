package io.github.t1willi.controller;

import java.util.Optional;

import io.github.t1willi.annotations.Controller;
import io.github.t1willi.annotations.Get;
import io.github.t1willi.annotations.Post;
import io.github.t1willi.annotations.ToForm;
import io.github.t1willi.context.JoltContext;
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

@Controller()
public class HomeController extends MvcController {

    @Autowire
    private UserService userService;

    @Get
    public ModelView index() {
        return ModelView.of("home", null);
    }

    @Get("/dashboard")
    @Authorize
    public ModelView dashboard(JoltContext ctx) {
        return ModelView.of("dashboard",
                JoltModel.of("username", Session.get("username"))
                        .with("showKeys", false));
    }

    @Get("/connexion")
    public ModelView login() {
        if (Session.isAuthenticated()) {
            redirect("/dashboard");
        }
        return ModelView.of("login", null);
    }

    @Get("/inscription")
    public ModelView register() {
        if (Session.isAuthenticated()) {
            redirect("/home");
        }
        return ModelView.of("register", null);
    }

    @Post("/connexion")
    public ResponseEntity<?> loginPost(@ToForm Form form) {
        try {
            Optional<User> userOpt = this.userService.login(form);
            if (userOpt.isPresent()) {
                User user = userOpt.get();
                Session.set("userId", user.getId());
                Session.set("username", user.getUsername());
                Session.setAuthenticated(true);
                return redirect("/dashboard");
            } else {
                return ResponseEntity.of(HttpStatus.BAD_REQUEST,
                        ModelView.of("login", JoltModel.of("errors", "Mot de passe ou identifiant incorrect")), false,
                        null);
            }
        } catch (IllegalArgumentException e) {
            return ResponseEntity.of(HttpStatus.BAD_REQUEST,
                    ModelView.of("connexion", JoltModel.of("form", form).with("errors", form.errors())), false, null);
        }
    }

    @Post("/inscription")
    public ResponseEntity<?> registerPost(@ToForm Form form) {
        try {
            User user = this.userService.register(form);
            Session.set("userId", user.getId());
            Session.set("username", user.getUsername());
            Session.setAuthenticated(true);
            return redirect("/dashboard");
        } catch (IllegalArgumentException e) {
            return ResponseEntity.of(HttpStatus.BAD_REQUEST,
                    ModelView.of("inscription", JoltModel.of("form", form).with("errors", form.errors())), false, null);
        }
    }

    @Post("/dashboard")
    @Authorize
    public ResponseEntity<?> dashboardPost(@ToForm Form form) {
        int userId = Integer.parseInt(Session.get("userId"));
        String action = form.field("action").get();

        try {
            switch (action) {
                case "createKey" -> {
                    String expirationDate = form.field("key_expiration").get();
                    if (expirationDate != null && expirationDate.isEmpty()) {
                        expirationDate = null;
                    }
                    this.userService.createApiKey(userId, expirationDate, form);
                }
                case "deleteKey" -> this.userService.deleteKey(Integer.parseInt(form.field("keyId").get()));
                case "updatePassword" -> {
                    form.setValue("userId", String.valueOf(userId));
                    this.userService.updatePassword(form);
                }
                case "logout" -> {
                    Session.destroy();
                    return redirect("/home");
                }
            }
        } catch (IllegalArgumentException e) {
            return ResponseEntity.of(HttpStatus.BAD_REQUEST,
                    ModelView.of("dashboard", JoltModel.of("username", Session.get("username"))
                            .with("apiKeys", this.userService.getUserKeys(userId))
                            .with("form", form)
                            .with("errors", form.errors())),
                    false, null);
        }

        return ResponseEntity.ok(ModelView.of("dashboard",
                JoltModel.of("username", Session.get("username")).with("apiKeys",
                        this.userService.getUserKeys(userId))));
    }

    @Post("/dashboard/reveal-keys")
    @Authorize
    public ModelView revealKeys(@ToForm Form form) {
        int userId = Integer.parseInt(Session.get("userId"));
        String pwd = form.field("confirmPassword").get();

        boolean ok = userService.verifyPassword(userId, pwd);
        if (!ok) {
            return ModelView.of("dashboard",
                    JoltModel.of("username", Session.get("username"))
                            .with("showKeys", false)
                            .with("errorKeyAuth", "Mot de passe incorrect"));
        }
        return ModelView.of("dashboard",
                JoltModel.of("username", Session.get("username"))
                        .with("showKeys", true)
                        .with("apiKeys", userService.getUserKeys(userId)));
    }
}
