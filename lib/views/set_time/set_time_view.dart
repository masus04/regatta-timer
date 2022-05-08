import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:regatta_timer/constants.dart';
import 'package:regatta_timer/providers/timer_provider_v2.dart';
import 'package:regatta_timer/views/components/layout.dart';
import 'package:regatta_timer/views/set_time/time_selector.dart';

class SetTimeView extends HookConsumerWidget {
  const SetTimeView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const RegattaTimerLayout(
      topButton: TimerTypeButton(),
      bottomButton: StartButton(),
      centerWidget: SetStartTimer(),
    );
  }
}

class TimerTypeButton extends HookConsumerWidget {
  const TimerTypeButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return TextButton(
      onPressed: () {},
      child: Text("Timer", style: Theme.of(context).textTheme.button),
      style: TextButton.styleFrom(
          backgroundColor: Theme.of(context).colorScheme.primary),
    );
  }
}

class StartButton extends HookConsumerWidget {
  const StartButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return TextButton(
      onPressed: onPressStart(context, ref),
      child: Text("Start", style: Theme.of(context).textTheme.button),
      style: TextButton.styleFrom(
          backgroundColor: Theme.of(context).colorScheme.secondary),
    );
  }

  void Function() onPressStart(BuildContext context, WidgetRef ref){
    return () {
      ref.watch(timerProvider.notifier).reset();
      Navigator.pushNamed(context, Routes.preStartRoute);
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
