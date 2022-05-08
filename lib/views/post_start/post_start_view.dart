import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:regatta_timer/providers/selected_start_time_provider.dart';
import 'package:regatta_timer/views/components/layout.dart';
import 'package:regatta_timer/views/components/timer.dart';

class PostStartView extends HookConsumerWidget {
  const PostStartView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const RegattaTimerLayout(
      topButton: ResetButton(),
      bottomButton: InfoButton(),
      centerWidget: RaceTimer(),
    );
  }
}

class ResetButton extends HookConsumerWidget {
  const ResetButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return TextButton(
      onPressed: onPressedReset(context),
      child: Text("Reset", style: Theme.of(context).textTheme.button),
      style: TextButton.styleFrom(
          backgroundColor: Theme.of(context).colorScheme.tertiary),
    );
  }

  void Function() onPressedReset(BuildContext context) {
    return () {
      Navigator.pop(context);
    };
  }
}

class InfoButton extends HookConsumerWidget {
  const InfoButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return TextButton(
      onPressed: () {},
      child: Text("Info", style: Theme.of(context).textTheme.button),
      style: TextButton.styleFrom(
          backgroundColor: Theme.of(context).colorScheme.primary),
    );
  }
}

class RaceTimer extends HookConsumerWidget {
  const RaceTimer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Timer(
      -ref.watch(selectedStartTimeProvider.notifier).selectedDuration,
    );
  }
}
