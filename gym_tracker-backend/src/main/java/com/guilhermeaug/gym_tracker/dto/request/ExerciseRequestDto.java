package com.guilhermeaug.gym_tracker.dto.request;

import jakarta.validation.constraints.NotEmpty;
import jakarta.validation.constraints.NotNull;

public record ExerciseRequestDto(
        @NotEmpty(message = "Forneça o nome do exercício") String name,
        @NotNull(message = "Indique quantas séries para este exercício") Integer series,
        @NotNull(message = "Indique quantas repetições") Integer repetitions,
        @NotNull(message = "Informe a ficha do exercício") Long recordId
) {
}
