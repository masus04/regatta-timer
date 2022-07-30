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
      body: ListView(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
        children: [
          const Center(
              child: Text(
            "Settings",
            style: TextStyle(color: Colors.white),
          )),
          const Divider(color: Colors.white),
          BooleanSetting(
            text: "Long Press to Reset PreStart",
            value: ref.watch(settingsProvider).longPressToResetPreStart,
            onChanged: (newValue) => ref.read(settingsProvider.notifier).toggleLongPressToResetPreStart(),
          ),
          BooleanSetting(
            text: "Long Press to Reset PostStart",
            value: ref.watch(settingsProvider).longPressToResetPostStart,
            onChanged: (newValue) => ref.read(settingsProvider.notifier).toggleLongPressToResetPostStart(),
          ),
          BooleanSetting(
            text: "Long Press to Sync",
            value: ref.watch(settingsProvider).longPressToSync,
            onChanged: (newValue) => ref.read(settingsProvider.notifier).toggleLongPressToSync(),
          ),
          const Divider(color: Colors.white),
          BooleanSetting(
            text: "Enable WakeLock on Timer screen",
            value: ref.watch(settingsProvider).timerSelectionWakelockEnabled,
            onChanged: (newValue) => ref.read(settingsProvider.notifier).toggleTimerSelectionWakelockEnabled(),
          ),
          BooleanSetting(
            text: "Enable WakeLock during PreStart",
            value: ref.watch(settingsProvider).preStartWakelockEnabled,
            onChanged: (newValue) => ref.read(settingsProvider.notifier).togglePreStartWakelockEnabled(),
          ),
          BooleanSetting(
            text: "Enable WakeLock during PostStart",
            value: ref.watch(settingsProvider).postStartWakelockEnabled,
            onChanged: (newValue) => ref.read(settingsProvider.notifier).togglePostStartWakelockEnabled(),
          ),
        ],
      ),
      backgroundColor: Theme.of(context).primaryColor,
    );
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
      title: Text(
        text,
        textAlign: TextAlign.left,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 10,
        ),
      ),
      trailing: Switch(
        value: value,
        onChanged: onChanged,
        activeColor: Colors.white,
      ),
      dense: true,
      visualDensity: VisualDensity.compact,
    );
  }
}

class SelectSetting extends StatelessWidget {
  final String text;

  const SelectSetting({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        text,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 8,
        ),
      ),
      dense: true,
    );
  }
}
