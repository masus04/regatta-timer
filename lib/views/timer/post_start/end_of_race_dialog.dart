import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:regatta_timer/controllers/ui_utils.dart';
import 'package:regatta_timer/providers/timer_providers.dart';

class EndOfRaceDialog extends HookConsumerWidget {
  const EndOfRaceDialog({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SimpleDialog(
      title: FittedBox(
        child: Text(
          "Race completed!",
          style: Theme.of(context).textTheme.displayMedium,
        ),
      ),
      children: [
        Text(
          "Race Time: ${ref.watch(timerController).format()}",
          style: Theme.of(context).textTheme.labelMedium,
          textAlign: TextAlign.center,
        ),
        UiUtils(context).deviceType.isWatch
            ? IconButton(
                onPressed: () => Navigator.of(context).popUntil((route) => route.isFirst),
                icon: Icon(
                  Icons.check_circle_outline,
                  color: Theme.of(context).colorScheme.onBackground,
                  size: 16,
                ),
              )
            : TextButton(
                onPressed: () => Navigator.of(context).popUntil((route) => route.isFirst),
                child: Text(
                  "Close",
                  style: Theme.of(context).textTheme.displayMedium,
                ),
              ),
      ],
    );
  }
}
