package io.github.t1willi.controller;

import io.github.t1willi.annotations.Controller;
import io.github.t1willi.annotations.Get;
import io.github.t1willi.core.BaseController;

@Controller("[controller]")
public class HomeController extends BaseController {
    @Get
    public String index() {
        return "Hello from HomeController!";
    }
}
