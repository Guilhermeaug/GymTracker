package com.guilhermeaug.gym_tracker.repository;

import com.guilhermeaug.gym_tracker.model.ExerciseModel;
import org.springframework.data.r2dbc.repository.Query;
import org.springframework.data.repository.reactive.ReactiveCrudRepository;
import reactor.core.publisher.Flux;

public interface ExerciceRepository extends ReactiveCrudRepository<ExerciseModel, Long> {

    @Query("SELECT * FROM EXERCISE WHERE RECORD_ID = :recordId")
    Flux<ExerciseModel> findAllByRecordId(Long recordId);
}
