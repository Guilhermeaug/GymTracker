import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HomeAppBar extends StatelessWidget {
  const HomeAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return SliverAppBar(
      backgroundColor: colorScheme.primaryContainer,
      actions: [
        IconButton(
          onPressed: () {},
          icon: FaIcon(
            FontAwesomeIcons.solidCircleUser,
            color: colorScheme.inversePrimary,
            size: 30,
          ),
        ),
      ],
    );
  }
}
