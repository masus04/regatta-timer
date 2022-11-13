import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:regatta_timer/components/layouts/watch_layout.dart';
import 'package:regatta_timer/components/timer.dart';
import 'package:regatta_timer/providers/app_view_provider.dart';
import 'package:regatta_timer/providers/boat_speed_provider.dart';
import 'package:regatta_timer/providers/settings_provider.dart';
import 'package:regatta_timer/providers/timer_provider.dart';

class PostStartView extends HookConsumerWidget {
  const PostStartView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentTime = ref.watch(timerProvider);

    return WatchLayout(
      topButton: WatchLayoutTopButton(
        text: "End Race",
        onPressed: onEndRacePressed(context, ref),
        buttonStyle: TextButton.styleFrom(backgroundColor: Theme.of(context).colorScheme.secondary),
        longPressRequired: ref.watch(settingsProvider).longPressToResetPostStart,
      ),
      bottomButton: WatchLayoutBottomButton(
        text: ref.watch(boatSpeedProvider).when(
              // TODO: Check settings for unit preference
              data: (boatSpeed) => "${boatSpeed.knots.toStringAsFixed(1)} knots",
              error: (err, trace) => "BoatSpeedError",
              loading: () => "Racing",
            ),
        onPressed: onInfoPressed(context, ref),
        buttonStyle: TextButton.styleFrom(backgroundColor: Theme.of(context).colorScheme.primary),
      ),
      centerWidget: Timer(currentTime!),
    );
  }

  void Function() onEndRacePressed(BuildContext context, WidgetRef ref) {
    return () {
      ref.watch(appViewProvider.notifier).enterSetTimeState(context);
    };
  }

  void Function() onInfoPressed(BuildContext context, WidgetRef ref) {
    return () {};
  }
}
