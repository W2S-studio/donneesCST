package io.github.t1willi.entities;

import java.time.LocalDateTime;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@Builder
@AllArgsConstructor
@NoArgsConstructor
public class UserPasswordReset {
    private int id;
    private String passwordResetToken;
    private LocalDateTime passwordResetTokenExpiration;

    public static UserPasswordReset of(int id, String passwordResetToken) {
        return UserPasswordReset.builder()
                .id(id)
                .passwordResetToken(passwordResetToken)
                .passwordResetTokenExpiration(LocalDateTime.now().plusMinutes(30))
                .build();
    }
}
