import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:regatta_timer/views/providers/_providers.dart';
import 'package:regatta_timer/views/widgets/_widgets.dart';

import '../constants.dart';
import 'providers/page_provider.dart';

class TimerView extends HookWidget {
  const TimerView({required Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final pagesNotifier = useProvider(pageNotifierProvider.notifier);
    final timeNotifier = useProvider(startTimerNotifier.notifier);
    final time = useProvider(startTimerNotifier);

    onSync() {
      timeNotifier.sync();
    }

    onLap() {
      timeNotifier.set(Duration.zero);
    }

    return TimerLayout(
      title: 'Racing',
      body: const _RaceTimer(
        key: Key('RaceTimer'),
      ),
      button: TimerButton(
        text: time < Duration.zero ? 'Sync' : 'Lap',
        onPressed: time < Duration.zero ? onSync : onLap,
        key: const Key('ResetButton'),
        secondaryButton: TextButton(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(Colors.red),
          ),
          child: const Text(
            'Reset',
            style: TextStyle(color: Colors.white),
          ),
          onPressed: () {
            pagesNotifier.removeLast();
            timeNotifier.clear();
          },
        ),
      ),
      key: const Key('TimerViewLayout'),
    );
  }
}

class _RaceTimer extends HookWidget {
  const _RaceTimer({required Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // const String time = '3:30';

    final time = useProvider(startTimerNotifier);

    return Container(
      alignment: Alignment.center,
      child: _RaceTimerText(
        time: time,
        key: const Key('RaceTimerData'),
      ),
    );
  }
}

class _RaceTimerText extends HookWidget {
  final Duration time;

  const _RaceTimerText({required this.time, required Key key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isWatch = useProvider(isWatchProvider);

    return Text(
      _formatDuration(time),
      style: TextStyle(
          fontSize: isWatch ? TextSize.watch * 2 : TextSize.other * 2.5,
          // color: time.isNegative ? Colors.red : Colors.green,
          fontWeight: FontWeight.bold,
          letterSpacing: 2),
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

  stringRep += ':${seconds.toString().padLeft(2, "0")}';

  return (duration.isNegative ? '-' : '') + stringRep;
}
