// Provides a Stream of Strings, representing the countdown from the selected Start Time
import 'dart:async';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:regatta_timer/providers/selected_start_time_provider.dart';
import 'package:vibration/vibration.dart';
import 'package:wakelock/wakelock.dart';

/// [timerStreamProvider] provides a StreamProvider<Duration> which in turn provides
/// a Stream<Duration>, which represent the current state of the timer
class TimerNotifier extends StateNotifier<StreamProvider<Duration>> {
  final StateNotifierProviderRef ref;

  TimerNotifier({required this.ref}) : super(_timerProviderFactory()) {
    reset();
  }

  Stream<Duration> reset() async* {
    state = _timerProviderFactory();
  }

  void sync() {
    final currentTime = ref.watch(state).value!;

    final syncedTime = currentTime.inSeconds % 60 >= 30
        ? Duration(minutes: currentTime.inMinutes % 60 + 1)
        : Duration(minutes: currentTime.inMinutes % 60);

    state = _timerProviderFactory(startTime: syncedTime);
  }

  /// Returns a StreamProvider<Duration>, which in turn provides a Stream<Duration> representing the current timer state
  /// If [startTime] == null, use [selectedStartTimeProvider]'s value (selected start time in UI).
  static StreamProvider<Duration> _timerProviderFactory({Duration? startTime}) {
    return StreamProvider<Duration>((ref) async* {
      final _startTime = startTime ??
          Duration(
              minutes: ref
                  .watch(selectedStartTimeProvider.notifier)
                  .selectedMinutes);

      final timerStream = _timerStreamFactory(_startTime);
      yield _startTime;

      await for (final time in timerStream) {
        yield time;
      }
    });
  }

  /// Returns a Stream<Duration>, counting up from [startTime].
  /// Pass a negative [startTime] to count from the negative value to 0
  static Stream<Duration> _timerStreamFactory(Duration startTimer) {
    return Stream<Duration>.periodic(const Duration(seconds: 1),
        (int t) => -startTimer + Duration(seconds: t + 1)).asBroadcastStream();
  }
}

final timerProvider =
    StateNotifierProvider<TimerNotifier, StreamProvider<Duration>>((ref) {
  return TimerNotifier(
    ref: ref,
  );
});
