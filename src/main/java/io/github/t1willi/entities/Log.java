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

    public static Log of(int userId, String action) {
        return builder()
                .userId(userId)
                .action(action)
                .build();
    }
}