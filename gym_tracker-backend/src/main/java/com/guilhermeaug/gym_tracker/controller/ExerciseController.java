package com.guilhermeaug.gym_tracker.controller;

import com.guilhermeaug.gym_tracker.dto.request.ExerciseRequestDto;
import com.guilhermeaug.gym_tracker.dto.response.ExerciseResponseDto;
import com.guilhermeaug.gym_tracker.service.ExerciseService;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import reactor.core.publisher.Flux;
import reactor.core.publisher.Mono;

@RequiredArgsConstructor
@RestController
@RequestMapping("api/exercises")
@CrossOrigin(origins = "*")
public class ExerciseController {

    private final ExerciseService exerciseService;

    @PostMapping
    Flux<ExerciseResponseDto> createExercise(@Valid @RequestBody Flux<ExerciseRequestDto> exerciseRequestDto) {
        return exerciseService
                .createExercise(exerciseRequestDto);
    }

    @GetMapping
    Flux<ExerciseResponseDto> getAllExercises() {
        return exerciseService
                .getAllExercises();
    }

    @GetMapping("{id}")
    Mono<ResponseEntity<ExerciseResponseDto>> getExerciseById(@PathVariable Long id) {
        return exerciseService
                .getExerciseById(id)
                .map(ResponseEntity::ok);
    }

    @DeleteMapping("{id}")
    Mono<ResponseEntity<Void>> deleteExerciseById(@PathVariable Long id) {
        return exerciseService
                .deleteExerciseById(id)
                .map(ResponseEntity::ok);
    }

    @PutMapping("{id}")
    Mono<ResponseEntity<ExerciseResponseDto>> updateExerciseById(@PathVariable Long id, @Valid @RequestBody Mono<ExerciseRequestDto> exerciseRequestDtoMono) {
        return exerciseService
                .updateExerciseById(id, exerciseRequestDtoMono)
                .map(ResponseEntity::ok);
    }

    @GetMapping("record/{id}")
    Flux<ExerciseResponseDto> getAllExercisesByRecordId(@PathVariable Long id) {
        return exerciseService
                .getAllExercisesByRecordId(id);
    }

}
