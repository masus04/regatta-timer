import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:regatta_timer/providers/layout_provider.dart';
import 'package:regatta_timer/providers/settings_provider.dart';
import 'package:regatta_timer/views/settings/widget_boolean_settings.dart';

class SettingsView extends HookConsumerWidget {
  final divider = const Divider(color: Colors.white, thickness: 2);

  const SettingsView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Theme.of(context).primaryColor,
        body: ListView(
          padding: const EdgeInsets.only(top: 15),
          children: [
            Text(
              "Settings",
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.labelLarge,
            ),
            divider,
            const SettingsText(text: "Enable long press for various buttons in order to prevent accidental presses"),
            BooleanSetting(
              text: "Long Press to Start",
              value: ref.watch(settingsProvider).longPressToStart,
              onChanged: (newValue) => ref.read(settingsProvider.notifier).setLongPressToStart(newValue),
              toolTipText: "Text",
            ),
            BooleanSetting(
              text: "Long Press to Reset",
              value: ref.watch(settingsProvider).longPressToResetPreStart,
              onChanged: (newValue) => ref.read(settingsProvider.notifier).setLongPressToResetPreStart(newValue),
            ),
            BooleanSetting(
              text: "Long Press to Sync",
              value: ref.watch(settingsProvider).longPressToSync,
              onChanged: (newValue) => ref.read(settingsProvider.notifier).toggleLongPressToSync(newValue),
            ),
            BooleanSetting(
              text: "Long Press to End Race",
              value: ref.watch(settingsProvider).longPressToResetPostStart,
              onChanged: (newValue) => ref.read(settingsProvider.notifier).setLongPressToResetPostStart(newValue),
            ),
            divider,
            const SettingsText(text: "Enable WakeLock in order to prevent your device from going to sleep"),
            BooleanSetting(
              text: "Enable WakeLock on Timer view",
              value: ref.watch(settingsProvider).timerSelectionWakelockEnabled,
              onChanged: (newValue) => ref.read(settingsProvider.notifier).setTimerSelectionWakelockEnabled(newValue),
            ),
            BooleanSetting(
              text: "Enable WakeLock during PreStart",
              value: ref.watch(settingsProvider).preStartWakelockEnabled,
              onChanged: (newValue) => ref.read(settingsProvider.notifier).setPreStartWakelockEnabled(newValue),
            ),
            BooleanSetting(
              text: "Enable WakeLock during PostStart",
              value: ref.watch(settingsProvider).postStartWakelockEnabled,
              onChanged: (newValue) => ref.read(settingsProvider.notifier).setPostStartWakelockEnabled(newValue),
            ),
            if (ref.watch(uiProvider).deviceType != DeviceType.watch) ...[
              divider,
              const SettingsText(text: "Enable Location tracking in order to show boat speed"),
              BooleanSetting(
                text: "Show boat speed",
                value: ref.watch(settingsProvider).displayBoatSpeed,
                onChanged: (newValue) => ref.read(settingsProvider.notifier).setDisplayBoatSpeed(newValue),
              ),
            ],
            divider,
            const SettingsText(
              text:
                  "Charly Mode is a training mode inspired by Charly Fernbach. When activated, after each start the timer is restarted with half the time used for the last start",
            ),
            BooleanSetting(
              text: "Enable Charly Mode toggle",
              value: ref.read(settingsProvider).charlyModeToggleEnabled,
              onChanged: (newValue) => ref.read(settingsProvider.notifier).setCharlyModeToggleEnabled(newValue),
            ),
            // TODO: Add BoatSpeedUnit selector setting

            // divider,
            // SelectFromListSetting(
            //   text: "Start Time Options",
            //   onPressed: () => ref.read(appViewProvider.notifier).enterStartTimeSettingsState(context),
            // ),
            // SelectFromListSetting(
            //   text: "Vibration Alerts",
            //   onPressed: () => ref.read(appViewProvider.notifier).enterVibrationAlertSettingsState(context),
            // ),
            divider,
            IconButton(
              onPressed: onReturnPressed(context),
              icon: const Icon(Icons.check_circle_outline, color: Colors.white),
            )
          ],
        ),
      ),
    );
  }

  void Function() onReturnPressed(BuildContext context) {
    return () {
      Navigator.of(context).pop();
    };
  }
}

class SettingsText extends StatelessWidget {
  final String text;

  const SettingsText({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.only(left: 35, right: 35, bottom: 8),
      // leading: const Icon(
      //   Icons.info_outline,
      //   color: Colors.white,
      // ),
      title: Text(
        text,
        style: Theme.of(context).textTheme.labelMedium,
      ),
    );
  }
}
