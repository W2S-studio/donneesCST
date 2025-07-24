package io.github.t1willi.controller;

import io.github.t1willi.annotations.Controller;
import io.github.t1willi.annotations.Get;
import io.github.t1willi.core.MvcController;
import io.github.t1willi.http.ModelView;
import io.github.t1willi.http.ResponseEntity;
import io.github.t1willi.security.session.Session;
import io.github.t1willi.template.JoltModel;

import java.util.HashMap;

@Controller
public class HomeController extends MvcController {

    @Get
    public ResponseEntity<ModelView> home() {
        return render("home", JoltModel.of("username", Session.get("username")));
    }

    @Get("/about")
    public ResponseEntity<ModelView> about() {
        return render("about", JoltModel.of("username", Session.get("username")));
    }

    @Get("/login")
    public ResponseEntity<ModelView> login() {
        return render("views/login", JoltModel.of("formData", new HashMap<String, String>()));
    }

    @Get("/register")
    public ResponseEntity<ModelView> register() {
        return render("views/register", JoltModel.of("formData", new HashMap<String, String>()));
    }

    @Get("/terms")
    public ResponseEntity<ModelView> terms() {
        return render("views/terms");
    }

    @Get("/request-verification")
    public ResponseEntity<ModelView> requestVerification() {
        return render("views/request_verification", JoltModel.of("formData", new HashMap<String, String>()));
    }

    @Get("/request-reset")
    public ResponseEntity<?> showRequestResetForm() {
        return render(
                "views/request_password_reset",
                JoltModel.of("formData", new HashMap<String, String>()));
    }
}