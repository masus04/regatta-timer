// Provides a Stream of Strings, representing the countdown from the selected Start Time
import 'dart:async';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:vibration/vibration.dart';
import 'package:wakelock/wakelock.dart';

final startTimerProvider = StateNotifierProvider<SyncedTimerNotifier, Duration>(
  (ref) {
    // Set selected Start Time as initial state
    const selectedStartTime = 0;

    // WakeLock Listener
    final wakeLockListener = TimerListener(
      condition: (Duration tick) => tick == Duration.zero,
      callBack: (Duration tick) => Wakelock.disable(),
    );

    // Vibration Listener
    final vibrationPatterns = [
      _VibrationPattern.exact(
          timeEquals: const Duration(minutes: -5),
          pattern: [100, 500, 100, 500, 100, 500, 100, 500, 100, 500]),
      _VibrationPattern.exact(
          timeEquals: const Duration(minutes: -3),
          pattern: [100, 500, 100, 500, 100, 500]),
      _VibrationPattern.exact(
          timeEquals: const Duration(minutes: -2),
          pattern: [100, 500, 100, 500]),
      _VibrationPattern.exact(
          timeEquals: const Duration(minutes: -1), pattern: [100, 500]),
      _VibrationPattern.exact(
          timeEquals: const Duration(seconds: -30), pattern: [0, 500]),
      _VibrationPattern.exact(
          timeEquals: const Duration(seconds: -20), pattern: [0, 500]),
      _VibrationPattern.exact(
          timeEquals: const Duration(seconds: -10), pattern: [0, 500]),
      _VibrationPattern(
        // Any second between 1 and 9, trigger single short vibration
        triggers: (Duration tick) =>
            const Duration(seconds: -9) <= tick &&
            tick <= const Duration(seconds: -1),
        pattern: [100, 100],
      ),
      _VibrationPattern.exact(timeEquals: Duration.zero, pattern: [0, 2000]),
    ];

    final vibrationListener = TimerListener(
        condition: (Duration tick) => true,
        callBack: (Duration tick) {
          final matchingPatterns =
              vibrationPatterns.where((pattern) => pattern.triggers(tick));

          if (matchingPatterns.isNotEmpty) {
            Vibration.vibrate(pattern: matchingPatterns.first.pattern);
          }
        });

    return SyncedTimerNotifier(-selectedStartTime)
      ..addTimerListener(wakeLockListener)
      ..addTimerListener(vibrationListener);
  },
);

class SyncedTimerNotifier extends StateNotifier<Duration> {
  Duration syncTarget;
  late Stream<Duration> _stream;
  final List<StreamSubscription<Duration>> subscriptions = [];
  List<TimerListener> timerListeners;

  SyncedTimerNotifier(int startTimer)
      : syncTarget = Duration(minutes: startTimer),
        timerListeners = [],
        super(Duration(minutes: startTimer)) {
    // Setup all required streams
    set(syncTarget);

    // Add Refresh listener
    timerListeners.add(
      TimerListener(
        condition: (Duration tick) => tick.inSeconds.remainder(60).abs() == 30,
        callBack: (Duration tick) =>
            syncTarget = Duration(minutes: tick.inMinutes),
      ),
    );
  }

  // Sync Timer to nearest minute
  sync() {
    set(syncTarget);
  }

  // Set Timer to given Duration
  set(Duration timer) {
    // Create new Stream
    state = timer;
    syncTarget = timer;
    _stream = _newTimerStreamFromDuration(timer);

    // Cancel all subscriptions
    for (var subscription in subscriptions) {
      subscription.cancel();
    }

    // Subscribe to new Stream
    final subscription = _stream.listen((tick) {
      state = tick;
    });
    subscriptions.add(subscription);

    // Resubscribe all listeners to new stream
    for (final listener in timerListeners) {
      subscriptions.add(
        _stream
            .where((tick) => listener.condition(tick))
            .listen((tick) => listener.callBack(tick)),
      );
    }
  }

  addTimerListener(TimerListener listener) {
    timerListeners.add(listener);
    subscriptions.add(
      _stream
          .where((tick) => listener.condition(tick))
          .listen((tick) => listener.callBack(tick)),
    );
  }

  clear() {
    for (var sub in subscriptions) {
      sub.cancel();
    }

    _stream.drain();
  }
}

class TimerListener {
  final bool Function(Duration) condition;
  final void Function(Duration) callBack;

  TimerListener({required this.condition, required this.callBack});
}

class _VibrationPattern {
  bool Function(Duration) triggers;
  List<int> pattern;

  _VibrationPattern({required this.triggers, required this.pattern});

  _VibrationPattern.exact({required Duration timeEquals, required this.pattern})
      : triggers = ((Duration tick) => tick == timeEquals);
}

Stream<Duration> _newTimerStreamFromDuration(Duration startTimer) {
  return Stream<Duration>.periodic(const Duration(seconds: 1),
      (int t) => startTimer + Duration(seconds: t + 1)).asBroadcastStream();
}
