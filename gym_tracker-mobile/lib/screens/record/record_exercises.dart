import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';

import '../../components/exercise_item.dart';
import '../../models/exercise.dart';
import '../../repository/client.dart';
import '../../utils/crud_utils.dart';

class ExercisesList extends StatelessWidget {
  final List<Exercise> exercises;
  final int recordId;
  final String recordName;
  final Future<void> Function() onRefresh;
  final void Function(BuildContext context, Exercise exercise)
      pushEditExerciseScreen;

  const ExercisesList({
    Key? key,
    required this.exercises,
    required this.recordId,
    required this.recordName,
    required this.onRefresh,
    required this.pushEditExerciseScreen,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: exercises.length,
          itemBuilder: (context, index) {
            final exercise = exercises[index];
            return InkWell(
              onLongPress: () => showCrudBottomSheet(
                context,
                onRefresh: onRefresh,
                onEdit: () => pushEditExerciseScreen(context, exercise),
                onDelete: () =>
                    GetIt.I.get<ApiClient>().deleteExerciseById(exercise.id),
              ),
              child: ExerciseItem(
                id: exercise.id,
                name: exercise.name,
                series: exercise.series,
                repetitions: exercise.repetitions,
              ),
            );
          },
        ),
      ],
    );
  }
}
