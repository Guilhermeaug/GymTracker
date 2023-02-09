import 'dart:async';

import 'package:flutter/material.dart';

class Clock extends StatefulWidget {
  final bool isRunning;

  const Clock({
    Key? key,
    required this.isRunning,
  }) : super(key: key);

  @override
  State<Clock> createState() => _ClockState();
}

class _ClockState extends State<Clock> {
  Duration _duration = const Duration();
  Timer? _timer;

  @override
  void dispose() {
    super.dispose();
    _timer?.cancel();
  }

  @override
  void didUpdateWidget(covariant Clock oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isRunning) {
      _startTimer();
    } else {
      _duration = const Duration();
      _timer?.cancel();
    }
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      _updateTime();
    });
  }

  void _updateTime() {
    setState(() {
      _duration += const Duration(seconds: 1);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: buildClock(),
    );
  }

  Text buildClock() {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final hours = twoDigits(_duration.inHours);
    final minutes = twoDigits(_duration.inMinutes % 60);
    final seconds = twoDigits(_duration.inSeconds % 60);

    return Text(
      '$hours:$minutes:$seconds',
      textAlign: TextAlign.center,
      style: const TextStyle(
        fontSize: 40,
      ),
    );
  }
}
