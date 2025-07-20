package io.github.t1willi.entities;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class UserLimit {
    private int id;
    private int requestLimitPerMonth;
    private int requestLimitPerDay;

    public static UserLimit of(int userId) {
        return UserLimit.builder()
                .id(userId)
                .requestLimitPerMonth(2500)
                .requestLimitPerDay(250)
                .build();
    }
}
