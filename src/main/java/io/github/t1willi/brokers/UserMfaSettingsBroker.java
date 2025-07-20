package io.github.t1willi.brokers;

import io.github.t1willi.database.RestBroker;
import io.github.t1willi.entities.UserMfaSettings;

public class UserMfaSettingsBroker extends RestBroker<Integer, UserMfaSettings> {

    public UserMfaSettingsBroker() {
        super(
                "user_mfa_settings",
                UserMfaSettings.class,
                int.class);
    }

    public UserMfaSettings createDefaultSettings(int userId) {
        UserMfaSettings settings = UserMfaSettings.builder()
                .id(userId)
                .gracePeriodDays(30)
                .gracePeriodEnabled(true)
                .build();

        return save(settings);
    }
}
