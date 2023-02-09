package com.guilhermeaug.gym_tracker.service;

import com.guilhermeaug.gym_tracker.dto.request.ExerciseRequestDto;
import com.guilhermeaug.gym_tracker.dto.response.ExerciseResponseDto;
import reactor.core.publisher.Flux;
import reactor.core.publisher.Mono;

public interface ExerciseService {

    Flux<ExerciseResponseDto> createExercise(Flux<ExerciseRequestDto> exerciseRequestDto);
    Flux<ExerciseResponseDto> getAllExercises();
    Mono<ExerciseResponseDto> getExerciseById(Long id);
    Flux<ExerciseResponseDto> getAllExercisesByRecordId(Long id);
    Mono<Void> deleteExerciseById(Long id);
    Mono<ExerciseResponseDto> updateExerciseById(Long id, Mono<ExerciseRequestDto> exerciseRequestDtoMono);
}
