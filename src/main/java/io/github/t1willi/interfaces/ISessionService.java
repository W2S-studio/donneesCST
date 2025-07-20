package io.github.t1willi.interfaces;

import io.github.t1willi.entities.User;

public interface ISessionService {
    void createUserSession(User user);

    void setCanViewApiKeys(boolean canViewApiKeys);

    void destroySession();

    String getCurrentUserId();

    String getCurrentUserEmail();

    String getCurrentUsername();

    boolean isAuthenticated();

    boolean canViewApiKeys();
}
