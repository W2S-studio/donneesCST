package io.github.t1willi.controller;

import io.github.t1willi.annotations.Controller;
import io.github.t1willi.annotations.Get;
import io.github.t1willi.annotations.Post;
import io.github.t1willi.annotations.ToForm;
import io.github.t1willi.core.BaseController;
import io.github.t1willi.form.Form;
import io.github.t1willi.injector.annotation.Autowire;
import io.github.t1willi.services.UserService;
import io.github.t1willi.template.Template;

@Controller()
public class HomeController extends BaseController {

    @Autowire
    private UserService userService;

    @Get
    public Template index() {
        return new Template("home");
    }

    @Get("/login")
    public Template login() {
        return new Template("login");
    }

    @Get("/register")
    public Template register() {
        return new Template("register");
    }

    @Post("/login") // Redirct /home
    public Template loginPost(@ToForm Form form) {
        return new Template("home");
    }
}
