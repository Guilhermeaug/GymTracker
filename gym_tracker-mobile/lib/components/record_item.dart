import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class RecordItem extends StatelessWidget {
  final int id;
  final String name;
  final String bodyParts;

  const RecordItem({
    Key? key,
    required this.id,
    required this.name,
    required this.bodyParts,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          ListTile(
            leading: const FaIcon(FontAwesomeIcons.dumbbell),
            title: Text(name),
            subtitle: Text(bodyParts),
          ),
        ],
      ),
    );
  }
}
