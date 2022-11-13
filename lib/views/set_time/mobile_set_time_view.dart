import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:regatta_timer/components/controls/settings_button.dart';
import 'package:regatta_timer/components/controls/time_selector.dart';
import 'package:regatta_timer/components/layouts/mobile_layout.dart';
import 'package:regatta_timer/providers/charly_mode_provider.dart';
import 'package:regatta_timer/providers/settings_provider.dart';
import 'package:regatta_timer/views/set_time/start_button.dart';

class MobileSetTimeView extends HookConsumerWidget {
  const MobileSetTimeView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MobileLayout(
      title: Image.asset("assets/icons/regatta_timer.png"),
      primaryButton: ref.watch(settingsProvider).charlyModeToggleEnabled ? const CharlyModeWidget() : null,
      secondaryButton: const Expanded(flex: 10, child: StartButton()),
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

class CharlyModeWidget extends HookConsumerWidget {
  const CharlyModeWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ListTile(
      title: Text("Charly Mode", style: Theme.of(context).textTheme.displayMedium),
      trailing: Switch(
        value: ref.watch(charlyModeProvider).enabled,
        activeColor: Colors.indigo,
        onChanged: onCharlyModeToggled(context, ref),
      ),
    );
  }

  void Function(bool) onCharlyModeToggled(BuildContext context, WidgetRef ref) {
    return (bool newValue) {
      ref.read(charlyModeProvider.notifier).charlyModeEnabled = newValue;
    };
  }
}
