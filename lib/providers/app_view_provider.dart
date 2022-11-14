import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:regatta_timer/providers/app_lock_provider.dart';
import 'package:regatta_timer/providers/settings_provider.dart';
import 'package:regatta_timer/providers/timer_providers.dart';
import 'package:wakelock/wakelock.dart';

class AppView {
  final String route;

  AppView(this.route);
}

class AppViewNotifier extends StateNotifier<AppView> {
  final Ref ref;

  static AppView setTimeView = AppView("/setTime");
  static AppView preStartView = AppView("/timer");
  static AppView postStartView = AppView("/timer");
  static AppView settingsView = AppView("/settings");
  static AppView startTimeSettingsView = AppView("/startTimeSettings");
  static AppView vibrationAlertSettingsView = AppView("/vibrationAlertSettings");

  AppViewNotifier({required this.ref}) : super(setTimeView);

  void enterSetTimeState(BuildContext context) {
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
    final settings = ref.watch(settingsProvider);
    final appLock = ref.read(appLockedProvider);

    ref.read(timerProvider.notifier).reset();

    Navigator.pushNamed(context, preStartView.route);

    if (settings.preStartWakelockEnabled && !appLock) {
      Wakelock.enable();
      debugPrint("WakeLock: enabled");
    } else {
      Wakelock.disable();
      debugPrint("WakeLock: disabled");
    }
  }

  void enterPostStartState(BuildContext context) {
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
    Navigator.pushNamed(context, settingsView.route);
  }

  void enterStartTimeSettingsState(BuildContext context) {
    Navigator.pushNamed(context, startTimeSettingsView.route);
  }

  void enterVibrationAlertSettingsState(BuildContext context) {
    Navigator.pushNamed(context, vibrationAlertSettingsView.route);
  }
}

final appViewProvider = StateNotifierProvider<AppViewNotifier, AppView>((ref) {
  return AppViewNotifier(ref: ref);
});
