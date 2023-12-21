import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:regatta_timer/providers/app_lock_provider.dart';
import 'package:regatta_timer/providers/settings_provider.dart';
import 'package:regatta_timer/providers/timer_providers.dart';
import 'package:wakelock_plus/wakelock_plus.dart';

enum AppView {
  setTimeView(route: "/setTime"),
  preStartView(route: "/timer"),
  postStartView(route: "/timer"),
  settingsView(route: "/settings"),
  startTimeSettingsView(route: "/startTimeSettings"),
  vibrationSettingsView(route: "/vibrationAlertSettings");

  final String route;

  const AppView({
    required this.route,
  });
}

class AppViewController {
  static void enterSetTimeState(BuildContext context, WidgetRef ref) {
    // state = AppView.setTimeView;

    Navigator.pop(context);
    TimerController.stopTimer(ref);

    if (ref.watch(settingsProvider).timerSelectionWakelockEnabled) {
      WakelockPlus.enable();
      debugPrint("WakeLock: enabled");
    } else {
      WakelockPlus.disable();
      debugPrint("WakeLock: disabled");
    }
  }

  static void enterPreStartState(BuildContext context, WidgetRef ref) {
    // state = AppView.preStartView;

    final settings = ref.watch(settingsProvider);
    final appLock = ref.read(appLockedProvider);

    TimerController.startTimer(ref);
    TimerController.resetTimer(ref);
    Navigator.pushNamed(context, AppView.preStartView.route);

    if (settings.preStartWakelockEnabled && !appLock) {
      WakelockPlus.enable();
      debugPrint("WakeLock: enabled");
    } else {
      WakelockPlus.disable();
      debugPrint("WakeLock: disabled");
    }
  }

  static void enterPostStartState(BuildContext context, WidgetRef ref) {
    // state = AppView.postStartView;

    final settings = ref.watch(settingsProvider);
    final appLock = ref.read(appLockedProvider);

    if (settings.postStartWakelockEnabled && !appLock) {
      WakelockPlus.enable();
      debugPrint("WakeLock: enabled");
    } else {
      WakelockPlus.disable();
      debugPrint("WakeLock: disabled");
    }
  }

  static void enterSettingsState(BuildContext context, WidgetRef ref) {
    // state = AppView.settingsView;

    Navigator.pushNamed(context, AppView.settingsView.route);
  }

  static void enterStartTimeSettingsState(BuildContext context) {
    // state = AppView.startTimeSettingsView;

    Navigator.pushNamed(context, AppView.startTimeSettingsView.route);
  }

  static void enterVibrationAlertSettingsState(BuildContext context) {
    // state = AppView.vibrationAlertSettingsView;

    Navigator.pushNamed(context, AppView.vibrationSettingsView.route);
  }
}
