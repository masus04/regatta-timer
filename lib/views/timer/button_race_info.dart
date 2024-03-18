import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:regatta_timer/components/layouts/layout_buttons.dart';
import 'package:regatta_timer/controllers/ui_utils.dart';
import 'package:regatta_timer/providers/boat_speed_provider.dart';

class RaceInfoWidget extends HookConsumerWidget {
  const RaceInfoWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Semantics(
      label: "Race Info",
      hint: "Displays additional information such as boat speed and heading if enabled",
      child: IgnorePointer(
        // Prevent Button from accepting presses
        ignoring: true,
        child: LayoutButton(
          onPressed: () {},
          buttonColor: Theme.of(context).colorScheme.primary,
          longPressRequired: false,
          watchLayoutButtonType: WatchLayoutButtonType.bottomButton,
          child: ref.watch(positionProvider).when(
                data: (BoatPosition boatPosition) {
                  switch (UiUtils(context).deviceType) {
                    case DeviceType.watch:
                      return WatchRaceInfo(boatPosition: boatPosition);
                    default:
                      return MobileRaceInfo(boatPosition: boatPosition);
                  }
                },
                error: (error, stackTrace) {
                  debugPrintStack(label: "BoatSpeedError", stackTrace: stackTrace);
                  return Text(
                    "Racing!",
                    style: Theme.of(context).textTheme.labelLarge?.copyWith(
                          color: Theme.of(context).colorScheme.onPrimary,
                        ),
                  );
                },
                loading: () => Text(
                  "Racing!",
                  style: Theme.of(context).textTheme.labelLarge?.copyWith(
                        color: Theme.of(context).colorScheme.onPrimary,
                      ),
                ),
              ),
        ),
      ),
    );
  }
}

class WatchRaceInfo extends StatelessWidget {
  final BoatPosition boatPosition;

  const WatchRaceInfo({super.key, required this.boatPosition});

  @override
  Widget build(BuildContext context) {
    return IntrinsicWidth(
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            textBaseline: TextBaseline.alphabetic,
            children: [
              Text(
                "${boatPosition.knots.toStringAsFixed(1)} kn",
                style: Theme.of(context).textTheme.labelLarge?.copyWith(
                      color: Theme.of(context).colorScheme.onPrimary,
                    ),
              ),
              const Spacer(),
              const SizedBox(width: 4),
              Text(
                "BSp",
                style: Theme.of(context).textTheme.labelLarge?.copyWith(
                      color: Theme.of(context).colorScheme.onPrimary,
                    ),
                strutStyle: StrutStyle.fromTextStyle(Theme.of(context).textTheme.labelLarge!),
              ),
            ],
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            textBaseline: TextBaseline.alphabetic,
            children: [
              Text(
                "${boatPosition.position.heading.toStringAsFixed(0)} °",
                style: Theme.of(context).textTheme.labelLarge?.copyWith(
                      color: Theme.of(context).colorScheme.onPrimary,
                    ),
              ),
              const Spacer(),
              const SizedBox(width: 4),
              Text(
                "Head",
                style: Theme.of(context).textTheme.labelLarge?.copyWith(
                      color: Theme.of(context).colorScheme.onPrimary,
                    ),
                strutStyle: StrutStyle.fromTextStyle(Theme.of(context).textTheme.labelLarge!),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class MobileRaceInfo extends StatelessWidget {
  final BoatPosition boatPosition;

  const MobileRaceInfo({super.key, required this.boatPosition});

  @override
  Widget build(BuildContext context) {
    return IntrinsicWidth(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        // crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "${boatPosition.knots.toStringAsFixed(1)} kn",
            style: Theme.of(context).textTheme.labelLarge?.copyWith(
                  color: Theme.of(context).colorScheme.onPrimary,
                ),
          ),
          Align(
            alignment: Alignment.topRight,
            child: Text(
              "Boat Speed",
              style: Theme.of(context).textTheme.labelSmall?.copyWith(
                    color: Theme.of(context).colorScheme.onPrimary,
                  ),
            ),
          ),
          const SizedBox(height: 12),
          Text(
            "${boatPosition.position.heading.toStringAsFixed(0)} °",
            style: Theme.of(context).textTheme.labelLarge?.copyWith(
                  color: Theme.of(context).colorScheme.onPrimary,
                ),
          ),
          Align(
            alignment: Alignment.topRight,
            child: Text(
              "Heading",
              style: Theme.of(context).textTheme.labelSmall?.copyWith(
                    color: Theme.of(context).colorScheme.onPrimary,
                  ),
            ),
          ),
        ],
      ),
    );
  }
}
