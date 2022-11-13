import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:regatta_timer/components/circular_icon_button.dart';
import 'package:regatta_timer/providers/app_view_provider.dart';
import 'package:regatta_timer/providers/layout_provider.dart';

class SettingsButton extends HookConsumerWidget {
  const SettingsButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    switch (ref.watch(uiProvider).deviceType) {
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
      onPressed: onSettingsPressed(context, ref),
    );
  }

  void Function() onSettingsPressed(BuildContext context, WidgetRef ref) {
    return () {
      ref.read(appViewProvider.notifier).enterSettingsState(context);
    };
  }
}

class MobileSettingsButton extends HookConsumerWidget {
  const MobileSettingsButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ElevatedButton(
      onPressed: onSettingsPressed(context, ref),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.settings_outlined,
              color: Colors.white,
            ),
            const SizedBox(width: 8),
            Text(
              "Settings",
              style: Theme.of(context).textTheme.labelMedium,
            ),
          ],
        ),
      ),
    );
  }

  void Function() onSettingsPressed(BuildContext context, WidgetRef ref) {
    return () {
      ref.read(appViewProvider.notifier).enterSettingsState(context);
    };
  }
}
