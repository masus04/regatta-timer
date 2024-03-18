// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'timer_extensions.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$CharlyModeStateCWProxy {
  CharlyModeState enabled(bool enabled);

  CharlyModeState lastOffset(Duration lastOffset);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `CharlyModeState(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// CharlyModeState(...).copyWith(id: 12, name: "My name")
  /// ````
  CharlyModeState call({
    bool? enabled,
    Duration? lastOffset,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfCharlyModeState.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfCharlyModeState.copyWith.fieldName(...)`
class _$CharlyModeStateCWProxyImpl implements _$CharlyModeStateCWProxy {
  const _$CharlyModeStateCWProxyImpl(this._value);

  final CharlyModeState _value;

  @override
  CharlyModeState enabled(bool enabled) => this(enabled: enabled);

  @override
  CharlyModeState lastOffset(Duration lastOffset) =>
      this(lastOffset: lastOffset);

  @override

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `CharlyModeState(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// CharlyModeState(...).copyWith(id: 12, name: "My name")
  /// ````
  CharlyModeState call({
    Object? enabled = const $CopyWithPlaceholder(),
    Object? lastOffset = const $CopyWithPlaceholder(),
  }) {
    return CharlyModeState(
      enabled: enabled == const $CopyWithPlaceholder() || enabled == null
          ? _value.enabled
          // ignore: cast_nullable_to_non_nullable
          : enabled as bool,
      lastOffset:
          lastOffset == const $CopyWithPlaceholder() || lastOffset == null
              ? _value.lastOffset
              // ignore: cast_nullable_to_non_nullable
              : lastOffset as Duration,
    );
  }
}

extension $CharlyModeStateCopyWith on CharlyModeState {
  /// Returns a callable class that can be used as follows: `instanceOfCharlyModeState.copyWith(...)` or like so:`instanceOfCharlyModeState.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$CharlyModeStateCWProxy get copyWith => _$CharlyModeStateCWProxyImpl(this);
}
