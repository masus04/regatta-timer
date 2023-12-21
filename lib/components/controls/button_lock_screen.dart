import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:regatta_timer/components/button_circular_icon.dart';
import 'package:regatta_timer/controllers/ui_utils.dart';
import 'package:regatta_timer/providers/app_lock_provider.dart';

class LockScreenButton extends HookConsumerWidget {
  const LockScreenButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isScreenLocked = ref.watch(appLockedProvider);

    switch (UiUtils(context).deviceType) {
      case DeviceType.watch:
        return CircularIconButton(
          borderRadius: 20,
          icon: isScreenLocked ? Icons.lock : Icons.lock_open,
          backgroundColor: Theme.of(context).colorScheme.background,
          iconColor: Theme.of(context).colorScheme.onBackground,
          onPressed: onLockScreenPressed(context, ref),
        );
      default:
        return CircularIconButton(
          borderRadius: 30,
          icon: isScreenLocked ? Icons.lock : Icons.lock_open,
          backgroundColor: Theme.of(context).colorScheme.background,
          iconColor: Theme.of(context).colorScheme.onBackground,
          onPressed: onLockScreenPressed(context, ref),
        );
    }
  }

  void Function() onLockScreenPressed(BuildContext context, WidgetRef ref) {
    return () {
      ref.watch(appLockedProvider.notifier).toggle();
    };
  }
}
