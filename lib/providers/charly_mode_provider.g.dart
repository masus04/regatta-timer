// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'charly_mode_provider.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$CharlyModeStateCWProxy {
  CharlyModeState enabled(bool enabled);

  CharlyModeState nextStartDuration(Duration nextStartDuration);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `CharlyModeState(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// CharlyModeState(...).copyWith(id: 12, name: "My name")
  /// ````
  CharlyModeState call({
    bool? enabled,
    Duration? nextStartDuration,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfCharlyModeState.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfCharlyModeState.copyWith.fieldName(...)`
class _$CharlyModeStateCWProxyImpl implements _$CharlyModeStateCWProxy {
  final CharlyModeState _value;

  const _$CharlyModeStateCWProxyImpl(this._value);

  @override
  CharlyModeState enabled(bool enabled) => this(enabled: enabled);

  @override
  CharlyModeState nextStartDuration(Duration nextStartDuration) =>
      this(nextStartDuration: nextStartDuration);

  @override

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `CharlyModeState(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// CharlyModeState(...).copyWith(id: 12, name: "My name")
  /// ````
  CharlyModeState call({
    Object? enabled = const $CopyWithPlaceholder(),
    Object? nextStartDuration = const $CopyWithPlaceholder(),
  }) {
    return CharlyModeState(
      enabled: enabled == const $CopyWithPlaceholder() || enabled == null
          ? _value.enabled
          // ignore: cast_nullable_to_non_nullable
          : enabled as bool,
      nextStartDuration: nextStartDuration == const $CopyWithPlaceholder() ||
              nextStartDuration == null
          ? _value.nextStartDuration
          // ignore: cast_nullable_to_non_nullable
          : nextStartDuration as Duration,
    );
  }
}

extension $CharlyModeStateCopyWith on CharlyModeState {
  /// Returns a callable class that can be used as follows: `instanceOfCharlyModeState.copyWith(...)` or like so:`instanceOfCharlyModeState.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$CharlyModeStateCWProxy get copyWith => _$CharlyModeStateCWProxyImpl(this);
}
