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
public class UserEmailValidation {
    private int id;
    private String emailValidationToken;
    private LocalDateTime emailValidationTokenExpiration;
    private LocalDateTime validatedAt;
    private LocalDateTime createdAt;

    public static UserEmailValidation of(int userId, String token) {
        return UserEmailValidation.builder()
                .id(userId)
                .emailValidationToken(token)
                .emailValidationTokenExpiration(LocalDateTime.now().plusDays(1))
                .createdAt(LocalDateTime.now())
                .build();
    }
}
