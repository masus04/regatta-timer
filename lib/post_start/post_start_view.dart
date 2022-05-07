import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:regatta_timer/components/layout.dart';

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
      onPressed: onReset(context),
      child: Text("Reset", style: Theme.of(context).textTheme.button),
      style: TextButton.styleFrom(
          backgroundColor: Theme.of(context).colorScheme.tertiary),
    );
  }

  void Function() onReset(BuildContext context) {
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
    return Container();
  }
}
