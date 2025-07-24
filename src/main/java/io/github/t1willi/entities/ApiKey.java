
package io.github.t1willi.entities;

import java.time.LocalDateTime;

import io.github.t1willi.security.cryptography.CryptographyUtils;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@Builder
@AllArgsConstructor
@NoArgsConstructor
public class ApiKey {

    private int id;
    private int userId;
    String description;
    private String value;
    private int nbrUsage;
    private LocalDateTime lastUsage;
    private LocalDateTime createdAt;

    public static ApiKey of(int userId, String description) {
        return ApiKey.builder()
                .userId(userId)
                .description(description)
                .value(CryptographyUtils.randomBase64(192).substring(0, 255))
                .nbrUsage(0)
                .lastUsage(null)
                .createdAt(LocalDateTime.now())
                .build();
    }
}