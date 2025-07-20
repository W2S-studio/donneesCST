package io.github.t1willi.dtos;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class SupportContactedDTO {
    private String userName;
    private String userEmail;
    private String subject;
    private String messageContent;
    private String submissionTime;
}
