import 'package:flutter/material.dart';

class Timer extends StatelessWidget {
  final Duration time;

  const Timer(this.time, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      fit: BoxFit.contain,
      child: Padding(
        padding: const EdgeInsets.all(1.0),
        child: Text(
          _formatDuration(time),
          style: Theme.of(context).textTheme.displaySmall,
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
