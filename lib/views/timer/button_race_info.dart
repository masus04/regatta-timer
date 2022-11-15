import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:regatta_timer/components/layouts/layout_buttons.dart';
import 'package:regatta_timer/providers/boat_speed_provider.dart';

class RaceInfoWidget extends HookConsumerWidget {
  const RaceInfoWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return LayoutButton(
      text: ref.watch(positionProvider).when(
            // TODO: Check settings for unit preference
            data: (boatSpeed) {
              return "${boatSpeed.knots.toStringAsFixed(1)} kn";
            },
            error: (err, trace) {
              debugPrintStack(label: "BoatSpeedError", stackTrace: trace);
              return "BoatSpeedError";
            },
            loading: () => "Loading BSp",
          ),
      onPressed: onInfoPressed(context, ref),
      buttonStyle: TextButton.styleFrom(backgroundColor: Theme.of(context).colorScheme.primary),
      longPressRequired: false,
      watchLayoutButtonType: WatchLayoutButtonType.bottomButton,
    );
  }

  void Function() onInfoPressed(BuildContext context, WidgetRef ref) {
    return () {};
  }
}
