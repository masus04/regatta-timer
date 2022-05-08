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

  late Duration syncTarget;

  StreamSubscription<Duration>? _syncSubscription;
  StreamSubscription<Duration>? _startSubscription;

  TimerNotifier({required this.ref}) : super(const Stream.empty()) {
    reset();
  }

  /// Replace the state stream and handle subscriptions in order to update [syncTarget]
  @override
  set state(Stream<Duration> newState) {
    // Cancel all subscriptions
    _syncSubscription?.cancel();
    _startSubscription?.cancel();

    super.state = newState;

    // Create & subscribe to new sync stream
    _syncSubscription = state
        .where((timeStep) => timeStep.inSeconds % 60 == 30)
        .listen((syncTimeStep) {
      syncTarget = Duration(minutes: syncTimeStep.inMinutes);
    });

    // Create & subscribe to new start stream
    _startSubscription =
        state.where((timeStep) => timeStep.inSeconds == 0).listen((event) {
          // Race starts
          Wakelock.disable();

        });

    // Enable Wakelock since the timer is in a pre start state
    Wakelock.enable();
  }

  /// Reset timer to selected start time
  void reset() {
    final selectedStartTime =
        -ref.watch(selectedStartTimeProvider.notifier).selectedDuration;

    syncTarget = selectedStartTime;
    state = _timerStreamFactory(startTime: selectedStartTime);
  }

  /// Reset timer to closest minute (rounding down)
  void sync() {
    state = _timerStreamFactory(startTime: syncTarget);
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
    ref: ref,
  );
});

final currentTimeProvider = StreamProvider<Duration>((ref) async* {
  final timeStream = ref.watch(timerProvider);

  await for (final time in timeStream) {
    yield time;
  }
});
