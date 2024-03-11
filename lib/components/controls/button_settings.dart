import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:regatta_timer/components/button_circular_icon.dart';
import 'package:regatta_timer/controllers/app_view_controller.dart';
import 'package:regatta_timer/controllers/ui_utils.dart';

class SettingsButton extends HookConsumerWidget {
  const SettingsButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    switch (UiUtils(context).deviceType) {
      case DeviceType.watch:
        return const WatchSettingsButton();
      default:
        return const MobileSettingsButton();
    }
  }
}

class WatchSettingsButton extends HookConsumerWidget {
  const WatchSettingsButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return CircularIconButton(
      borderRadius: 20,
      icon: Icons.settings_outlined,
      backgroundColor: Theme.of(context).colorScheme.background,
      iconColor: Theme.of(context).colorScheme.onBackground,
      onPressed: () => ref.read(appViewController.notifier).enterSettingsState(context),
    );
  }
}

class MobileSettingsButton extends HookConsumerWidget {
  const MobileSettingsButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ElevatedButton(
      onPressed: () => ref.read(appViewController.notifier).enterSettingsState(context),
      style: ElevatedButton.styleFrom(
        backgroundColor: Theme.of(context).primaryColor,
        foregroundColor: Theme.of(context).colorScheme.onPrimary,
        shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.settings_outlined),
            const SizedBox(width: 8),
            Text(
              "Settings",
              style: Theme.of(context).textTheme.labelMedium?.copyWith(color: Theme.of(context).colorScheme.onPrimary),
            ),
          ],
        ),
      ),
    );
  }
}
