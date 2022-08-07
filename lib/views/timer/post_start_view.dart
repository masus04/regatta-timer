import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:regatta_timer/providers/app_view_provider.dart';
import 'package:regatta_timer/providers/boat_speed_provider.dart';
import 'package:regatta_timer/providers/settings_provider.dart';
import 'package:regatta_timer/providers/timer_provider.dart';
import 'package:regatta_timer/views/components/layout.dart';
import 'package:regatta_timer/views/components/timer.dart';

class PostStartView extends HookConsumerWidget {
  const PostStartView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentTime = ref.watch(timerProvider);

    final endRaceButton = TopButton(
      text: Text("End Race", style: Theme.of(context).textTheme.button),
      onPressed: onEndRacePressed(context, ref),
      buttonStyle: TextButton.styleFrom(backgroundColor: Theme.of(context).colorScheme.secondary),
      longPressRequired: ref.watch(settingsProvider).longPressToResetPostStart,
    );

    final infoButton = BottomButton(
      text: Text(
        ref.watch(boatSpeedProvider).when(
              // TODO: Check settings for unit preference
              data: (boatSpeed) => "${boatSpeed.knots.toStringAsFixed(1)} knots",
              error: (err, trace) => "BoatSpeedError",
              loading: () => "Racing",
            ),
        style: Theme.of(context).textTheme.button,
        maxLines: 2,
      ),
      onPressed: onInfoPressed(context, ref),
      buttonStyle: TextButton.styleFrom(backgroundColor: Theme.of(context).colorScheme.primary),
    );

    return RegattaTimerLayout(
      topButton: endRaceButton,
      bottomButton: infoButton,
      centerWidget: RaceTimer(currentTime!),
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

class RaceTimer extends StatelessWidget {
  final Duration time;

  const RaceTimer(
    this.time, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Timer(time);
  }
}
