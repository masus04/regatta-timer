import 'package:flutter/material.dart';

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
          _formatDuration(time),
          style: Theme.of(context).textTheme.displaySmall?.copyWith(color: Theme.of(context).colorScheme.onBackground),
        ),
      ),
    );
  }
}

String _formatDuration(Duration duration) {
  var hours = duration.inHours.abs();
  var minutes = duration.inMinutes.remainder(60).abs();
  var seconds = duration.inSeconds.remainder(60).abs();

  String stringRep;
  if (hours > 0) {
    stringRep = hours.toString();
    stringRep += ':${minutes.toString().padLeft(2, "0")}';
  } else {
    stringRep = minutes.toString();
  }

  stringRep += ':${(seconds).toString().padLeft(2, "0")}';

  return (duration.isNegative ? '-' : '+') + stringRep;
}
