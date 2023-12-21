import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class VibrationSettingsView extends HookConsumerWidget {
  /// Currently not reachable
  /// TODO: Create button in Settings in order to display this view

  final title = "Start Time Options";
  final description = "Time intervals to be displayed in the StartTime selector";

  const VibrationSettingsView() : super(key: const Key("VibrationSettingsView"));

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Semantics(
      label: "Vibration Pattern Settings",
      hint: "Allows configuration of vibration alert patterns",
      child: Scaffold(
        body: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 50),
              child: Text(
                title,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.labelMedium,
              ),
            ),
            ListTile(
              contentPadding: const EdgeInsets.only(left: 30, right: 30),
              title: Text(description),
            ),
          ],
        ),
      ),
    );
  }
}
