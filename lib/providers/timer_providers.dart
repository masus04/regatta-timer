import 'dart:async';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:quiver/async.dart';
import 'package:regatta_timer/controllers/notification_controller.dart';
import 'package:regatta_timer/providers/timer_extensions.dart';

/// Extending Duration with Timer specific functionality
extension TimerDuration on Duration {
  static Duration fromTimerSettings({required DateTime timerStartedDate, required Duration startOffset}) {
    // TimeToStart = Now - timerStarted - timeToStart
    // TTS = Now - timerStarted - timeToStart
    final exactTime = timerStartedDate.difference(DateTime.now()) + startOffset;
    // final correctedTTS = correctRounding(exactTime);
    // debugPrint("Corrected TTS: $correctedTTS");
    return Duration(seconds: (exactTime.inMilliseconds / 1000).round());
  }

  String format() {
    return "${inMinutes.abs()}:${(inSeconds.abs() % 60).toString().padLeft(2, '0')}";
  }

  /// Correct for the fact that milliseconds are being rounded when calculating the time to start.
  /// This leads to an error where
  static Duration correctRounding(Duration timeToStart) {
    if (timeToStart.inSeconds >= 0) {
      return timeToStart;
    } else {
      return timeToStart - const Duration(milliseconds: 100);
    }
  }
}

final startOffsetProvider = StateProvider<Duration>((ref) {
  return const Duration(minutes: 5);
});

/// The time at which the timer was started
final _timerStartedProvider = StateProvider<DateTime>((ref) {
  return DateTime.now();
});

class TimerController extends Notifier<Duration> {
  late StreamSubscription<DateTime>? ticker;

  @override
  Duration build() => ref.read(startOffsetProvider);

  void setTimer(Duration timer) {
    ref.read(startOffsetProvider.notifier).state = timer;
  }

  /// Starts the timer with [startOffset] time to the start of the race
  Future<void> start() async {
    final _ = ref.refresh(_timerStartedProvider);

    // Instantly trigger first update
    state = ref.read(startOffsetProvider);

    await ref.read(notificationController.notifier).startOngoingActivity(timeToStart: Duration.zero);

    // final metronome = Metronome.epoch(const Duration(seconds: 1));
    final metronome = Metronome.periodic(
      const Duration(seconds: 1),
      anchor: ref.read(_timerStartedProvider).subtract(const Duration(milliseconds: 50)), // Add 50ms to account for minimal timer delay
    ).asBroadcastStream();

    ticker = metronome.listen(
      (tick) {
        state = TimerDuration.fromTimerSettings(
          timerStartedDate: ref.read(_timerStartedProvider),
          startOffset: ref.read(startOffsetProvider),
        );

        onTick();
      },
    );
  }

  Future<void> stop() async {
    ticker?.cancel();
    ticker = null;

    await ref.read(notificationController.notifier).cancelTimerNotification();
  }

  void sync() {
    stop();

    if ((state.inSeconds % 60) >= 30) {
      // Round up
      ref.read(startOffsetProvider.notifier).state = Duration(minutes: state.inMinutes + 1);
    } else {
      // Round down
      ref.read(startOffsetProvider.notifier).state = Duration(minutes: state.inMinutes);
    }

    start();
  }

  void onTick() {
    ref.read(vibrationsExtension.notifier).tick(state);
    ref.read(soundExtension.notifier).tick(state);
    ref.read(notificationExtension.notifier).tick(state);

    // Call charlyMode after anything that should react to the start, as it will restart the timer
    ref.read(charlyModeExtension.notifier).tick(state);

    // Call PostStartExtension after charlyMode, for if charlyMode triggers, postStart should not
    ref.read(postStartExtension.notifier).tick(state);
  }
}

final timerController = NotifierProvider<TimerController, Duration>(TimerController.new);
