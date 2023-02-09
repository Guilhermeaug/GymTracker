import 'package:go_router/go_router.dart';

import 'models/exercise.dart';
import 'screens/home/home_screen.dart';
import 'screens/new-exercise_screen.dart';
import 'screens/record/record_screen.dart';

final router = GoRouter(
  routes: [
    GoRoute(
      name: 'home',
      path: '/',
      builder: (context, state) => const HomeScreen(),
    ),
    GoRoute(
      name: 'record',
      path: '/records/:id',
      builder: (context, state) => RecordScreen(
        id: int.parse(state.params['id']!),
        name: state.queryParams['name']!,
      ),
    ),
    GoRoute(
      name: 'new_exercise',
      path: '/exercises/create',
      builder: (context, state) => NewExerciseScreen(
        recordId: int.parse(state.queryParams['recordId']!),
        recordName: state.queryParams['recordName']!,
        operation: Operation.add,
      ),
    ),
    GoRoute(
      name: 'edit_exercise',
      path: '/exercises/edit',
      builder: (context, state) => NewExerciseScreen(
        recordId: int.parse(state.queryParams['recordId']!),
        recordName: state.queryParams['recordName']!,
        operation: Operation.edit,
        exercise: state.extra as Exercise,
      ),
    ),
  ],
);
