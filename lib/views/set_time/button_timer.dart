import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:regatta_timer/components/layouts/layout_buttons.dart';

class TimerButton extends HookConsumerWidget {
  const TimerButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return IgnorePointer(
      // Prevent Button from accepting presses
      ignoring: true,
      child: Semantics(
        label: "Title",
        child: LayoutButton(
          text: "Timer",
          onPressed: onTimerTypePressed(context, ref),
          buttonColor: Theme.of(context).colorScheme.primary,
          watchLayoutButtonType: WatchLayoutButtonType.topButton,
        ),
      ),
    );
  }

  void Function()? onTimerTypePressed(BuildContext context, WidgetRef ref) {
    return null;
  }
}
