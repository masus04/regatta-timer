// Provides a Stream of Strings, representing the countdown from the selected Start Time
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:regatta_timer/providers/selected_start_time_provider.dart';
import 'package:regatta_timer/providers/settings_provider.dart';
import 'package:regatta_timer/types/vibration.dart';

class TimerNotifier extends StateNotifier<Duration?> {
  final Ref _ref;

  // The exact time of the race start, according to the current start timer
  DateTime? startTime;

  late Stream<DateTime> _tickStream;
  StreamSubscription<DateTime>? _stateUpdateSubscription;
  StreamSubscription<VibrationEvent>? _vibrationSubscription;

  TimerNotifier(this._ref) : super(Duration.zero) {
    reset();
  }

  void reset() {
    // Read timer parameters
    final DateTime now = DateTime.now();
    final selectedStartTimer = _ref.watch(selectedStartTimeProvider.notifier).selectedDuration;
    startTime = now.add(selectedStartTimer);
    state = now.difference(startTime!);

    debugPrint("selectedStartTimer: ${selectedStartTimer.toString()}, \n"
        "state: $state, \n"
        "startTime: ${startTime.toString()}");

    _initTicker();
  }

  void _initTicker() {
    _stateUpdateSubscription?.cancel();

    _tickStream = Stream.periodic(const Duration(seconds: 1), (int t) => DateTime.now()).asBroadcastStream();

    _stateUpdateSubscription = _tickStream.listen((DateTime t) {
      final diff = DateTime.now().difference(startTime!);
      state = Duration(
        hours: diff.inHours,
        minutes: diff.inMinutes,
        seconds: (diff.inMilliseconds / 1000).round().remainder(60),
      );
      // debugPrint("Update state: $state, startTime: $startTime, now: {DateTime.now()}");
    });

    _initVibrations();
  }

  void _initVibrations() {
    _vibrationSubscription?.cancel();

    final vibrationPatterns = _ref.read(settingsProvider).selectedVibrations;

    _vibrationSubscription = _tickStream
        .where((DateTime t) => vibrationPatterns.any((vibration) => vibration.activationTimeStep == state))
        .map((DateTime t) => vibrationPatterns.firstWhere((vibration) => state == vibration.activationTimeStep))
        .listen((triggeredVibration) => triggeredVibration.execute());
  }

  sync() {
    final DateTime now = DateTime.now();
    final Duration exactTimeToStart = now.difference(startTime!).abs();

    final remainingMinutes = exactTimeToStart.inMinutes % 60;
    final remainingSeconds = exactTimeToStart.inSeconds % 60;
    final bool roundUpSeconds = remainingSeconds > 30;

    final startOffset = Duration(
      hours: exactTimeToStart.inHours,
      minutes: roundUpSeconds ? remainingMinutes + 1 : remainingMinutes,
      seconds: 0,
    );

    startTime = now.add(startOffset);
    state = -startOffset;
    _initTicker();

    debugPrint("Synced Start Timer:\n new startTime: $startTime,\n new state: $state");
  }

  void abort() {
    _stateUpdateSubscription?.cancel();
    _vibrationSubscription?.cancel();
  }
}

final timerProvider = StateNotifierProvider<TimerNotifier, Duration?>((ref) {
  return TimerNotifier(ref);
});
