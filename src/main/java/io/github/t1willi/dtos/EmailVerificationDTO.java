package io.github.t1willi.dtos;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class EmailVerificationDTO {
    private String userName;
    private String verificationLink;
    private String expiryHours;
}