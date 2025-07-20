package io.github.t1willi.dtos;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.ToString;

@Data
@ToString
@AllArgsConstructor
public class MFAResultDTO {
    private final boolean success;
    private final String data;
    private final String message;

    public static MFAResultDTO success(String data, String message) {
        return new MFAResultDTO(true, data, message);
    }

    public static MFAResultDTO error(String message) {
        return new MFAResultDTO(false, null, message);
    }
}
