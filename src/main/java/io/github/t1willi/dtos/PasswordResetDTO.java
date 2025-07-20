package io.github.t1willi.dtos;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class PasswordResetDTO {
    private String userName;
    private String requestTime;
    private String ipAddress;
    private String userAgent;
    private String resetLink;
    private String expiryMinutes;
}
