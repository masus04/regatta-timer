import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:regatta_timer/components/layouts/layout_buttons.dart';
import 'package:regatta_timer/providers/settings_provider.dart';
import 'package:regatta_timer/providers/timer_providers.dart';

class SyncButton extends HookConsumerWidget {
  const SyncButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Semantics(
      label: "Sync Button",
      hint: "Sync time to the next rounded minute in order to improve accuracy",
      child: LayoutButton(
        text: "Sync",
        onPressed: onSyncPressed(context, ref),
        buttonColor: Theme.of(context).colorScheme.primary,
        longPressRequired: ref.watch(settingsProvider).longPressToSync,
        watchLayoutButtonType: WatchLayoutButtonType.bottomButton,
      ),
    );
  }

  void Function() onSyncPressed(BuildContext context, WidgetRef ref) {
    return () {
      ref.read(timerControllerProvider.notifier).syncTimer();
    };
  }
}
