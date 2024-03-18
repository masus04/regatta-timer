import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:regatta_timer/providers/app_lock_provider.dart';
import 'package:regatta_timer/providers/settings_provider.dart';
import 'package:regatta_timer/providers/timer_extensions.dart';
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

class AppViewController extends Notifier<void> {
  @override
  void build() {}

  Future<void> enterSetTimeState(BuildContext context) async {
    // state = AppView.setTimeView;

    Navigator.pop(context);
    await ref.read(timerController.notifier).stop();

    if (ref.watch(settingsProvider).timerSelectionWakelockEnabled) {
      WakelockPlus.enable();
      debugPrint("WakeLock: enabled");
    } else {
      WakelockPlus.disable();
      debugPrint("WakeLock: disabled");
    }
  }

  Future<void> enterPreStartState(BuildContext context) async {
    // state = AppView.preStartView;

    final settings = ref.watch(settingsProvider);
    final appLock = ref.read(appLockedProvider);

    Navigator.pushNamed(context, AppView.preStartView.route);
    ref.read(charlyModeExtension.notifier).reset();
    await ref.read(timerController.notifier).start();

    if (settings.preStartWakelockEnabled && !appLock) {
      WakelockPlus.enable();
      debugPrint("WakeLock: enabled");
    } else {
      WakelockPlus.disable();
      debugPrint("WakeLock: disabled");
    }
  }

  void enterPostStartState(BuildContext context) {
    // TODO: call this appropriately
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

    Navigator.pushNamed(context, AppView.vibrationSettingsView.route);
  }
}

final appViewController = NotifierProvider<AppViewController, void>(AppViewController.new);
