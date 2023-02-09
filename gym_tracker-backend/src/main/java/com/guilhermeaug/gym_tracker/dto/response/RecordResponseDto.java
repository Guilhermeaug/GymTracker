package com.guilhermeaug.gym_tracker.dto.response;

import java.time.LocalDate;

public record RecordResponseDto(
        Long id,
        String name,
        String bodyParts,
        LocalDate date
) {
}
