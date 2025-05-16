package io.github.t1willi.entities;

import java.time.LocalDateTime;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
public class ApiKeys {
    private int id;
    private String key;
    private int userId;
    private LocalDateTime created;
    private LocalDateTime expire;
}
