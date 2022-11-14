// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'timer_provider.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$TimerNotifierStateCWProxy {
  TimerNotifierState nextStartDuration(Duration nextStartDuration);

  TimerNotifierState selectedStartTimeIndex(int selectedStartTimeIndex);

  TimerNotifierState startTime(DateTime startTime);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `TimerNotifierState(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// TimerNotifierState(...).copyWith(id: 12, name: "My name")
  /// ````
  TimerNotifierState call({
    Duration? nextStartDuration,
    int? selectedStartTimeIndex,
    DateTime? startTime,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfTimerNotifierState.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfTimerNotifierState.copyWith.fieldName(...)`
class _$TimerNotifierStateCWProxyImpl implements _$TimerNotifierStateCWProxy {
  final TimerNotifierState _value;

  const _$TimerNotifierStateCWProxyImpl(this._value);

  @override
  TimerNotifierState nextStartDuration(Duration nextStartDuration) =>
      this(nextStartDuration: nextStartDuration);

  @override
  TimerNotifierState selectedStartTimeIndex(int selectedStartTimeIndex) =>
      this(selectedStartTimeIndex: selectedStartTimeIndex);

  @override
  TimerNotifierState startTime(DateTime startTime) =>
      this(startTime: startTime);

  @override

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `TimerNotifierState(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// TimerNotifierState(...).copyWith(id: 12, name: "My name")
  /// ````
  TimerNotifierState call({
    Object? nextStartDuration = const $CopyWithPlaceholder(),
    Object? selectedStartTimeIndex = const $CopyWithPlaceholder(),
    Object? startTime = const $CopyWithPlaceholder(),
  }) {
    return TimerNotifierState(
      nextStartDuration: nextStartDuration == const $CopyWithPlaceholder() ||
              nextStartDuration == null
          ? _value.nextStartDuration
          // ignore: cast_nullable_to_non_nullable
          : nextStartDuration as Duration,
      selectedStartTimeIndex:
          selectedStartTimeIndex == const $CopyWithPlaceholder() ||
                  selectedStartTimeIndex == null
              ? _value.selectedStartTimeIndex
              // ignore: cast_nullable_to_non_nullable
              : selectedStartTimeIndex as int,
      startTime: startTime == const $CopyWithPlaceholder() || startTime == null
          ? _value.startTime
          // ignore: cast_nullable_to_non_nullable
          : startTime as DateTime,
    );
  }
}

extension $TimerNotifierStateCopyWith on TimerNotifierState {
  /// Returns a callable class that can be used as follows: `instanceOfTimerNotifierState.copyWith(...)` or like so:`instanceOfTimerNotifierState.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$TimerNotifierStateCWProxy get copyWith =>
      _$TimerNotifierStateCWProxyImpl(this);
}
