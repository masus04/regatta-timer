import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:regatta_timer/components/circular_icon_button.dart';
import 'package:regatta_timer/providers/app_lock_provider.dart';

class LockScreenButton extends HookConsumerWidget {
  const LockScreenButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isScreenLocked = ref.watch(appLockedProvider);

    return CircularIconButton(
      icon: isScreenLocked ? Icons.lock : Icons.lock_open,
      onPressed: onLockScreenPressed(context, ref),
    );
  }

  void Function() onLockScreenPressed(BuildContext context, WidgetRef ref) {
    return () {
      ref.watch(appLockedProvider.notifier).toggle();
    };
  }
}
