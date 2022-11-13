import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:regatta_timer/components/layouts/layout_mobile.dart';
import 'package:regatta_timer/components/layouts/layout_watch.dart';
import 'package:regatta_timer/providers/layout_provider.dart';

class TimerButton extends HookConsumerWidget {
  const TimerButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    switch (ref.watch(uiProvider).deviceType) {
      case DeviceType.watch:
        return WatchLayoutTopButton(
          text: "Timer",
          onPressed: onTimerTypePressed(context, ref),
          buttonStyle: TextButton.styleFrom(backgroundColor: Theme.of(context).colorScheme.primary),
        );
      default:
        return MobileLayoutButton(
          text: "Timer",
          onPressed: onTimerTypePressed(context, ref),
          longPressRequired: false,
          buttonStyle: TextButton.styleFrom(backgroundColor: Theme.of(context).colorScheme.primary),
        );
    }
  }

  void Function() onTimerTypePressed(BuildContext context, WidgetRef ref) {
    return () {};
  }
}
