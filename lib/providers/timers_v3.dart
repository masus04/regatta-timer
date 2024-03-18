import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:quiver/async.dart';
import 'package:regatta_timer/controllers/notification_controller.dart';

/// Extending Duration with Timer specific functionality
extension TimerDuration on Duration {
  static Duration fromTimerSettings({required DateTime timerStartedDate, required Duration startOffset}) {
    return DateTime.now().difference(timerStartedDate) - startOffset;
  }

  String format() {
    return "${-inMinutes}:${(-inSeconds % 60).toString().padLeft(2, '0')}";
  }
}

/// The time at which the timer was started
final _timerStartedProvider = StateProvider<DateTime>((ref) {
  return DateTime.now();
});

class TimerController extends Notifier<Duration> {
  late StreamSubscription<Duration>? ticker;
  final void Function(Duration) onTick;

  TimerController({this.onTick = TimerController.defaultOnTick});

  @override
  Duration build() => Duration.zero;

  /// Starts the timer with [startOffset] time to the start of the race
  Future<void> start({required Duration startOffset}) async {
    ref.refresh(_timerStartedProvider);

    final metronome = Metronome.epoch(const Duration(seconds: 1));

    final ticker = metronome.listen(
      (tick) {
        // TimeToStart = Now - timerStarted - timeToStart
        state = TimerDuration.fromTimerSettings(timerStartedDate: ref.read(_timerStartedProvider), startOffset: startOffset);
        debugPrint("TimeToStart: ${state.toString()}");

        onTick(state);
      },
    );

    await ref.read(notificationController.notifier).startOngoingActivity(timeToStart: Duration.zero);
  }

  Future<void> stop() async {
    ticker?.cancel();
    ticker = null;

    await ref.read(notificationController.notifier).cancelTimerNotification();
  }

  void sync() {
    final seconds = state.inSeconds % 60;
    start(
      startOffset: seconds >= 30
          ? Duration(
              minutes: state.inMinutes + 1,
            )
          : Duration(
              minutes: state.inMinutes + 1,
            ),
    );
  }

  /// By default, do not trigger anything on any given tick
  static defaultOnTick(Duration duration) {}
}

final timerController = NotifierProvider<TimerController, void>(TimerController.new);
