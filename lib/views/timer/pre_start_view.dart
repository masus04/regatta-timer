import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:regatta_timer/providers/timer_provider_v2.dart';
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

    return RegattaTimerLayout(
      topButton: const ResetButton(),
      bottomButton: const SyncButton(),
      centerWidget: currentTime.when(
        data: (timer) => StartTimer(timer),
        error: (err, stackTrace) => Text(err.toString()),
        loading: () => StartTimer(syncTime),
      ),
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
      onPressed: onResetPressed(context, ref),
      child: Text("Reset", style: Theme.of(context).textTheme.button),
      style: TextButton.styleFrom(
          backgroundColor: Theme.of(context).colorScheme.tertiary),
    );
  }

  void Function() onResetPressed(BuildContext context, WidgetRef ref) {
    return () {
      Navigator.pop(context);
    };
  }
}

class SyncButton extends HookConsumerWidget {
  const SyncButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return TextButton(
      onPressed: onSyncPressed(context, ref),
      child: Text("Sync", style: Theme.of(context).textTheme.button),
      style: TextButton.styleFrom(
          backgroundColor: Theme.of(context).colorScheme.primary),
    );
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
