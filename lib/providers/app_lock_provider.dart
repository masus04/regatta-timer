import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

/// Provides a boolean, representing whether the app screen is locked and all buttons should be disabled
class AppLockedNotifier extends StateNotifier<bool> {
  final Ref ref;

  AppLockedNotifier(this.ref) : super(false);

  void toggle() {
    state = !state;
    debugPrint("AppLock: $state");
  }
}

final appLockedProvider = StateNotifierProvider<AppLockedNotifier, bool>((ref) {
  return AppLockedNotifier(ref);
});
