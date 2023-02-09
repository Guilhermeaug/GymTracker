package com.guilhermeaug.gym_tracker.service;

import com.guilhermeaug.gym_tracker.dto.request.RecordRequestDto;
import com.guilhermeaug.gym_tracker.dto.response.RecordResponseDto;
import com.guilhermeaug.gym_tracker.model.RecordModel;
import reactor.core.publisher.Flux;
import reactor.core.publisher.Mono;

public interface RecordService {
    Mono<RecordResponseDto> createRecord(Mono<RecordRequestDto> recordRequestDto);
    Flux<RecordResponseDto> getAllRecords();
    Mono<RecordResponseDto> getRecordById(Long id);
    Mono<Void> deleteRecordById(Long id);
    Mono<RecordResponseDto> updateRecordById(Long id, Mono<RecordRequestDto> recordRequestDto);
}
