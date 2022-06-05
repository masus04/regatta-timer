import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:regatta_timer/providers/app_view_provider.dart';
import 'package:regatta_timer/views/components/layout.dart';
import 'package:regatta_timer/views/set_time/time_selector.dart';

class SetTimeView extends HookConsumerWidget {
  const SetTimeView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final timerTypeButton = TopButton(
      text: Text("Timer", style: Theme.of(context).textTheme.button),
      onPressed: onTimerTypePressed(context, ref),
      buttonStyle: TextButton.styleFrom(
          backgroundColor: Theme.of(context).colorScheme.primary),
    );

    final startButton = BottomButton(
      text: Text("Start", style: Theme.of(context).textTheme.button),
      onPressed: onStartPressed(context, ref),
      buttonStyle: TextButton.styleFrom(
          backgroundColor: Theme.of(context).colorScheme.secondary),
    );

    return Scaffold(
      body: RegattaTimerLayout(
        topButton: timerTypeButton,
        bottomButton: startButton,
        centerWidget: const SetStartTimer(),
      ),
    );
  }

  void Function() onTimerTypePressed(BuildContext context, WidgetRef ref) {
    return () {};
  }

  void Function() onStartPressed(BuildContext context, WidgetRef ref) {
    return () {
      ref.watch(appViewProvider.notifier).enterPreStartState(context);
    };
  }
}

class SetStartTimer extends HookConsumerWidget {
  const SetStartTimer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const TimeSelector();
  }
}
