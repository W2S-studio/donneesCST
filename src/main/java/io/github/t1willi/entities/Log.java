package io.github.t1willi.entities;

import java.time.LocalDateTime;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Builder
@Data
@AllArgsConstructor
@NoArgsConstructor
public class Log {

    private int id;
    private int userId;
    private String action;
    private String userAgent;
    private String ipAddress;
    private LocalDateTime timestamp;

    public static Log of(int userId, String action, String userAgent, String ipAddress) {
        return builder()
                .userId(userId)
                .action(action)
                .userAgent(userAgent)
                .ipAddress(ipAddress)
                .timestamp(LocalDateTime.now())
                .build();
    }

    public static Log of(String action, String userAgent, String ipAddress) {
        return builder()
                .action(action)
                .userAgent(userAgent)
                .ipAddress(ipAddress)
                .timestamp(LocalDateTime.now())
                .build();
    }
}