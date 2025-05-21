package io.github.t1willi.controller;

import java.util.List;
import java.util.Optional;

import io.github.t1willi.annotations.Controller;
import io.github.t1willi.annotations.Get;
import io.github.t1willi.annotations.Post;
import io.github.t1willi.annotations.ToForm;
import io.github.t1willi.core.MvcController;
import io.github.t1willi.entities.User;
import io.github.t1willi.form.Form;
import io.github.t1willi.http.HttpStatus;
import io.github.t1willi.http.ResponseEntity;
import io.github.t1willi.injector.annotation.Autowire;
import io.github.t1willi.security.authentification.Authorize;
import io.github.t1willi.security.session.Session;
import io.github.t1willi.services.UserService;
import io.github.t1willi.template.JoltModel;

@Controller
public class HomeController extends MvcController {

    @Autowire
    private UserService userService;

    @Get
    public ResponseEntity<?> index() {
        return render("home", null);
    }

    @Get("/dashboard")
    @Authorize
    public ResponseEntity<?> dashboard() {
        JoltModel m = JoltModel.of("username", Session.get("username", "guest"))
                .with("showKeys", false);
        return render("dashboard", m);
    }

    @Get("/connexion")
    public ResponseEntity<?> login() {
        if (Session.isAuthenticated()) {
            return redirect("/dashboard");
        }
        return render("login", null);
    }

    @Get("/inscription")
    public ResponseEntity<?> register() {
        if (Session.isAuthenticated()) {
            return redirect("/dashboard");
        }
        return render("register", null);
    }

    @Post("/connexion")
    public ResponseEntity<?> loginPost(@ToForm Form form) {
        try {
            Optional<User> userOpt = userService.login(form);
            if (userOpt.isPresent()) {
                Session.invalidate();
                Session.setAuthenticated(true);
                Session.set("userId", userOpt.get().getId());
                Session.set("username", userOpt.get().getUsername());
                return redirect("/dashboard");
            } else {
                JoltModel m = JoltModel.of("errors", List.of("Identifiant ou mot de passe incorrect"));
                return render("login", m)
                        .status(HttpStatus.BAD_REQUEST);
            }
        } catch (IllegalArgumentException e) {
            JoltModel m = JoltModel.of("form", form)
                    .with("errors", List.copyOf(form.errors().values()));
            return render("login", m)
                    .status(HttpStatus.BAD_REQUEST);
        }
    }

    @Post("/inscription")
    public ResponseEntity<?> registerPost(@ToForm Form form) {
        try {
            User u = userService.register(form);
            Session.invalidate();
            Session.setAuthenticated(true);
            Session.set("userId", u.getId());
            Session.set("username", u.getUsername());
            return redirect("/dashboard");
        } catch (IllegalArgumentException e) {
            JoltModel m = JoltModel.of("form", form)
                    .with("errors", List.copyOf(form.errors().values()));
            return render("register", m)
                    .status(HttpStatus.BAD_REQUEST);
        }
    }

    @Post("/dashboard")
    @Authorize
    public ResponseEntity<?> dashboardPost(@ToForm Form form) {
        int userId = Integer.parseInt(Session.get("userId", "0"));
        String action = form.field("action").get();

        try {
            switch (action) {
                case "createKey" -> {
                    String exp = form.field("key_expiration").get();
                    if ("".equals(exp))
                        exp = null;
                    userService.createApiKey(userId, exp, form);
                }
                case "deleteKey" -> userService.deleteKey(Integer.parseInt(form.field("keyId").get()));
                case "updatePassword" -> {
                    form.setValue("userId", String.valueOf(userId));
                    userService.updatePassword(form);
                }
                case "logout" -> {
                    Session.invalidate();
                    return redirect("/");
                }
            }
        } catch (IllegalArgumentException ex) {
            JoltModel m = JoltModel.of("username", Session.get("username", "guest"))
                    .with("apiKeys", userService.getUserKeys(userId))
                    .with("form", form)
                    .with("errors", List.copyOf(form.errors().values()));
            return render("dashboard", m)
                    .status(HttpStatus.BAD_REQUEST);
        }

        JoltModel m = JoltModel.of("username", Session.get("username", "guest"))
                .with("apiKeys", userService.getUserKeys(userId));
        return render("dashboard", m);
    }

    @Post("/dashboard/reveal-keys")
    @Authorize
    public ResponseEntity<?> revealKeys(@ToForm Form form) {
        int userId = Integer.parseInt(Session.get("userId", "0"));
        boolean ok = userService.verifyPassword(userId, form.field("confirmPassword").get());
        JoltModel m = JoltModel.of("username", Session.get("username", "guest"));
        if (!ok) {
            m = m.with("showKeys", false)
                    .with("errorKeyAuth", "Mot de passe incorrect");
        } else {
            m = m.with("showKeys", true)
                    .with("apiKeys", userService.getUserKeys(userId));
        }
        return render("dashboard", m);
    }
}
