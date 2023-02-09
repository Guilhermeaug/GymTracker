package com.guilhermeaug.gym_tracker.service;

import com.guilhermeaug.gym_tracker.dto.request.ExerciseRequestDto;
import com.guilhermeaug.gym_tracker.dto.response.ExerciseResponseDto;
import com.guilhermeaug.gym_tracker.exception.ResourceNotFoundException;
import com.guilhermeaug.gym_tracker.mapper.ExerciseMapper;
import com.guilhermeaug.gym_tracker.repository.ExerciceRepository;
import com.guilhermeaug.gym_tracker.repository.RecordRepository;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import reactor.core.publisher.Flux;
import reactor.core.publisher.Mono;

@Slf4j
@RequiredArgsConstructor
@Service
public class ExerciseServiceImpl implements ExerciseService {

    private final ExerciceRepository exerciseRepository;
    private final RecordRepository recordRepository;
    private final ExerciseMapper exerciseMapper;

    @Override
    public Flux<ExerciseResponseDto> createExercise(Flux<ExerciseRequestDto> exerciseRequestDto) {
        log.info("Creating exercise");
        return exerciseRequestDto
                .map(exerciseMapper::requestToModel)
                .filterWhen(exerciseModel -> recordRepository.existsById(exerciseModel.getRecordId()))
                .flatMap(exerciseRepository::save)
                .doOnNext(exerciseModel -> log.info("Exercise created: {}", exerciseModel))
                .map(exerciseMapper::modelToResponseDto)
                .switchIfEmpty(Mono.error(new ResourceNotFoundException("Record not found")));
    }

    @Override
    public Flux<ExerciseResponseDto> getAllExercises() {
        log.info("Getting all exercises");
        return exerciseRepository
                .findAll()
                .doOnNext(ex -> log.info("Exercises found"))
                .map(exerciseMapper::modelToResponseDto);
    }

    @Override
    public Mono<ExerciseResponseDto> getExerciseById(Long id) {
        log.info("Getting exercise by id: {}", id);
        return exerciseRepository
                .findById(id)
                .doOnNext(ex -> log.info("Exercise found: {}", ex))
                .map(exerciseMapper::modelToResponseDto);
    }

    @Override
    public Flux<ExerciseResponseDto> getAllExercisesByRecordId(Long id) {
        log.info("Getting all exercises by record id: {}", id);
        return exerciseRepository
                .findAllByRecordId(id)
                .doOnNext(ex -> log.info("Exercises found: {}", ex))
                .map(exerciseMapper::modelToResponseDto);
    }

    @Override
    public Mono<Void> deleteExerciseById(Long id) {
        log.info("Deleting exercise by id: {}", id);
        return exerciseRepository
                .findById(id)
                .doOnNext(ex -> log.info("Exercise found: {}", ex))
                .flatMap(exerciseRepository::delete)
                .switchIfEmpty(Mono.error(new ResourceNotFoundException("Exercise not found")));
    }

    @Override
    public Mono<ExerciseResponseDto> updateExerciseById(Long id, Mono<ExerciseRequestDto> exerciseRequestDto) {
        log.info("Updating exercise by id: {}", id);
        return exerciseRepository
                .findById(id)
                .flatMap(exerciseModel -> exerciseRequestDto
                        .map(exerciseMapper::requestToModel)
                        .doOnNext(exerciseModel1 -> exerciseModel1.setId(exerciseModel.getId()))
                        .flatMap(exerciseRepository::save)
                        .doOnNext(exerciseModel2 -> log.info("Record updated: {}", exerciseModel2)))
                .map(exerciseMapper::modelToResponseDto)
                .switchIfEmpty(Mono.error(new ResourceNotFoundException("Exercise not found")));
    }
}
