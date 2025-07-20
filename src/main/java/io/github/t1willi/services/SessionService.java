package io.github.t1willi.services;

import io.github.t1willi.entities.User;
import io.github.t1willi.injector.annotation.Bean;
import io.github.t1willi.interfaces.ISessionService;
import io.github.t1willi.security.session.Session;

@Bean
public class SessionService implements ISessionService {

    private static final String USER_ID_KEY = "userId";
    private static final String USERNAME_KEY = "username";
    private static final String EMAIL_KEY = "email";

    private static final String CAN_VIEW_API_KEYS_KEY = "canViewApiKeys";

    @Override
    public void createUserSession(User user) {
        Session.set(USER_ID_KEY, String.valueOf(user.getId()));
        Session.set(USERNAME_KEY, user.getUsername());
        Session.set(EMAIL_KEY, user.getEmail());
        Session.setAuthenticated(true);
    }

    @Override
    public void setCanViewApiKeys(boolean canView) {
        Session.set(CAN_VIEW_API_KEYS_KEY, canView);
    }

    @Override
    public void destroySession() {
        Session.destroy();
    }

    @Override
    public String getCurrentUserId() {
        return Session.get(USER_ID_KEY);
    }

    @Override
    public String getCurrentUserEmail() {
        return Session.get(EMAIL_KEY);
    }

    @Override
    public String getCurrentUsername() {
        return Session.get(USERNAME_KEY);
    }

    @Override
    public boolean isAuthenticated() {
        return Session.isAuthenticated();
    }

    @Override
    public boolean canViewApiKeys() {
        String canView = Session.get(CAN_VIEW_API_KEYS_KEY);
        return canView != null && Boolean.parseBoolean(canView);
    }
}