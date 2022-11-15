import 'dart:async';
import 'dart:math';

import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:flutter/cupertino.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:regatta_timer/providers/charly_mode_provider.dart';
import 'package:regatta_timer/providers/settings_provider.dart';
import 'package:regatta_timer/types/vibration.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'timer_providers.g.dart';

enum _SharedPrefsKeys { selectedTimer }

class TimerOptionIndexNotifier extends StateNotifier<int> {
  late final SharedPreferences prefs;

  TimerOptionIndexNotifier(super.state) {
    _init();
  }

  _init() async {
    prefs = await SharedPreferences.getInstance();

    final storedIndex = prefs.getInt(_SharedPrefsKeys.selectedTimer.name);

    if (storedIndex != null) {
      state = storedIndex;
    } else {
      prefs.setInt(_SharedPrefsKeys.selectedTimer.name, state);
    }
  }

  set index(int index) {
    state = index;
    prefs.setInt(_SharedPrefsKeys.selectedTimer.name, state);
  }
}

final timerOptionIndexProvider = StateNotifierProvider<TimerOptionIndexNotifier, int>((ref) {
  const defaultStartTimeIndex = 5;

  final initialIndex = min(defaultStartTimeIndex, ref.read(settingsProvider).selectedStartTimeOptions.length);
  return TimerOptionIndexNotifier(initialIndex);
});

final startOffsetProvider = StateProvider<Duration>((ref) {
  final index = ref.watch(timerOptionIndexProvider);

  return ref.watch(settingsProvider).selectedStartTimeDuration(index);
});

final startDateProvider = StateProvider<DateTime>((ref) {
  return DateTime.now().add(ref.watch(startOffsetProvider));
});

@CopyWith()
class TimerState {
  final DateTime startTime;
  final Duration nextStartTimer;
  final bool timerRunning;
  final List<VibrationEvent> selectedVibrations;
  final Duration selectedStartTimeDuration;

  final Stream<Duration?> ticker;

  final CharlyModeState charlyModeState;

  TimerState({
    required this.startTime,
    required this.nextStartTimer,
    required this.timerRunning,
    required this.selectedVibrations,
    required this.ticker,
    required this.selectedStartTimeDuration,
    required this.charlyModeState,
  });
}

class TimerNotifier extends StateNotifier<TimerState> {
  final List<StreamSubscription> streamSubscriptions = [];

  TimerNotifier(super.state) {
    _init();
  }

  Duration get startTimeOffset {
    return Duration(
      seconds: (DateTime.now().difference(state.startTime).inMilliseconds / 1000).round(),
    );
  }

  void _init() {
    // Init timer update
    final subscription = state.ticker.listen((_) {
      state = state.copyWith(
        nextStartTimer: startTimeOffset,
      );
    });

    streamSubscriptions.add(subscription);

    _initCharlyMode();
    _initVibrations();
  }

  _initCharlyMode() {
    if (state.charlyModeState.enabled) {
      final subscription = state.ticker.where(
        (_) {
          return startTimeOffset.inSeconds == 1;
        },
      ).listen(
        (_) {
          final nextCharlyState = state.charlyModeState.nextState();

          if (nextCharlyState.enabled) {
            debugPrint("Timer reset due to Charly Mode. New start time: ${nextCharlyState.nextStartDuration}");
            state = state.copyWith(
              startTime: getNewStartTime(nextCharlyState.nextStartDuration),
              nextStartTimer: -nextCharlyState.nextStartDuration,
              ticker: TimerNotifier.getTicker(),
              charlyModeState: nextCharlyState,
            );
          }
        },
      );
      streamSubscriptions.add(subscription);
    }
  }

  void _initVibrations() {
    final subscription = state.ticker
        .where(
          (_) => state.selectedVibrations.any((vibration) => startTimeOffset == vibration.activationTimeStep),
        )
        .map(
          (_) => state.selectedVibrations.firstWhere((vibration) => startTimeOffset == vibration.activationTimeStep),
        )
        .listen(
          (triggeredVibration) => triggeredVibration.execute(),
        );

    streamSubscriptions.add(subscription);
  }

  void reset() {
    state = state.copyWith(
      startTime: getNewStartTime(state.selectedStartTimeDuration),
      nextStartTimer: -state.selectedStartTimeDuration,
      ticker: TimerNotifier.getTicker(),
    );

    stop();
    _init();
  }

  void sync() {
    final offset = Duration(
      minutes: state.nextStartTimer.inMinutes.abs(),
      seconds: state.nextStartTimer.inSeconds.remainder(60).abs() >= 30 ? 60 : 0,
    );

    state = state.copyWith(
      startTime: getNewStartTime(offset),
      nextStartTimer: -offset,
      ticker: TimerNotifier.getTicker(),
    );

    _init();
  }

  void stop() {
    for (final subscription in streamSubscriptions) {
      subscription.cancel();
    }
  }

  @override
  void dispose() {
    stop();
    super.dispose();
  }

  static Stream<Duration?> getTicker() => Stream<Duration?>.periodic(const Duration(seconds: 1)).asBroadcastStream();

  static DateTime getNewStartTime(Duration offset) => DateTime.now().add(offset);
}

final timerProvider = StateNotifierProvider<TimerNotifier, TimerState>((ref) {
  return TimerNotifier(
    TimerState(
      startTime: ref.watch(startDateProvider),
      nextStartTimer: -ref.watch(startOffsetProvider),
      timerRunning: false,
      selectedVibrations: ref.watch(settingsProvider).selectedVibrations,
      ticker: TimerNotifier.getTicker(),
      selectedStartTimeDuration: ref.watch(startOffsetProvider),
      charlyModeState: ref.watch(charlyModeProvider),
    ),
  );
});
