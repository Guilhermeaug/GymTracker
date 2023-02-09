package com.guilhermeaug.gym_tracker.mapper;

import com.guilhermeaug.gym_tracker.dto.request.ExerciseRequestDto;
import com.guilhermeaug.gym_tracker.dto.response.ExerciseResponseDto;
import com.guilhermeaug.gym_tracker.model.ExerciseModel;
import org.mapstruct.Mapper;
import org.mapstruct.Mapping;

@Mapper(componentModel = "spring")
public interface ExerciseMapper {

    ExerciseResponseDto modelToResponseDto(ExerciseModel exerciseModel);

    @Mapping(target = "id", ignore = true)
    ExerciseModel requestToModel(ExerciseRequestDto exerciseRequestDto);
}
