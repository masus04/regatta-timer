import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:regatta_timer/providers/timer_provider.dart';
import 'package:regatta_timer/views/components/layout.dart';
import 'package:regatta_timer/views/components/timer.dart';

class PreStartView extends HookConsumerWidget {
  const PreStartView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentTime = ref.watch(currentTimeProvider);
    final syncTime = ref.watch(timerProvider.notifier).syncTarget;

    final resetButton = TopButton(
      text: Text("Reset", style: Theme.of(context).textTheme.button),
      onPressed: onResetPressed(context, ref),
      buttonStyle: TextButton.styleFrom(
          backgroundColor: Theme.of(context).colorScheme.tertiary),
    );

    final syncButton = BottomButton(
      text: Text("Sync", style: Theme.of(context).textTheme.button),
      onPressed: onSyncPressed(context, ref),
      buttonStyle: TextButton.styleFrom(
          backgroundColor: Theme.of(context).colorScheme.primary),
    );

    return RegattaTimerLayout(
      topButton: resetButton,
      bottomButton: syncButton,
      centerWidget: currentTime.when(
        data: (timer) => StartTimer(timer),
        error: (err, stackTrace) => Text(err.toString()),
        loading: () => StartTimer(syncTime),
      ),
    );
  }

  void Function() onResetPressed(BuildContext context, WidgetRef ref) {
    return () {
      ref.watch(timerProvider.notifier).abort();
      Navigator.pop(context);
    };
  }

  void Function() onSyncPressed(BuildContext context, WidgetRef ref) {
    return () {
      ref.watch(timerProvider.notifier).sync();
    };
  }
}

class StartTimer extends StatelessWidget {
  final Duration time;

  const StartTimer(
    this.time, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Timer(time);
  }
}
