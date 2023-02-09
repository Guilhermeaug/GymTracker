import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:multiple_result/multiple_result.dart';

import '../../models/exercise.dart';
import '../../repository/client.dart';
import '../../utils/crud_utils.dart';
import 'record_appbar.dart';
import 'record_clock.dart';
import 'record_exercises.dart';
import 'record_no-exercises.dart';

class RecordScreen extends StatefulWidget {
  final int id;
  final String name;

  const RecordScreen({
    Key? key,
    required this.id,
    required this.name,
  }) : super(key: key);

  @override
  State<RecordScreen> createState() => _RecordScreenState();
}

class _RecordScreenState extends State<RecordScreen> {
  Result<List<Exercise>, DioError>? _exercises;
  bool _isRunning = false;
  int _index = 0;

  @override
  void initState() {
    super.initState();
    _getExercises();
  }

  Future<void> _getExercises() async {
    final loadedExercises =
        await GetIt.I.get<ApiClient>().getExercisesByRecordId(widget.id);
    setState(() {
      _exercises = loadedExercises;
    });
  }

  void pushNewExerciseScreen(BuildContext context) {
    context.pushNamed(
      'new_exercise',
      queryParams: {
        'recordId': widget.id.toString(),
        'recordName': widget.name,
      },
    );
    GoRouter.of(context).addListener(watchRouteChange);
  }

  void pushEditExerciseScreen(BuildContext context, Exercise exercise) {
    context.pushNamed(
      'edit_exercise',
      queryParams: {
        'recordName': widget.name,
        'recordId': widget.id.toString()
      },
      extra: exercise,
    );
    GoRouter.of(context).addListener(watchRouteChange);
  }

  void watchRouteChange() {
    if (!GoRouter.of(context).location.contains('exercises')) {
      _getExercises();
      GoRouter.of(context).removeListener(watchRouteChange);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: RecordAppBar(
        isRunning: _isRunning,
        recordName: widget.name,
        pushNewExerciseScreen: pushNewExerciseScreen,
      ),
      body: _exercises?.when(
        (exercises) => exercises.isEmpty
            ? NoExercises(pushNewExerciseScreen: pushNewExerciseScreen)
            : SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      IndexedStack(
                        index: _index,
                        children: [
                          buildStartButton(),
                          Clock(isRunning: _isRunning),
                        ],
                      ),
                      ExercisesList(
                        exercises: exercises,
                        onRefresh: _getExercises,
                        recordName: widget.name,
                        recordId: widget.id,
                        pushEditExerciseScreen: pushEditExerciseScreen,
                      ),
                      Visibility(
                        visible: _isRunning,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 12.0),
                          child: ElevatedButton(
                            onPressed: () {
                              setState(() {
                                _isRunning = false;
                                _index = 0;
                              });
                            },
                            style: buttonStyle,
                            child: const Text('Finalizar treino'),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
        (DioError e) => buildErrorWidget(e),
      ),
    );
  }

  final ButtonStyle buttonStyle = ElevatedButton.styleFrom(
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.zero,
    ),
    minimumSize: const Size.fromHeight(50),
  );

  ElevatedButton buildStartButton() {
    return ElevatedButton(
      onPressed: () {
        setState(() {
          _isRunning = true;
          _index = 1;
        });
      },
      style: buttonStyle,
      child: const Text(
        'Iniciar o treino atual',
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
