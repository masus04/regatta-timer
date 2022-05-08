import 'package:hooks_riverpod/hooks_riverpod.dart';

/// Provides a boolean, representing whether the app screen is locked and all buttons should be disabled
class AppLockedNotifier extends StateNotifier<bool> {
  AppLockedNotifier() : super(false);

  void toggle() {
    state = !state;
  }
}

final appLockedProvider = StateNotifierProvider<AppLockedNotifier, bool>((ref) {
  return AppLockedNotifier();
});
