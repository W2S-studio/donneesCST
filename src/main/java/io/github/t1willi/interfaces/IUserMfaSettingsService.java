package io.github.t1willi.interfaces;

import io.github.t1willi.dtos.UserMfaSettingsDTO;

public interface IUserMfaSettingsService {
    UserMfaSettingsDTO getUserMfaSettings(int userId);
}
