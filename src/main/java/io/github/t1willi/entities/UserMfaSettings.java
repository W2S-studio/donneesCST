package io.github.t1willi.entities;

import java.time.LocalDateTime;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@Builder
@AllArgsConstructor
@NoArgsConstructor
public class UserMfaSettings {
    private int id;
    private int gracePeriodDays;
    private boolean gracePeriodEnabled;
    private LocalDateTime createdAt;
    private LocalDateTime updatedAt;
}