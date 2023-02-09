package com.guilhermeaug.gym_tracker.repository;

import com.guilhermeaug.gym_tracker.model.RecordModel;
import org.springframework.data.repository.reactive.ReactiveCrudRepository;

public interface RecordRepository extends ReactiveCrudRepository<RecordModel, Long> {

}
