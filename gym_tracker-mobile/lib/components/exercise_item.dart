import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class ExerciseItem extends StatefulWidget {
  final int id;
  final String name;
  final int series;
  final int repetitions;

  const ExerciseItem({
    Key? key,
    required this.id,
    required this.name,
    required this.series,
    required this.repetitions,
  }) : super(key: key);

  @override
  State<ExerciseItem> createState() => _ExerciseItemState();
}

class _ExerciseItemState extends State<ExerciseItem> {
  final List<bool> _series = [];

  @override
  void initState() {
    super.initState();
    _series.addAll(List.generate(widget.series, (_) => false));
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Container(
      constraints: BoxConstraints(
        minHeight: size.height * 0.15,
      ),
      child: Card(
        color: Theme.of(context).colorScheme.primaryContainer,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              AutoSizeText(
                widget.name,
                maxLines: 2,
                minFontSize: 16,
                maxFontSize: 20,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onPrimaryContainer,
                ),
              ),
              Wrap(
                spacing: 5,
                children: [
                  for (var i = 0; i < widget.series; i++)
                    InkWell(
                      onTap: () {
                        setState(() {
                          _series[i] = !_series[i];
                        });
                      },
                      child: Container(
                        width: size.width * 0.1,
                        height: size.width * 0.1,
                        padding: const EdgeInsets.all(8.0),
                        decoration: BoxDecoration(
                          color: _series[i]
                              ? Theme.of(context).colorScheme.primary
                              : Theme.of(context).colorScheme.primaryContainer,
                          border: Border.all(
                            color: Theme.of(context).colorScheme.onPrimary,
                          ),
                        ),
                        child: Center(
                          child: Text(
                            widget.repetitions.toString(),
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.onPrimary,
                            ),
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
