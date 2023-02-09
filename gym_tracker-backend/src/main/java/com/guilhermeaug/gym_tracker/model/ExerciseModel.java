package com.guilhermeaug.gym_tracker.model;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.springframework.data.annotation.Id;
import org.springframework.data.relational.core.mapping.Table;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Table("exercise")
public class ExerciseModel {
    @Id
    private Long id;

    private String name;

    private Integer series;

    private Integer repetitions;

    private Long recordId;
}