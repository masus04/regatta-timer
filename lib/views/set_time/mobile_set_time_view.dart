import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:regatta_timer/components/controls/time_selector.dart';
import 'package:regatta_timer/components/layouts/mobile_layouts/mobile_layout.dart';
import 'package:regatta_timer/components/controls/settings_button.dart';
import 'package:regatta_timer/providers/settings_provider.dart';

class MobileSetTimeView extends HookConsumerWidget {
  const MobileSetTimeView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MobileLayout(
      primaryButton: MobileLayoutButton(
        text: "Timer",
        onPressed: onTimerTypePressed(context, ref),
        longPressRequired: false,
        buttonStyle: TextButton.styleFrom(backgroundColor: Theme.of(context).colorScheme.primary),
      ),
      secondaryButton: MobileLayoutButton(
        text: "Start",
        onPressed: onStartPressed(context, ref),
        buttonStyle: TextButton.styleFrom(backgroundColor: Theme.of(context).colorScheme.secondary),
        longPressRequired: ref.watch(settingsProvider).longPressToStart,
      ),
      centerWidget: const TimeSelector(),
      additionalButtons: const [
        SettingsButton(),
      ],
    );
  }

  void Function() onTimerTypePressed(BuildContext context, WidgetRef ref) {
    return () {};
  }

  void Function() onStartPressed(BuildContext context, WidgetRef ref) {
    return () {};
  }
}
