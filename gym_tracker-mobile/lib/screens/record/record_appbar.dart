import 'package:flutter/material.dart';

class RecordAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String recordName;
  final bool isRunning;
  final void Function(BuildContext context) pushNewExerciseScreen;

  const RecordAppBar({
    Key? key,
    required this.recordName,
    required this.isRunning,
    required this.pushNewExerciseScreen,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(recordName),
      actions: [
        Visibility(
          visible: !isRunning,
          child: PopupMenuButton(
            icon: const Icon(Icons.more_vert),
            itemBuilder: (BuildContext context) {
              return [
                const PopupMenuItem(
                  value: 1,
                  child: Text('Criar'),
                ),
              ];
            },
            onSelected: (value) {
              switch (value) {
                case 1:
                  pushNewExerciseScreen(context);
              }
            },
          ),
        )
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
