import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:regatta_timer/components/controls/button_settings.dart';
import 'package:regatta_timer/components/controls/widget_time_selector.dart';
import 'package:regatta_timer/components/layouts/layout_mobile.dart';
import 'package:regatta_timer/components/widget_charly_mode.dart';
import 'package:regatta_timer/providers/settings_provider.dart';
import 'package:regatta_timer/views/set_time/button_start.dart';

class MobileSetTimeView extends HookConsumerWidget {
  const MobileSetTimeView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MobileLayout(
      title: Image.asset("assets/icons/regatta_timer.png"),
      centerWidget: const TimeSelector(),
      subtitle: ref.watch(settingsProvider).charlyModeToggleEnabled ? const CharlyModeToggleWidgetMobile() : null,
      secondaryButton: const Expanded(flex: 10, child: StartButton()),
      additionalButtons: const [
        SettingsButton(),
      ],
    );
  }
}
