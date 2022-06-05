import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:regatta_timer/providers/app_view_provider.dart';
import 'package:regatta_timer/providers/settings_provider.dart';
import 'package:wakelock/wakelock.dart';

/// Provides a boolean, representing whether the app screen is locked and all buttons should be disabled
class AppLockedNotifier extends StateNotifier<bool> {
  final Ref ref;

  AppLockedNotifier(this.ref) : super(false);

  void toggle() {
    state = !state;
    final appView = ref.read(appViewProvider);
    final settings = ref.read(settingsProvider);

    if (appView == AppViewNotifier.setTimeView) {
      if (!state && settings.timerSelectionWakelockEnabled) {
        Wakelock.enable();
      } else {
        Wakelock.disable();
      }
    }

    if (appView == AppViewNotifier.preStartView) {
      if (!state && settings.preStartWakelockEnabled) {
        Wakelock.enable();
      } else {
        Wakelock.disable();
      }
    }

    if (appView == AppViewNotifier.postStartView) {
      if (!state && settings.postStartWakelockEnabled) {
        Wakelock.enable();
      } else {
        Wakelock.disable();
      }
    }

    if (appView == AppViewNotifier.settingsView) {
      Wakelock.disable();
    }
  }
}

final appLockedProvider = StateNotifierProvider<AppLockedNotifier, bool>((ref) {
  return AppLockedNotifier(ref);
});
