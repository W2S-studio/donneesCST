package io.github.t1willi.controller;

import io.github.t1willi.annotations.Controller;
import io.github.t1willi.annotations.Get;
import io.github.t1willi.core.MvcController;
import io.github.t1willi.http.ModelView;
import io.github.t1willi.http.ResponseEntity;

@Controller
public class HomeController extends MvcController {

    @Get
    public ResponseEntity<ModelView> home() {
        return render("home");
    }

    @Get("/dashboard")
    public ResponseEntity<ModelView> dashboard() {
        return render("dashboard");
    }

    @Get("/connexion")
    public ResponseEntity<ModelView> connexion() {
        return render("connexion");
    }

    @Get("/inscription")
    public ResponseEntity<ModelView> inscription() {
        return render("inscription");
    }
}
