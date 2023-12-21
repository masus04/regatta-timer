import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:regatta_timer/components/layouts/layout_buttons.dart';
import 'package:regatta_timer/controllers/app_view_controller.dart';
import 'package:regatta_timer/providers/settings_provider.dart';

class ResetButton extends HookConsumerWidget {
  const ResetButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Semantics(
      label: "Reset the timer and return to pre race view",
      child: LayoutButton(
        text: "Reset",
        onPressed: onResetPressed(context, ref),
        longPressRequired: ref.watch(settingsProvider).longPressToResetPreStart,
        buttonColor: Theme.of(context).colorScheme.tertiary,
        watchLayoutButtonType: WatchLayoutButtonType.topButton,
      ),
    );
  }

  void Function() onResetPressed(BuildContext context, WidgetRef ref) {
    return () {
      AppViewController.enterSetTimeState(context, ref);
    };
  }
}
