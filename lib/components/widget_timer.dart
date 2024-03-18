import 'package:flutter/material.dart';
import 'package:regatta_timer/providers/timers_v3.dart';

class TimerWidget extends StatelessWidget {
  final Duration time;

  const TimerWidget(this.time, {super.key});

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      fit: BoxFit.contain,
      child: Padding(
        padding: const EdgeInsets.all(1.0),
        child: Text(
          time.format(),
          style: Theme.of(context).textTheme.displaySmall?.copyWith(color: Theme.of(context).colorScheme.onBackground),
        ),
      ),
    );
  }
}
