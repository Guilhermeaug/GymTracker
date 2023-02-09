import 'package:flutter/material.dart';

import '../../utils/time_utils.dart';

class Header extends StatelessWidget {
  const Header({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final size = MediaQuery.of(context).size;

    return Container(
      width: double.infinity,
      height: size.height * 0.15,
      decoration: BoxDecoration(
        color: colorScheme.primaryContainer,
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(40),
          bottomRight: Radius.circular(40),
        ),
      ),
      child: Wrap(
        alignment: WrapAlignment.center,
        runSpacing: 15,
        children: [
          Text(
            'Gym Tracker',
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              letterSpacing: 1.5,
              color: colorScheme.onPrimaryContainer,
            ),
          ),
          Text('${TimeUtils.getCompliment()}, Guilherme Oliveira'),
        ],
      ),
    );
  }
}
