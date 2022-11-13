import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:regatta_timer/providers/settings_provider.dart';

class StartTimerSettingsView extends HookConsumerWidget {
  /// Currently not reachable
  /// TODO: Create button in Settings in order to display this view

  final title = "Start Time Options";
  final description = "Select which start time options should be displayed on the main Timer screen";

  const StartTimerSettingsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColorDark,
      body: ListView(
        padding: const EdgeInsets.only(top: 15, bottom: 35),
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 50),
            child: Text(
              title,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.labelLarge,
            ),
          ),
          ListTile(
            contentPadding: const EdgeInsets.only(left: 15, right: 15),
            title: Text(
              description,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.labelMedium,
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
                    style: Theme.of(context).textTheme.labelMedium,
                  ),
                  trailing: Transform.scale(
                    scale: 0.75,
                    child: Switch(
                      value: startTime.enabled,
                      activeColor: Colors.white,
                      onChanged: (newValue) => ref.read(settingsProvider.notifier).setStartTimeOptions(startTime, newValue),
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
