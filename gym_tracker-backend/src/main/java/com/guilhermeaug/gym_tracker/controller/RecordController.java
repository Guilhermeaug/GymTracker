package com.guilhermeaug.gym_tracker.controller;

import com.guilhermeaug.gym_tracker.dto.request.RecordRequestDto;
import com.guilhermeaug.gym_tracker.dto.response.RecordResponseDto;
import com.guilhermeaug.gym_tracker.service.RecordService;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import reactor.core.publisher.Flux;
import reactor.core.publisher.Mono;

@RequiredArgsConstructor
@RestController
@RequestMapping("api/records")
@CrossOrigin(origins = "*")
public class RecordController {

    private final RecordService recordService;

    @PostMapping
    Mono<ResponseEntity<RecordResponseDto>> createRecord(@Valid @RequestBody Mono<RecordRequestDto> recordRequestDtoMono) {
        return recordService
                .createRecord(recordRequestDtoMono)
                .map(ResponseEntity::ok);
    }

    @ResponseStatus(HttpStatus.OK)
    @GetMapping
    Flux<RecordResponseDto> getAllRecords() {
        return recordService
                .getAllRecords();
    }

    @GetMapping("{id}")
    Mono<ResponseEntity<RecordResponseDto>> getRecordById(@PathVariable Long id) {
        return recordService
                .getRecordById(id)
                .map(ResponseEntity::ok);
    }

    @DeleteMapping("{id}")
    Mono<ResponseEntity<Void>> deleteRecordById(@PathVariable Long id) {
        return recordService
                .deleteRecordById(id)
                .map(ResponseEntity::ok);
    }

    @PutMapping("{id}")
    Mono<ResponseEntity<RecordResponseDto>> updateRecordById(@PathVariable Long id, @Valid @RequestBody Mono<RecordRequestDto> recordRequestDtoMono) {
        return recordService
                .updateRecordById(id, recordRequestDtoMono)
                .map(ResponseEntity::ok);
    }

}
