import 'package:freezed_annotation/freezed_annotation.dart';

part 'exercise.freezed.dart';

part 'exercise.g.dart';

@freezed
class Exercise with _$Exercise {
  const factory Exercise(
      {required int id,
      required String name,
      required int series,
      required int repetitions}) = _Exercise;

  factory Exercise.fromJson(Map<String, Object?> json) =>
      _$ExerciseFromJson(json);
}
