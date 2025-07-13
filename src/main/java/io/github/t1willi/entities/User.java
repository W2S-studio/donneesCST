package io.github.t1willi.entities;

import java.time.LocalDateTime;

import com.fasterxml.jackson.annotation.JsonIgnore;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Builder
@Data
@AllArgsConstructor
@NoArgsConstructor
public class User {

    private int id;
    private String username;
    private String email;
    @JsonIgnore
    private String password;
    private LocalDateTime createdAt;

    public static User of(String username, String email, String password) {
        return User.builder()
                .username(username)
                .email(email)
                .password(password)
                .createdAt(LocalDateTime.now())
                .build();
    }
}