package io.github.t1willi.services;

import io.github.t1willi.dtos.UserMfaSettingsDTO;
import io.github.t1willi.injector.annotation.Bean;
import io.github.t1willi.interfaces.IUserMfaSettingsService;

@Bean
public class UserMfaSettingsService implements IUserMfaSettingsService {

    @Override
    public UserMfaSettingsDTO getUserMfaSettings(int userId) {
        throw new UnsupportedOperationException("Unimplemented method 'getUserMfaSettings'");
    }
}
