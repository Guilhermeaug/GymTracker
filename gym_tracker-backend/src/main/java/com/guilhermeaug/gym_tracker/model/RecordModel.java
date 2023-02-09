package com.guilhermeaug.gym_tracker.model;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.springframework.data.annotation.Id;
import org.springframework.data.relational.core.mapping.Table;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Table("record")
public class RecordModel {

    @Id
    private Long id;

    private String name;

    private String bodyParts;
}
