import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:regatta_timer/components/layouts/mobile_layouts/mobile_layout.dart';
import 'package:regatta_timer/components/layouts/watch_layouts/watch_layout.dart';
import 'package:regatta_timer/providers/layout_provider.dart';
import 'package:regatta_timer/providers/settings_provider.dart';
import 'package:regatta_timer/providers/timer_provider.dart';

class SyncButton extends HookConsumerWidget {
  const SyncButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    switch (ref.watch(uiProvider).deviceType) {
      case DeviceType.watch:
        return WatchLayoutBottomButton(
          text: "Sync",
          onPressed: onSyncPressed(context, ref),
          buttonStyle: TextButton.styleFrom(backgroundColor: Theme.of(context).colorScheme.primary),
          longPressRequired: ref.watch(settingsProvider).longPressToSync,
        );
      default:
        return MobileLayoutButton(
          text: "Sync",
          onPressed: onSyncPressed(context, ref),
          buttonStyle: TextButton.styleFrom(backgroundColor: Theme.of(context).colorScheme.primary),
          longPressRequired: ref.watch(settingsProvider).longPressToSync,
        );
    }
  }

  void Function() onSyncPressed(BuildContext context, WidgetRef ref) {
    return () {
      ref.watch(timerProvider.notifier).sync();
    };
  }
}
