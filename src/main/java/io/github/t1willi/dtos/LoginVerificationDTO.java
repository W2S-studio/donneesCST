package io.github.t1willi.dtos;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class LoginVerificationDTO {
    private String userName;
    private String loginTime;
    private String ipAddress;
    private String userAgent;
    private String verificationCode;
    private String expiryMinutes;
}
