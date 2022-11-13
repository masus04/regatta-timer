import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:regatta_timer/components/circular_icon_button.dart';
import 'package:regatta_timer/providers/app_view_provider.dart';

class SettingsButton extends HookConsumerWidget {
  const SettingsButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return CircularIconButton(
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
