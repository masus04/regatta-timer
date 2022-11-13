import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class VibrationPatternSettingsView extends HookConsumerWidget {
  /// Currently not reachable
  /// TODO: Create button in Settings in order to display this view

  final title = "Start Time Options";
  final description = "Time intervals to be displayed in the StartTime selector";

  const VibrationPatternSettingsView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
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
    );
  }
}
