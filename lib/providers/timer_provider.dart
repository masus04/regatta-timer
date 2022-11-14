// Provides a Stream of Strings, representing the countdown from the selected Start Time
import 'dart:async';

import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:regatta_timer/providers/settings_provider.dart';
import 'package:regatta_timer/types/vibration.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'timer_provider.g.dart';

const int _defaultStartTimeIndex = 4;

enum _SharedPrefsKeys { selectedTimer }

@CopyWith()
class TimerNotifierState {
  final DateTime startTime;
  final Duration nextStartDuration;
  final int selectedStartTimeIndex;

  // final Stream<DateTime>? tickStream;
  // final StreamSubscription<DateTime>? stateUpdateSubscription;
  // final StreamSubscription<VibrationEvent>? vibrationSubscription;

  TimerNotifierState({
    required this.startTime,
    required this.nextStartDuration,
    required this.selectedStartTimeIndex,
    // this.tickStream,
    // this.stateUpdateSubscription,
    // this.vibrationSubscription,
  });
}

class TimerNotifier extends StateNotifier<TimerNotifierState?> {
  final Ref _ref;
  late final Future<SharedPreferences> prefs = SharedPreferences.getInstance();

  // The exact time of the race start, according to the current start timer
  // DateTime? startTime;

  late Stream<DateTime> _tickStream;
  StreamSubscription<DateTime>? _stateUpdateSubscription;
  StreamSubscription<VibrationEvent>? _vibrationSubscription;

  TimerNotifier(this._ref, {required int selectedStartTimeIndex}) : super(null) {
    init();
  }

  void init() async {
    final index = await _getSelectedStartTimeIndexFromPrefs();
    final nextStartDuration = _nextStartingDuration(selectedStartTimeIndex: index);
    final startTime = DateTime.now().add(nextStartDuration);

    state = TimerNotifierState(
      startTime: startTime,
      nextStartDuration: nextStartDuration,
      selectedStartTimeIndex: index,
    );

    _initTicker();
  }

  void abort() {
    _stateUpdateSubscription?.cancel();
    _vibrationSubscription?.cancel();
  }

  void setSelectedTimeIndex(int newValue) {
    state = state!.copyWith(selectedStartTimeIndex: newValue);

    _setIntToSharedPreferences(_SharedPrefsKeys.selectedTimer, newValue);
  }

  /// Resets the application for a new start
  /// If a [nextStartDuration] is passed, use it as the new start timer duration, else retrieves the new duration from the selected timer.
  void reset({Duration? nextStartDuration}) {
    // Read timer parameters
    final DateTime now = DateTime.now();
    final startDuration = nextStartDuration ?? _nextStartingDuration(selectedStartTimeIndex: state!.selectedStartTimeIndex);
    final startTime = now.add(startDuration);

    state!.copyWith(
      startTime: startTime,
      nextStartDuration: startDuration,
    );

    debugPrint("selectedStartTimer: ${nextStartDuration.toString()}, \n"
        "state (Start in): $state, \n"
        "startTime: ${startTime.toString()}");

    _initTicker();
  }

  void _initTicker() {
    _stateUpdateSubscription?.cancel();

    _tickStream = Stream.periodic(const Duration(seconds: 1), (int t) => DateTime.now()).asBroadcastStream();

    _stateUpdateSubscription = _tickStream.listen(
      (DateTime t) {
        final diff = DateTime.now().difference(state!.startTime);
        state!.copyWith(
          nextStartDuration: Duration(
            seconds: (diff.inMilliseconds / 1000).round(),
          ),
        );
      },
    );

    _initVibrations();
  }

  void _initVibrations() {
    _vibrationSubscription?.cancel();

    final vibrationPatterns = _ref.read(settingsProvider).selectedVibrations;

    _vibrationSubscription = _tickStream
        .where(
          (DateTime t) => vibrationPatterns.any((vibration) => state!.nextStartDuration == vibration.activationTimeStep),
        )
        .map(
          (DateTime t) => vibrationPatterns.firstWhere((vibration) => state!.nextStartDuration == vibration.activationTimeStep),
        )
        .listen(
          (triggeredVibration) => triggeredVibration.execute(),
        );
  }

  sync() {
    final DateTime now = DateTime.now();
    final Duration exactTimeToStart = now.difference(state!.startTime).abs();

    final remainingMinutes = exactTimeToStart.inMinutes % 60;
    final remainingSeconds = exactTimeToStart.inSeconds % 60;
    final bool roundUpSeconds = remainingSeconds > 30;

    final startOffset = Duration(
      hours: exactTimeToStart.inHours,
      minutes: roundUpSeconds ? remainingMinutes + 1 : remainingMinutes,
      seconds: 0,
    );

    state = state!.copyWith(
      startTime: now.add(startOffset),
      nextStartDuration: -startOffset,
    );
    _initTicker();

    debugPrint("Synced Start Timer:\n new startTime: ${state!.startTime},\n new state: $state");
  }

  Future<int> _getSelectedStartTimeIndexFromPrefs() async {
    final preferences = await prefs;
    return preferences.getInt(_SharedPrefsKeys.selectedTimer.name) ?? _defaultStartTimeIndex;
  }

  void _setIntToSharedPreferences(_SharedPrefsKeys key, int value) async {
    (await prefs).setInt(key.name, value);
  }

  Duration _nextStartingDuration({required int selectedStartTimeIndex}) {
    return _ref.watch(settingsProvider).selectedStartTimeOptions[selectedStartTimeIndex].startTime;
  }
}

final timerProvider = StateNotifierProvider<TimerNotifier, TimerNotifierState?>((ref) {
  return TimerNotifier(ref, selectedStartTimeIndex: 4);
});
