package io.github.t1willi.entities;

import java.time.LocalDateTime;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class UserSupportTicket {
    private int id;
    private String ipAddress;
    private String userAgent;
    private LocalDateTime createdAt;

    public static UserSupportTicket of(String ipAddress, String userAgent) {
        return UserSupportTicket.builder()
                .ipAddress(ipAddress)
                .userAgent(userAgent)
                .createdAt(LocalDateTime.now())
                .build();
    }
}
