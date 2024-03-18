import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:regatta_timer/components/layouts/layout_buttons.dart';
import 'package:regatta_timer/controllers/app_view_controller.dart';
import 'package:regatta_timer/providers/settings_provider.dart';
import 'package:regatta_timer/providers/timer_providers.dart';
import 'package:regatta_timer/views/timer/post_start/end_of_race_dialog.dart';

class EndRaceButton extends HookConsumerWidget {
  const EndRaceButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Semantics(
      label: "End Race Button",
      hint: "End the race and return to the pre race view",
      child: LayoutButton(
        text: "End Race",
        onPressed: () async {
          ref.read(timerController.notifier).stop();

          await showDialog<void>(
            context: context,
            builder: (context) {
              return const EndOfRaceDialog();
            },
          );

          await ref.read(appViewController.notifier).enterSetTimeState();
        },
        buttonColor: Theme.of(context).colorScheme.secondary,
        longPressRequired: ref.watch(settingsProvider).longPressToResetPostStart,
        watchLayoutButtonType: WatchLayoutButtonType.topButton,
      ),
    );
  }
}
