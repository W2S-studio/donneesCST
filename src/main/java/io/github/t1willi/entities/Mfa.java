package io.github.t1willi.entities;

import java.time.LocalDateTime;

import jakarta.annotation.Nullable;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@Builder
@AllArgsConstructor
@NoArgsConstructor
public class Mfa {
    private int id;
    private int userId;
    private String type;
    private String secret;

    @Nullable
    private LocalDateTime expireAt;

    @Nullable
    private String deviceFingerprint;

    @Nullable
    private String ipAddress;

    @Nullable
    private String userAgent;

    private LocalDateTime createdAt;

    @Nullable
    private LocalDateTime lastUsed;
}
