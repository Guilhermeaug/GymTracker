import 'package:flutter/material.dart';

class NoExercises extends StatelessWidget {
  final void Function(BuildContext context) pushNewExerciseScreen;

  const NoExercises({Key? key, required this.pushNewExerciseScreen})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: TextButton(
        onPressed: () => pushNewExerciseScreen(context),
        child: const Text('Adicionar novo exercício'),
      ),
    );
  }
}
