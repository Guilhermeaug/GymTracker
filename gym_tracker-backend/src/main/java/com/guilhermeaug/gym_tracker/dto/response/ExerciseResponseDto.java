package com.guilhermeaug.gym_tracker.dto.response;

public record ExerciseResponseDto(
        Long id,
        String name,
        Integer series,
        Integer repetitions
) {
}
