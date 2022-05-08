import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:regatta_timer/providers/timer_provider_v2.dart';
import 'package:regatta_timer/views/components/layout.dart';
import 'package:regatta_timer/views/components/timer.dart';

class PostStartView extends HookConsumerWidget {
  const PostStartView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentTime = ref.watch(currentTimeProvider);

    return RegattaTimerLayout(
      topButton: const EndRaceButton(),
      bottomButton: const InfoButton(),
      centerWidget: currentTime.when(
        data: (time) => RaceTimer(time),
        error: (err, stackTrace) => Text(err.toString()),
        loading: () => const CircularProgressIndicator(), // This case should be unreachable
      ),
    );
  }
}

class EndRaceButton extends StatelessWidget {
  const EndRaceButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onEndRacePressed(context),
      child: Text("End Race", style: Theme.of(context).textTheme.button),
      style: TextButton.styleFrom(
          backgroundColor: Theme.of(context).colorScheme.secondary),
    );
  }

  void Function() onEndRacePressed(BuildContext context) {
    return () {
      Navigator.pop(context);
    };
  }
}

class InfoButton extends StatelessWidget {
  const InfoButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {},
      child: Text("Info", style: Theme.of(context).textTheme.button),
      style: TextButton.styleFrom(
          backgroundColor: Theme.of(context).colorScheme.primary),
    );
  }
}

class RaceTimer extends StatelessWidget {
  final Duration time;

  const RaceTimer(
    this.time, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Timer(time);
  }
}
