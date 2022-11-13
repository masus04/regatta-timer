import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:regatta_timer/components/layouts/mobile_layouts/mobile_layout.dart';
import 'package:regatta_timer/components/layouts/watch_layouts/watch_layout.dart';
import 'package:regatta_timer/providers/app_view_provider.dart';
import 'package:regatta_timer/providers/layout_provider.dart';
import 'package:regatta_timer/providers/settings_provider.dart';

class ResetButton extends HookConsumerWidget {
  const ResetButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    switch (ref.watch(uiProvider).deviceType) {
      case DeviceType.watch:
        return WatchLayoutTopButton(
          text: "Reset",
          onPressed: onResetPressed(context, ref),
          longPressRequired: ref.watch(settingsProvider).longPressToResetPreStart,
          buttonStyle: TextButton.styleFrom(
            backgroundColor: Theme.of(context).colorScheme.tertiary,
          ),
        );
      default:
        return MobileLayoutButton(
          text: "Reset",
          onPressed: onResetPressed(context, ref),
          longPressRequired: ref.watch(settingsProvider).longPressToResetPreStart,
          buttonStyle: TextButton.styleFrom(
            backgroundColor: Theme.of(context).colorScheme.tertiary,
          ),
        );
    }
  }

  void Function() onResetPressed(BuildContext context, WidgetRef ref) {
    return () {
      ref.watch(appViewProvider.notifier).enterSetTimeState(context);
    };
  }
}
