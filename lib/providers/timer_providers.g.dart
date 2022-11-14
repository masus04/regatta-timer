// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'timer_providers.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$TimerStateCWProxy {
  TimerState charlyModeState(CharlyModeState charlyModeState);

  TimerState nextStartTimer(Duration nextStartTimer);

  TimerState selectedStartTimeDuration(Duration selectedStartTimeDuration);

  TimerState selectedVibrations(List<VibrationEvent> selectedVibrations);

  TimerState startTime(DateTime startTime);

  TimerState ticker(Stream<Duration?> ticker);

  TimerState timerRunning(bool timerRunning);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `TimerState(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// TimerState(...).copyWith(id: 12, name: "My name")
  /// ````
  TimerState call({
    CharlyModeState? charlyModeState,
    Duration? nextStartTimer,
    Duration? selectedStartTimeDuration,
    List<VibrationEvent>? selectedVibrations,
    DateTime? startTime,
    Stream<Duration?>? ticker,
    bool? timerRunning,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfTimerState.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfTimerState.copyWith.fieldName(...)`
class _$TimerStateCWProxyImpl implements _$TimerStateCWProxy {
  final TimerState _value;

  const _$TimerStateCWProxyImpl(this._value);

  @override
  TimerState charlyModeState(CharlyModeState charlyModeState) =>
      this(charlyModeState: charlyModeState);

  @override
  TimerState nextStartTimer(Duration nextStartTimer) =>
      this(nextStartTimer: nextStartTimer);

  @override
  TimerState selectedStartTimeDuration(Duration selectedStartTimeDuration) =>
      this(selectedStartTimeDuration: selectedStartTimeDuration);

  @override
  TimerState selectedVibrations(List<VibrationEvent> selectedVibrations) =>
      this(selectedVibrations: selectedVibrations);

  @override
  TimerState startTime(DateTime startTime) => this(startTime: startTime);

  @override
  TimerState ticker(Stream<Duration?> ticker) => this(ticker: ticker);

  @override
  TimerState timerRunning(bool timerRunning) =>
      this(timerRunning: timerRunning);

  @override

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `TimerState(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// TimerState(...).copyWith(id: 12, name: "My name")
  /// ````
  TimerState call({
    Object? charlyModeState = const $CopyWithPlaceholder(),
    Object? nextStartTimer = const $CopyWithPlaceholder(),
    Object? selectedStartTimeDuration = const $CopyWithPlaceholder(),
    Object? selectedVibrations = const $CopyWithPlaceholder(),
    Object? startTime = const $CopyWithPlaceholder(),
    Object? ticker = const $CopyWithPlaceholder(),
    Object? timerRunning = const $CopyWithPlaceholder(),
  }) {
    return TimerState(
      charlyModeState: charlyModeState == const $CopyWithPlaceholder() ||
              charlyModeState == null
          ? _value.charlyModeState
          // ignore: cast_nullable_to_non_nullable
          : charlyModeState as CharlyModeState,
      nextStartTimer: nextStartTimer == const $CopyWithPlaceholder() ||
              nextStartTimer == null
          ? _value.nextStartTimer
          // ignore: cast_nullable_to_non_nullable
          : nextStartTimer as Duration,
      selectedStartTimeDuration:
          selectedStartTimeDuration == const $CopyWithPlaceholder() ||
                  selectedStartTimeDuration == null
              ? _value.selectedStartTimeDuration
              // ignore: cast_nullable_to_non_nullable
              : selectedStartTimeDuration as Duration,
      selectedVibrations: selectedVibrations == const $CopyWithPlaceholder() ||
              selectedVibrations == null
          ? _value.selectedVibrations
          // ignore: cast_nullable_to_non_nullable
          : selectedVibrations as List<VibrationEvent>,
      startTime: startTime == const $CopyWithPlaceholder() || startTime == null
          ? _value.startTime
          // ignore: cast_nullable_to_non_nullable
          : startTime as DateTime,
      ticker: ticker == const $CopyWithPlaceholder() || ticker == null
          ? _value.ticker
          // ignore: cast_nullable_to_non_nullable
          : ticker as Stream<Duration?>,
      timerRunning:
          timerRunning == const $CopyWithPlaceholder() || timerRunning == null
              ? _value.timerRunning
              // ignore: cast_nullable_to_non_nullable
              : timerRunning as bool,
    );
  }
}

extension $TimerStateCopyWith on TimerState {
  /// Returns a callable class that can be used as follows: `instanceOfTimerState.copyWith(...)` or like so:`instanceOfTimerState.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$TimerStateCWProxy get copyWith => _$TimerStateCWProxyImpl(this);
}
