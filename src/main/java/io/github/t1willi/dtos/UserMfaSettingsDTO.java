package io.github.t1willi.dtos;

import io.github.t1willi.entities.Mfa;
import io.github.t1willi.entities.UserMfaSettings;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;

@Data
@ToString
@AllArgsConstructor
@NoArgsConstructor
public class UserMfaSettingsDTO {
    private UserMfaSettings settings;
    private Mfa mfa;
}
