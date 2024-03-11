import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:regatta_timer/components/layouts/layout_buttons.dart';
import 'package:regatta_timer/controllers/app_view_controller.dart';
import 'package:regatta_timer/providers/settings_provider.dart';

class StartButton extends HookConsumerWidget {
  const StartButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Semantics(
      label: "Start Button",
      hint: "Press to start timer",
      child: LayoutButton(
        text: "Start",
        onPressed: () async => await ref.read(appViewController.notifier).enterPreStartState(context),
        longPressRequired: ref.watch(settingsProvider).longPressToStart,
        buttonColor: Theme.of(context).colorScheme.secondary,
        watchLayoutButtonType: WatchLayoutButtonType.bottomButton,
      ),
    );
  }
}
