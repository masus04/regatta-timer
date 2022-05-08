// Provides a Stream of Strings, representing the countdown from the selected Start Time
import 'dart:async';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:regatta_timer/providers/selected_start_time_provider.dart';
import 'package:vibration/vibration.dart';
import 'package:wakelock/wakelock.dart';

/// [timerStreamProvider] provides a StreamProvider<Duration> which in turn provides
/// a Stream<Duration>, which represent the current state of the timer
class TimerNotifier extends StateNotifier<Stream<Duration>> {
  final Ref ref;

  TimerNotifier({required Duration startTime, required this.ref})
      : super(_timerStreamFactory(startTime: startTime)) {
    print("constructor called");
  }

  void reset() {
    state = _timerStreamFactory(
      startTime: Duration(
          minutes:
              -ref.watch(selectedStartTimeProvider.notifier).selectedMinutes),
    );
  }

  Future<void> sync() async {
    // TODO: add rxDart & BehaviorSubject to remove the wait time
    final currentTime = await state.first; // state.last state.single

    final syncedTime = currentTime.inSeconds.remainder(60).abs() >= 30
        ? Duration(
            minutes: currentTime.inMinutes + 1 * currentTime.inMinutes.sign)
        : Duration(minutes: currentTime.inMinutes);

    state = _timerStreamFactory(startTime: syncedTime);
  }

  /// Returns a Stream<Duration>, counting up from [startTime].
  /// Pass a negative [startTime] to count from the negative value to 0
  static Stream<Duration> _timerStreamFactory({required Duration startTime}) {
    return Stream<Duration>.periodic(const Duration(seconds: 1),
        (int t) => startTime + Duration(seconds: t + 1)).asBroadcastStream();
  }
}

final timerProvider =
    StateNotifierProvider<TimerNotifier, Stream<Duration>>((ref) {
  return TimerNotifier(
    startTime: Duration(
        minutes:
            -ref.watch(selectedStartTimeProvider.notifier).selectedMinutes),
    ref: ref,
  );
});

final currentTimeProvider = StreamProvider<Duration>((ref) async* {
  final timeStream = ref.watch(timerProvider);

  await for (final time in timeStream) {
    yield time;
  }
});
