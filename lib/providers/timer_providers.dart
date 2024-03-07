import 'package:flutter/foundation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:regatta_timer/controllers/notification_controller.dart';
import 'package:regatta_timer/providers/settings_provider.dart';
import 'package:regatta_timer/providers/timer_extensions.dart';
import 'package:regatta_timer/types/sound_events.dart';

final _timerRunningProvider = StateProvider<bool>((ref) {
  return false;
});

final startOffsetProvider = StateProvider<Duration>((ref) {
  return const Duration(minutes: 5);
});

final startDateProvider = StateProvider<DateTime>((ref) {
  return DateTime.now().add(ref.watch(startOffsetProvider));
});

final charlyModeEnabledProvider = StateProvider<bool>((ref) {
  return false;
});

final timeToStartProvider = StreamProvider<Duration>((ref) async* {
  final ticker = Stream.periodic(const Duration(milliseconds: 100)).map(
    (_) => -ref.read(startDateProvider).difference(DateTime.now()),
  );

  await for (Duration timeToStart in ticker) {
    if (!(ref.read(_timerRunningProvider) && timeToStart.inMilliseconds % 1000 <= 100 && timeToStart.inMilliseconds % 1000 > 0)) {
      continue;
    }

    // timeToStart = Duration(seconds: timeToStart.inSeconds);

    // Charly Mode
    if (ref.read(settingsProvider).charlyModeToggleEnabled && ref.read(charlyModeEnabledProvider)) {
      timeToStart = CharlyMode.ticker(timeToStart: timeToStart, offset: CharlyMode.halfRoundDown(duration: ref.read(startOffsetProvider)));
    }

    // Correct for rounding down
    if (timeToStart < Duration.zero) {
      timeToStart = Duration(seconds: timeToStart.inSeconds - 1);
    } else {
      timeToStart = Duration(seconds: timeToStart.inSeconds);
    }

    // DEBUG print for charly mode transitions
    // final sec = timeToStart.abs().inSeconds % 60;
    // if (sec < 3 || sec > 57) {
    //   debugPrint("charlyTransition: $timeToStart");
    // }

    // Vibration Effects
    VibrationsExtension.ticker(timeToStart: timeToStart, selectedVibrations: ref.read(settingsProvider).selectedVibrations);

    // Sound Effects
    if (ref.read(settingsProvider).soundEventsEnabled) {
      SoundExtension().ticker(timeToStart: timeToStart, soundEvents: SoundEvent.values);
    }

    // Update Notification
    NotificationExtension.ticker(timeToStart: timeToStart);

    yield timeToStart;
  }
});

class TimerController extends Notifier<void> {
  @override
  void build() {}

  static void setTimer(WidgetRef ref, Duration timer) {
    // debugPrint("Setting timer to $timer");
    ref.read(startOffsetProvider.notifier).state = timer;
  }

  static void startTimer(WidgetRef ref) {
    // debugPrint("Starting Timer");
    ref.read(_timerRunningProvider.notifier).state = true;
  }

  static void stopTimer(WidgetRef ref) {
    // debugPrint("Stopping Timer");
    ref.read(_timerRunningProvider.notifier).state = false;
    NotificationController.cancelTimerNotification();
  }

  static void resetTimer(WidgetRef ref) {
    // debugPrint("Resetting Timer");
    ref.invalidate(startDateProvider);
  }

  static void syncTimer(WidgetRef ref) {
    final timeToStart = ref.read(timeToStartProvider).value;

    if (timeToStart == null) {
      return;
    }

    final DateTime newStartTime;
    if (timeToStart.inSeconds.abs() % 60 >= 30) {
      newStartTime = DateTime.now().add((Duration(minutes: timeToStart.inMinutes.abs() + 1)));
    } else {
      newStartTime = DateTime.now().add((Duration(minutes: timeToStart.inMinutes.abs())));
    }

    debugPrint("Syncing Timer to ${newStartTime.toLocal()}");
    ref.read(startDateProvider.notifier).state = newStartTime;
  }
}

final timerControllerProvider = NotifierProvider<TimerController, void>(TimerController.new);
