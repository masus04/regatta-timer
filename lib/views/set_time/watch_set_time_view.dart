import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:regatta_timer/components/accidental_interaction_preventer.dart';
import 'package:regatta_timer/components/controls/settings_button.dart';
import 'package:regatta_timer/components/controls/time_selector.dart';
import 'package:regatta_timer/components/layouts/watch_layout.dart';
import 'package:regatta_timer/providers/app_view_provider.dart';
import 'package:regatta_timer/providers/boat_speed_provider.dart';
import 'package:regatta_timer/providers/settings_provider.dart';

class WatchSetTimeView extends HookConsumerWidget {
  const WatchSetTimeView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Trigger provider initialization
    ref.read(boatSpeedProvider);

    return Scaffold(
      body: Stack(
        alignment: AlignmentDirectional.centerStart,
        children: [
          WatchLayout(
            topButton: WatchLayoutTopButton(
              text: "Timer",
              onPressed: onTimerTypePressed(context, ref),
              buttonStyle: TextButton.styleFrom(backgroundColor: Theme.of(context).colorScheme.primary),
            ),
            bottomButton: WatchLayoutBottomButton(
              text: "Start",
              onPressed: onStartPressed(context, ref),
              buttonStyle: TextButton.styleFrom(backgroundColor: Theme.of(context).colorScheme.secondary),
              longPressRequired: ref.watch(settingsProvider).longPressToStart,
            ),
            centerWidget: const TimeSelector(),
            leftButton: const AccidentalInteractionPreventer(
              size: Size(50, 60),
              alignment: AlignmentDirectional.centerStart,
              child: SettingsButton(),
            ),
          ),
        ],
      ),
    );
  }

  void Function() onTimerTypePressed(BuildContext context, WidgetRef ref) {
    return () {};
  }

  void Function() onStartPressed(BuildContext context, WidgetRef ref) {
    return () {
      ref.watch(appViewProvider.notifier).enterPreStartState(context);
    };
  }
}
