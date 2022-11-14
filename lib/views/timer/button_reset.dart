import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:regatta_timer/components/layouts/layout_buttons.dart';
import 'package:regatta_timer/providers/app_view_provider.dart';
import 'package:regatta_timer/providers/settings_provider.dart';

class ResetButton extends HookConsumerWidget {
  const ResetButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return LayoutButton(
      text: "Reset",
      onPressed: onResetPressed(context, ref),
      longPressRequired: ref.watch(settingsProvider).longPressToResetPreStart,
      buttonStyle: TextButton.styleFrom(
        backgroundColor: Theme.of(context).colorScheme.tertiary,
      ),
      watchLayoutButtonType: WatchLayoutButtonType.topButton,
    );
  }

  void Function() onResetPressed(BuildContext context, WidgetRef ref) {
    return () {
      ref.watch(appViewProvider.notifier).enterSetTimeState(context);
    };
  }
}
