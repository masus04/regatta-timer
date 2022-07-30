import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class VibrationPatternSettingsView extends HookConsumerWidget {
  const VibrationPatternSettingsView({
    Key? key,
  }) : super(key: key);

  final description = "Time intervals to be displayed in the StartTime selector";

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: ListView(
        children: [
          ListTile(
            contentPadding: const EdgeInsets.only(left: 30, right: 30),
            title: Text(description),
          ),
        ],
      ),
    );
  }
}
