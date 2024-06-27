import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:regatta_timer/controllers/ui_utils.dart';
import 'package:regatta_timer/providers/settings_provider.dart';
import 'package:regatta_timer/providers/timer_extensions.dart';
import 'package:regatta_timer/views/settings/widget_boolean_settings.dart';

class SettingsView extends HookConsumerWidget {
  const SettingsView() : super(key: const Key("SettingsView"));

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final divider = Divider(color: Theme.of(context).colorScheme.onSurface, thickness: 2);

    return SafeArea(
      child: Semantics(
        label: "App Settings",
        hint: "Configure App settings such as controls, screen saver and available times",
        child: Scaffold(
          backgroundColor: Theme.of(context).colorScheme.surface,
          body: Scrollbar(
            child: ListView(
              padding: const EdgeInsets.only(top: 15),
              children: [
                Text(
                  "Settings",
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.labelLarge,
                ),
                divider,
                const SettingsTitle(
                  title: "Long Press",
                  helpText: "Require a long press for various buttons in order to prevent accidental presses",
                ),
                BooleanSetting(
                  text: "Long Press to Start",
                  value: ref.watch(settingsProvider).longPressToStart,
                  onChanged: (newValue) => ref.read(settingsProvider.notifier).setLongPressToStart(newValue),
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
                const SettingsTitle(
                  title: "WakeLock",
                  helpText: "Enable WakeLock in order to prevent your device from going to sleep depending on the current state of the app",
                ),
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
                divider,
                const SettingsTitle(
                  title: "App Lock",
                  helpText: "Configure the behaviour of the app when the lock button is active",
                ),
                BooleanSetting(
                  text: "Prevent Back Button from Exiting App when Locked",
                  value: ref.watch(settingsProvider).lockPreventPopBack,
                  onChanged: (newValue) => ref.read(settingsProvider.notifier).setLockPreventPopBack(newValue),
                ),
                divider,
                const SettingsTitle(
                  title: "Start Flags",
                  helpText: "The Start Procedure Flags feature shows the expected flags for the current time underneath the timer.",
                ),
                BooleanSetting(
                  text: "Enable Start Procedure Flags",
                  value: ref.watch(settingsProvider).startProcedureFlagsEnabled,
                  onChanged: (newValue) => ref.read(settingsProvider.notifier).setStartProcedureFlags(newValue),
                ),

                if (UiUtils(context).deviceType != DeviceType.watch) ...[
                  // Currently disabled due to lack of support for boat speed
                  divider,
                  const SettingsTitle(
                    title: "Location",
                    helpText: "Enable Location tracking in order to show boat speed and support additional Location features.",
                  ),
                  BooleanSetting(
                    text: "Show boat speed",
                    value: ref.watch(settingsProvider).displayBoatSpeed,
                    onChanged: (newValue) => ref.read(settingsProvider.notifier).setDisplayBoatSpeed(newValue),
                  ),
                ],
                divider,
                const SettingsTitle(
                  title: "Voice Notifications",
                  helpText: "Announce the state of the timer at regular intervals using voice notifications.",
                ),
                BooleanSetting(
                  text: "Enable Voice Notifications",
                  value: ref.read(settingsProvider).soundEventsEnabled,
                  onChanged: (newValue) => ref.read(settingsProvider.notifier).setSoundEventsEnabled(newValue),
                ),
                divider,
                const SettingsTitle(
                  title: "Charly Mode",
                  helpText: "Charly Mode is a training mode inspired by Charly Fernbach.\n"
                      "When activated, after each start the timer is restarted with half the time used for the previous start.\n"
                      "When Charly mode is enabled in the setting, it can be engaged in the Timer view.",
                ),
                BooleanSetting(
                  text: "Enable Charly Mode toggle",
                  value: ref.read(settingsProvider).charlyModeToggleEnabled,
                  onChanged: (newValue) {
                    ref.read(settingsProvider.notifier).setCharlyModeToggleEnabled(newValue);
                    if (!newValue) {
                      // If charly mode is being disabled in the settings, also disable it in the timer view
                      ref.read(charlyModeExtension.notifier).charlyModeEnabled = newValue;
                    }
                  },
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
                  icon: Icon(
                    Icons.check_circle_outline,
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                )
              ],
            ),
          ),
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

class SettingsTitle extends StatelessWidget {
  final String title;
  final String helpText;

  const SettingsTitle({super.key, required this.helpText, required this.title});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.only(left: 35, right: 35, bottom: 8),
      title: Text(
        title,
        textAlign: TextAlign.left,
        style: Theme.of(context).textTheme.labelMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.onSurface,
            ),
      ),
      trailing: GestureDetector(
        child: Icon(
          Icons.info_outline,
          color: Theme.of(context).colorScheme.onSurface,
        ),
        onTap: () => showDialog(
          context: context,
          builder: (context) => SimpleDialog(
            contentPadding: const EdgeInsets.symmetric(horizontal: 8),
            titlePadding: const EdgeInsets.all(8),
            title: Text(
              title,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.displayLarge?.copyWith(color: Theme.of(context).colorScheme.onSurface),
            ),
            children: [
              Text(
                helpText,
                style: TextStyle(color: Theme.of(context).colorScheme.onSurface),
              ),
              IconButton(
                onPressed: () => Navigator.of(context).pop(),
                icon: Icon(
                  Icons.check_circle_outline,
                  color: Theme.of(context).colorScheme.onSurface,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
