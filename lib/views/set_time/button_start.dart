import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:regatta_timer/components/layouts/layout_buttons.dart';
import 'package:regatta_timer/providers/app_view_provider.dart';
import 'package:regatta_timer/providers/settings_provider.dart';

class StartButton extends HookConsumerWidget {
  const StartButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return LayoutButton(
      text: "Start",
      onPressed: onStartPressed(context, ref),
      longPressRequired: ref.watch(settingsProvider).longPressToStart,
      buttonStyle: TextButton.styleFrom(backgroundColor: Theme.of(context).colorScheme.secondary),
      watchLayoutButtonType: WatchLayoutButtonType.bottomButton,
    );
  }

  void Function() onStartPressed(BuildContext context, WidgetRef ref) {
    return () {
      ref.watch(appViewProvider.notifier).enterPreStartState(context);
    };
  }
}
