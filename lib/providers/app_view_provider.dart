import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:regatta_timer/providers/app_lock_provider.dart';
import 'package:regatta_timer/providers/settings_provider.dart';
import 'package:regatta_timer/providers/timer_providers.dart';
import 'package:wakelock/wakelock.dart';

enum AppView {
  setTimeView(route: "/setTime"),
  preStartView(route: "/timer"),
  postStartView(route: "/timer"),
  settingsView(route: "/settings"),
  startTimeSettingsView(route: "/startTimeSettings"),
  vibrationAlertSettingsView(route: "/vibrationAlertSettings");

  final String route;

  const AppView({
    required this.route,
  });
}

class AppViewNotifier extends StateNotifier<AppView> {
  final Ref ref;

  AppViewNotifier({required this.ref}) : super(AppView.setTimeView);

  void enterSetTimeState(BuildContext context) {
    // state = AppView.setTimeView;

    Navigator.pop(context);
    ref.watch(timerProvider.notifier).stop();

    if (ref.watch(settingsProvider).timerSelectionWakelockEnabled) {
      Wakelock.enable();
      debugPrint("WakeLock: enabled");
    } else {
      Wakelock.disable();
      debugPrint("WakeLock: disabled");
    }
  }

  void enterPreStartState(BuildContext context) {
    // state = AppView.preStartView;

    final settings = ref.watch(settingsProvider);
    final appLock = ref.read(appLockedProvider);

    ref.read(timerProvider.notifier).reset();

    Navigator.pushNamed(context, AppView.preStartView.route);

    if (settings.preStartWakelockEnabled && !appLock) {
      Wakelock.enable();
      debugPrint("WakeLock: enabled");
    } else {
      Wakelock.disable();
      debugPrint("WakeLock: disabled");
    }
  }

  void enterPostStartState(BuildContext context) {
    // state = AppView.postStartView;

    final settings = ref.watch(settingsProvider);
    final appLock = ref.read(appLockedProvider);

    if (settings.postStartWakelockEnabled && !appLock) {
      Wakelock.enable();
      debugPrint("WakeLock: enabled");
    } else {
      Wakelock.disable();
      debugPrint("WakeLock: disabled");
    }
  }

  void enterSettingsState(BuildContext context) {
    // state = AppView.settingsView;

    Navigator.pushNamed(context, AppView.settingsView.route);
  }

  void enterStartTimeSettingsState(BuildContext context) {
    // state = AppView.startTimeSettingsView;

    Navigator.pushNamed(context, AppView.startTimeSettingsView.route);
  }

  void enterVibrationAlertSettingsState(BuildContext context) {
    // state = AppView.vibrationAlertSettingsView;

    Navigator.pushNamed(context, AppView.vibrationAlertSettingsView.route);
  }
}

final appViewProvider = StateNotifierProvider<AppViewNotifier, AppView>((ref) {
  return AppViewNotifier(ref: ref);
});
