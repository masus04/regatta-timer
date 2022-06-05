// Provides a Stream of Strings, representing the countdown from the selected Start Time
import 'dart:async';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:regatta_timer/constants.dart';
import 'package:regatta_timer/providers/selected_start_time_provider.dart';
import 'package:regatta_timer/providers/settings_provider.dart';
import 'package:regatta_timer/views/components/vibration.dart';

/// [timerStreamProvider] provides a StreamProvider<Duration> which in turn provides
/// a Stream<Duration>, which represent the current state of the timer
class TimerNotifier extends StateNotifier<Stream<Duration>> {
  final Ref ref;

  late Duration syncTarget;

  StreamSubscription<Duration>? _syncSubscription;
  StreamSubscription<VibrationEvent>? _vibrationSubscription;

  TimerNotifier({required this.ref}) : super(const Stream.empty()) {
    reset();
  }

  /// Replace the state stream and handle subscriptions in order to update [syncTarget]
  @override
  set state(Stream<Duration> newState) {
    // Cancel all subscriptions
    _syncSubscription?.cancel();
    _vibrationSubscription?.cancel();

    super.state = newState;
    final vibrationPatterns = ref.read(settingsProvider).selectedVibrations;

    // Create & subscribe to new sync stream
    _syncSubscription = state
        .where((timeStep) => timeStep.inSeconds % 60 == 30)
        .listen((syncTimeStep) {
      syncTarget = Duration(minutes: syncTimeStep.inMinutes);
    });

    // Create & subscribe to new vibration stream
    _vibrationSubscription = state
        .where(
          // Filter for matched vibration patterns
          (timeStep) => vibrationPatterns
              .any((vibration) => vibration.activationTimeStep == timeStep),
        )
        .map(
          // map to matching vibration pattern
          (timeStep) => vibrationPatterns.firstWhere(
              (vibration) => timeStep == vibration.activationTimeStep),
        )
        .listen(
          // listen to resulting stream and execute pattern when triggered
          (triggeredVibration) => triggeredVibration.execute(),
        );
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

  void abort() {
    state = const Stream.empty();
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
