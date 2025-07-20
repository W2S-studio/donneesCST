package io.github.t1willi.entities;

import java.time.LocalDateTime;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;

@Builder
@Data
@AllArgsConstructor
@NoArgsConstructor
@ToString
public class User {

    private int id;
    private String username;
    private String email;
    private String hashEmail;
    private String password;
    private boolean emailValidate;
    private boolean hasAcceptedTos;
    private LocalDateTime createdAt;

    public static User of(String username, String email, String hashEmail, String password, boolean hasAcceptedTos) {
        return User.builder()
                .username(username)
                .email(email)
                .hashEmail(hashEmail)
                .password(password)
                .createdAt(LocalDateTime.now())
                .hasAcceptedTos(hasAcceptedTos)
                .build();
    }

    public static User of(int id, String username, String email, String hashEmail, String password,
            LocalDateTime createdAt) {
        return User.builder()
                .id(id)
                .username(username)
                .email(email)
                .hashEmail(hashEmail)
                .password(password)
                .createdAt(createdAt)
                .build();
    }
}