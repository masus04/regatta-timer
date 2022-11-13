import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:regatta_timer/components/layouts/layout_mobile.dart';
import 'package:regatta_timer/components/layouts/layout_watch.dart';
import 'package:regatta_timer/providers/boat_speed_provider.dart';
import 'package:regatta_timer/providers/layout_provider.dart';

class RaceInfoWidget extends HookConsumerWidget {
  const RaceInfoWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    switch (ref.watch(uiProvider).deviceType) {
      case DeviceType.watch:
        return WatchLayoutBottomButton(
          text: ref.watch(boatSpeedProvider).when(
                // TODO: Check settings for unit preference
                data: (boatSpeed) => "${boatSpeed.knots.toStringAsFixed(1)} kn",
                error: (err, trace) => "BoatSpeedError",
                loading: () => "Racing",
              ),
          onPressed: onInfoPressed(context, ref),
          buttonStyle: TextButton.styleFrom(backgroundColor: Theme.of(context).colorScheme.primary),
        );
      default:
        return MobileLayoutButton(
          text: ref.watch(boatSpeedProvider).when(
                // TODO: Check settings for unit preference
                data: (boatSpeed) => "BSp: ${boatSpeed.knots.toStringAsFixed(1)} kn",
                error: (err, trace) => "BoatSpeedError",
                loading: () => "Racing",
              ),
          textStyle: Theme.of(context).textTheme.labelMedium?.copyWith(fontSize: 40),
          onPressed: onInfoPressed(context, ref),
          buttonStyle: TextButton.styleFrom(backgroundColor: Theme.of(context).colorScheme.primary),
          longPressRequired: false,
        );
    }
  }

  void Function() onInfoPressed(BuildContext context, WidgetRef ref) {
    return () {};
  }
}
