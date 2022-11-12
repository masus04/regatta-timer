import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:regatta_timer/providers/settings_provider.dart';

class SettingsView extends HookConsumerWidget {
  const SettingsView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: ListView(
        padding: const EdgeInsets.only(top: 15),
        children: [
          const Text(
            "Settings",
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white, fontSize: 17),
          ),
          const Divider(color: Colors.white),
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
          const Divider(color: Colors.white),
          BooleanSetting(
            text: "Enable WakeLock on Timer screen",
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
          const Divider(color: Colors.white),
          BooleanSetting(
            text: "Show post start boat speed",
            value: ref.watch(settingsProvider).showPostStartBoatSpeed,
            onChanged: (newValue) => ref.read(settingsProvider.notifier).setShowPostStartBoatSpeed(newValue),
          ),
          // TODO: Add BoatSpeedUnit selector setting

          // const Divider(color: Colors.white),
          // SelectFromListSetting(
          //   text: "Start Time Options",
          //   onPressed: () => ref.read(appViewProvider.notifier).enterStartTimeSettingsState(context),
          // ),
          // SelectFromListSetting(
          //   text: "Vibration Alerts",
          //   onPressed: () => ref.read(appViewProvider.notifier).enterVibrationAlertSettingsState(context),
          // ),
          const Divider(color: Colors.white),
          IconButton(
            onPressed: onReturnPressed(context),
            icon: const Icon(Icons.check_circle_outline, color: Colors.white),
          )
        ],
      ),
    );
  }

  void Function() onReturnPressed(BuildContext context) {
    return () {
      Navigator.of(context).pop();
    };
  }
}

class BooleanSetting extends StatelessWidget {
  final String text;
  final bool value;
  final void Function(bool) onChanged;

  const BooleanSetting({Key? key, required this.text, required this.value, required this.onChanged}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.only(left: 35, right: 10),
      title: Text(
        text,
        textAlign: TextAlign.left,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 10,
        ),
      ),
      trailing: Transform.scale(
        scale: 0.75,
        child: Switch(
          value: value,
          onChanged: onChanged,
          activeColor: Colors.white,
        ),
      ),
      dense: true,
      visualDensity: VisualDensity.compact,
    );
  }
}

class SelectFromListSetting extends StatelessWidget {
  final String text;
  final void Function() onPressed;

  const SelectFromListSetting({Key? key, required this.text, required this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.only(left: 35, right: 10),
      title: Text(
        text,
        textAlign: TextAlign.left,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 10,
        ),
      ),
      trailing: IconButton(
        onPressed: onPressed,
        icon: const Icon(Icons.list, color: Colors.white),
      ),
      dense: true,
      visualDensity: VisualDensity.compact,
    );
  }
}
