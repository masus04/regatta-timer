import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:regatta_timer/providers/app_lock_provider.dart';
import 'package:regatta_timer/providers/settings_provider.dart';
import 'package:regatta_timer/providers/timer_provider.dart';
import 'package:flutter/material.dart';
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

  AppViewNotifier({required this.ref}) : super(setTimeView);

  void enterSetTimeState(BuildContext context) {
    ref.watch(timerProvider.notifier).abort();
    Navigator.pop(context);

    if (ref.watch(settingsProvider).timerSelectionWakelockEnabled) {
      Wakelock.enable();
    } else {
      Wakelock.disable();
    }
  }

  void enterPreStartState(BuildContext context) {
    final settings = ref.watch(settingsProvider);
    final appLock = ref.read(appLockedProvider);

    ref.read(timerProvider.notifier).reset();
    Navigator.pushNamed(context, preStartView.route);

    if (settings.preStartWakelockEnabled && !appLock) {
      Wakelock.enable();
    } else {
      Wakelock.disable();
    }
  }

  void enterPostStartState(BuildContext context) {
    final settings = ref.watch(settingsProvider);
    final appLock = ref.read(appLockedProvider);

    if (settings.postStartWakelockEnabled && !appLock) {
      Wakelock.enable();
    } else {
      Wakelock.disable();
    }
  }

  void enterSettingsState(BuildContext context) {
    Wakelock.disable();
  }
}

final appViewProvider = StateNotifierProvider<AppViewNotifier, AppView>((ref) {
  return AppViewNotifier(ref: ref);
});
