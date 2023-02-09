package com.guilhermeaug.gym_tracker.service;

import com.guilhermeaug.gym_tracker.dto.request.RecordRequestDto;
import com.guilhermeaug.gym_tracker.dto.response.RecordResponseDto;
import com.guilhermeaug.gym_tracker.exception.ResourceNotFoundException;
import com.guilhermeaug.gym_tracker.mapper.RecordMapper;
import com.guilhermeaug.gym_tracker.model.RecordModel;
import com.guilhermeaug.gym_tracker.repository.RecordRepository;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import reactor.core.publisher.Flux;
import reactor.core.publisher.Mono;

@Slf4j
@RequiredArgsConstructor
@Service
public class RecordServiceImpl implements RecordService {

    private final RecordRepository recordRepository;
    private final RecordMapper recordMapper;

    @Override
    public Mono<RecordResponseDto> createRecord(Mono<RecordRequestDto> recordRequestDto) {
        log.info("Creating record");
        return recordRequestDto
                .map(recordMapper::requestToModel)
                .flatMap(recordRepository::save)
                .doOnNext(recordModel -> log.info("Record created: {}", recordModel))
                .map(recordMapper::modelToResponseDto);
    }

    @Override
    public Flux<RecordResponseDto> getAllRecords() {
        log.info("Getting all records");
        return recordRepository
                .findAll()
                .doOnNext(recordModel -> log.info("Record found: {}", recordModel))
                .map(recordMapper::modelToResponseDto);
    }

    @Override
    public Mono<RecordResponseDto> getRecordById(Long id) {
        log.info("Getting record by id: {}", id);
        return recordRepository
                .findById(id)
                .doOnNext(recordModel -> log.info("Record found: {}", recordModel))
                .map(recordMapper::modelToResponseDto)
                .switchIfEmpty(Mono.error(new ResourceNotFoundException("Record not found with id: " + id)));
    }

    @Override
    public Mono<Void> deleteRecordById(Long id) {
        log.info("Deleting record by id: {}", id);
        return recordRepository
                .findById(id)
                .flatMap(recordRepository::delete)
                .doOnNext(aVoid -> log.info("Record deleted"))
                .switchIfEmpty(Mono.error(new ResourceNotFoundException("Record not found with id: " + id)));
    }

    @Override
    public Mono<RecordResponseDto> updateRecordById(Long id, Mono<RecordRequestDto> recordRequestDto) {
        log.info("Updating record by id: {}", id);
        return recordRepository
                .findById(id)
                .flatMap(recordModel -> recordRequestDto
                        .map(recordMapper::requestToModel)
                        .doOnNext(recordModel1 -> recordModel1.setId(recordModel.getId()))
                        .flatMap(recordRepository::save)
                        .doOnNext(recordModel1 -> log.info("Record updated: {}", recordModel1)))
                .map(recordMapper::modelToResponseDto)
                .switchIfEmpty(Mono.error(new ResourceNotFoundException("Record not found with id: " + id)));
    }
}
