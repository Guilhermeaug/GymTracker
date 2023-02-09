package com.guilhermeaug.gym_tracker.mapper;

import com.guilhermeaug.gym_tracker.dto.response.RecordResponseDto;
import com.guilhermeaug.gym_tracker.dto.request.RecordRequestDto;
import com.guilhermeaug.gym_tracker.model.RecordModel;
import org.mapstruct.Mapper;
import org.mapstruct.Mapping;

@Mapper(componentModel = "spring")
public interface RecordMapper {

    RecordResponseDto modelToResponseDto(RecordModel recordModel);

    @Mapping(target = "id", ignore = true)
    RecordModel requestToModel(RecordRequestDto recordRequestDto);
}
