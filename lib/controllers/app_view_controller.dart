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

  Future<void> enterSetTimeState() async {
    // state = AppView.setTimeView;

    await ref.read(timerController.notifier).stop();

    if (ref.watch(settingsProvider).timerSelectionWakelockEnabled) {
      WakelockPlus.enable();
      debugPrint("WakeLock: enabled");
    } else {
      WakelockPlus.disable();
      debugPrint("WakeLock: disabled");
    }
  }

  Future<void> enterPreStartState() async {
    // state = AppView.preStartView;

    final settings = ref.watch(settingsProvider);
    final appLock = ref.read(appLockedProvider);

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

  void enterPostStartState() {
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

  void enterSettingsState() {
    // state = AppView.settingsView;
  }

  void enterStartTimeSettingsState() {
    // state = AppView.startTimeSettingsView;
  }

  void enterVibrationAlertSettingsState() {
    // state = AppView.vibrationAlertSettingsView;
  }
}

final appViewController = NotifierProvider<AppViewController, void>(AppViewController.new);
