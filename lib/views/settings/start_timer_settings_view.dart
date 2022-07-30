import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:regatta_timer/providers/settings_provider.dart';

class StartTimerSettingsView extends HookConsumerWidget {
  const StartTimerSettingsView({
    Key? key,
  }) : super(key: key);

  final title = "Start Time Options";
  final description = "Select which start time options should be displayed on the main Timer screen";

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColorDark,
      body: ListView(
        padding: const EdgeInsets.only(top: 15, bottom: 35),
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 50),
            child: Text(
              "Start Time Options",
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white, fontSize: 17),
            ),
          ),
          ListTile(
            contentPadding: const EdgeInsets.only(left: 15, right: 15),
            title: Text(
              description,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 10, color: Colors.white),
            ),
            dense: true,
            visualDensity: VisualDensity.compact,
          ),
          ...ref
              .watch(settingsProvider)
              .selectedStartTimeOptions
              .map(
                (startTime) => ListTile(
                  contentPadding: const EdgeInsets.only(left: 35, right: 10),
                  title: Text(
                    "${startTime.startTime.inMinutes} min",
                    style: const TextStyle(color: Colors.white, fontSize: 10),
                  ),
                  trailing: Transform.scale(
                    scale: 0.75,
                    child: Switch(
                      value: startTime.enabled,
                      activeColor: Colors.white,
                      onChanged: (newValue) => ref.read(settingsProvider.notifier).setStartTime(startTime, newValue),
                    ),
                  ),
                  dense: true,
                  visualDensity: VisualDensity.compact,
                ),
              )
              .toList(),
        ],
      ),
    );
  }
}
