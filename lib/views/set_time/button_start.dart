import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:regatta_timer/components/layouts/layout_mobile.dart';
import 'package:regatta_timer/components/layouts/layout_watch.dart';
import 'package:regatta_timer/providers/app_view_provider.dart';
import 'package:regatta_timer/providers/layout_provider.dart';
import 'package:regatta_timer/providers/settings_provider.dart';

class StartButton extends HookConsumerWidget {
  const StartButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    switch (ref.watch(uiProvider).deviceType) {
      case DeviceType.watch:
        return WatchLayoutBottomButton(
          text: "Start",
          onPressed: onStartPressed(context, ref),
          longPressRequired: ref.watch(settingsProvider).longPressToStart,
          buttonStyle: TextButton.styleFrom(backgroundColor: Theme.of(context).colorScheme.secondary),
        );
      default:
        return MobileLayoutButton(
          text: "Start",
          onPressed: onStartPressed(context, ref),
          longPressRequired: ref.watch(settingsProvider).longPressToStart,
          buttonStyle: TextButton.styleFrom(backgroundColor: Theme.of(context).colorScheme.secondary),
        );
    }
  }

  void Function() onStartPressed(BuildContext context, WidgetRef ref) {
    return () {
      ref.watch(appViewProvider.notifier).enterPreStartState(context);
    };
  }
}