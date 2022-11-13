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
      case DeviceType.phone:
        return const MobileSettingsButton();
      case DeviceType.tablet:
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
      icon: Icons.settings,
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
    return CircularIconButton(
      borderRadius: 20,
      icon: Icons.settings,
      onPressed: onSettingsPressed(context, ref),
    );
  }

  void Function() onSettingsPressed(BuildContext context, WidgetRef ref) {
    return () {
      ref.read(appViewProvider.notifier).enterSettingsState(context);
    };
  }
}
