package io.github.t1willi.controller;

import io.github.t1willi.annotations.Controller;
import io.github.t1willi.annotations.Get;
import io.github.t1willi.context.JoltContext;
import io.github.t1willi.core.MvcController;
import io.github.t1willi.http.ModelView;
import io.github.t1willi.http.ResponseEntity;
import io.github.t1willi.injector.annotation.Autowire;
import io.github.t1willi.interfaces.IApiKeyService;
import io.github.t1willi.interfaces.ISessionService;
import io.github.t1willi.interfaces.IUsageService;
import io.github.t1willi.interfaces.IUserMfaSettingsService;
import io.github.t1willi.security.authentification.Authorize;
import io.github.t1willi.security.authentification.OnAuthFailure;
import io.github.t1willi.template.JoltModel;
import io.github.t1willi.utils.Flash;
import io.github.t1willi.utils.MFAService;

@Controller("[controller]") // /dashboard
@Authorize(onFailureHandler = io.github.t1willi.controller.DashboardController.AuthHandler.class)
public class DashboardController extends MvcController {

    @Autowire
    private MFAService mfaService;

    @Autowire
    private IApiKeyService _apiKeyService;

    @Autowire
    private IUsageService _usageService;

    @Autowire
    private IUserMfaSettingsService _userMfaSettingsService;

    @Autowire
    private ISessionService _sessionService;

    @Get
    public ResponseEntity<ModelView> dashboard() {
        return render("dashboard", JoltModel.of("username", _sessionService.getCurrentUsername()));
    }

    public static class AuthHandler implements OnAuthFailure {
        @Override
        public void handle(JoltContext context) {
            Flash.warning("Vous devez vous connecter pour accéder à cette page");
            context.redirect("/");
        }
    }
}
