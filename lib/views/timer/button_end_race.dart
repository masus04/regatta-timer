import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:regatta_timer/components/layouts/layout_watch.dart';
import 'package:regatta_timer/providers/app_view_provider.dart';
import 'package:regatta_timer/providers/settings_provider.dart';

class EndRaceButton extends HookConsumerWidget {
  const EndRaceButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return WatchLayoutTopButton(
      text: "End Race",
      onPressed: onEndRacePressed(context, ref),
      buttonStyle: TextButton.styleFrom(backgroundColor: Theme.of(context).colorScheme.secondary),
      longPressRequired: ref.watch(settingsProvider).longPressToResetPostStart,
    );
  }

  void Function() onEndRacePressed(BuildContext context, WidgetRef ref) {
    return () {
      ref.watch(appViewProvider.notifier).enterSetTimeState(context);
    };
  }
}
