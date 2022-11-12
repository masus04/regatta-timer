import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:regatta_timer/components/timer.dart';
import 'package:regatta_timer/components/watch_layout.dart';
import 'package:regatta_timer/providers/app_view_provider.dart';
import 'package:regatta_timer/providers/settings_provider.dart';
import 'package:regatta_timer/providers/timer_provider.dart';

class PreStartView extends HookConsumerWidget {
  const PreStartView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentTime = ref.watch(timerProvider);

    return WatchLayout(
      topButton: WatchLayoutTopButton(
        text: "Reset",
        onPressed: onResetPressed(context, ref),
        buttonStyle: TextButton.styleFrom(
          backgroundColor: Theme.of(context).colorScheme.tertiary,
        ),
        longPressRequired: ref.watch(settingsProvider).longPressToResetPreStart,
      ),
      bottomButton: WatchLayoutBottomButton(
        text: "Sync",
        onPressed: onSyncPressed(context, ref),
        buttonStyle: TextButton.styleFrom(backgroundColor: Theme.of(context).colorScheme.primary),
        longPressRequired: ref.watch(settingsProvider).longPressToSync,
      ),
      centerWidget: Timer(currentTime!),
    );
  }

  void Function() onResetPressed(BuildContext context, WidgetRef ref) {
    return () {
      ref.watch(appViewProvider.notifier).enterSetTimeState(context);
    };
  }

  void Function() onSyncPressed(BuildContext context, WidgetRef ref) {
    return () {
      ref.watch(timerProvider.notifier).sync();
    };
  }
}
