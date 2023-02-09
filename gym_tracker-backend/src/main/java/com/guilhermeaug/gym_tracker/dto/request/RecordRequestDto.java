package com.guilhermeaug.gym_tracker.dto.request;

import jakarta.validation.constraints.NotEmpty;

public record RecordRequestDto(
        @NotEmpty(message = "Forneça um nome para a ficha") String name,
        @NotEmpty(message = "Indique as partes do corpo que serão trabalhadas") String bodyParts
) {
}
