import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:regatta_timer/components/layouts/layout_buttons.dart';
import 'package:regatta_timer/components/layouts/layout_mobile.dart';
import 'package:regatta_timer/components/layouts/layout_watch.dart';
import 'package:regatta_timer/components/regatta_timer_logo.dart';
import 'package:regatta_timer/controllers/app_view_controller.dart';
import 'package:regatta_timer/controllers/ui_utils.dart';
import 'package:regatta_timer/providers/timer_providers.dart';

class EndOfRaceView extends StatelessWidget {
  const EndOfRaceView({super.key});

  @override
  Widget build(BuildContext context) {
    return buildView(deviceType: UiUtils(context).deviceType);
  }

  Widget buildView({required DeviceType deviceType}) {
    switch (deviceType) {
      case DeviceType.watch:
        return const EndOfRaceViewWatch();
      default:
        return const EndOfRaceViewMobile();
    }
  }
}

class EndOfRaceViewWatch extends HookConsumerWidget {
  const EndOfRaceViewWatch({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return WatchLayout(
      topButton: LayoutButton(
        text: "Race Results",
        watchLayoutButtonType: WatchLayoutButtonType.topButton,
        buttonColor: Theme.of(context).primaryColor,
      ),
      centerWidget: Text(
        "Race Time: ${ref.read(timerController).format()}",
        textAlign: TextAlign.center,
        style: Theme.of(context).textTheme.titleMedium?.copyWith(
              color: Theme.of(context).colorScheme.onSurface,
            ),
      ),
      bottomButton: LayoutButton(
        text: "Reset",
        watchLayoutButtonType: WatchLayoutButtonType.bottomButton,
        buttonColor: Theme.of(context).colorScheme.tertiary,
        onPressed: () {
          ref.read(appViewController.notifier).enterSetTimeState();
          Navigator.of(context).popUntil((route) => route.isFirst);
        },
      ),
    );
  }
}

class EndOfRaceViewMobile extends HookConsumerWidget {
  const EndOfRaceViewMobile({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MobileLayout(
      title: const RegattaTimerLogo(),
      centerWidget: const EndOfRaceInfoMobile(),
      primaryButton: Expanded(
        child: LayoutButton(
          text: "Reset",
          onPressed: () {
            ref.read(appViewController.notifier).enterSetTimeState();
            Navigator.of(context).popUntil((route) => route.isFirst);
          },
          buttonColor: Theme.of(context).colorScheme.tertiary,
          watchLayoutButtonType: WatchLayoutButtonType.bottomButton,
        ),
      ),
    );
  }
}

class EndOfRaceInfoMobile extends HookConsumerWidget {
  const EndOfRaceInfoMobile({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.all(32),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FittedBox(
            child: Text(
              "Race Completed!\n",
              style: Theme.of(context).textTheme.displayLarge,
            ),
          ),
          Text.rich(
            TextSpan(
              style: Theme.of(context).textTheme.titleMedium,
              children: [
                const TextSpan(text: "Race Time: "),
                TextSpan(
                  text: "${ref.watch(timerController).format()}\n",
                  style: Theme.of(context).textTheme.displayMedium?.copyWith(fontWeight: FontWeight.bold),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
