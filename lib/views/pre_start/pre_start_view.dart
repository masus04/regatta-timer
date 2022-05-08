import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:regatta_timer/providers/selected_start_time_provider.dart';
import 'package:regatta_timer/providers/timer_provider_v2.dart';
import 'package:regatta_timer/views/components/layout.dart';
import 'package:regatta_timer/views/components/timer.dart';

class PreStartView extends HookConsumerWidget {
  const PreStartView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final timer = ref.watch(currentTimeProvider);

    return RegattaTimerLayout(
        topButton: const ResetButton(),
        bottomButton: const SyncButton(),
        centerWidget: timer.when(
          data: (timer) => StartTimer(timer),
          error: (err, stackTrace) => Text(err.toString()),
          loading: () => const CircularProgressIndicator(),
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
      onPressed: onPressReset(context, ref),
      child: Text("Reset", style: Theme
          .of(context)
          .textTheme
          .button),
      style: TextButton.styleFrom(
          backgroundColor: Theme
              .of(context)
              .colorScheme
              .tertiary),
    );
  }

  void Function() onPressReset(BuildContext context, WidgetRef ref) {
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
      onPressed: onPressedSync(context, ref),
      child: Text("Sync", style: Theme
          .of(context)
          .textTheme
          .button),
      style: TextButton.styleFrom(
          backgroundColor: Theme
              .of(context)
              .colorScheme
              .primary),
    );
  }

  void Function() onPressedSync(BuildContext context, WidgetRef ref) {
    return () {
      ref.watch(timerProvider.notifier).sync();
    };
  }
}

class StartTimer extends StatelessWidget {
  final Duration timer;

  const StartTimer(this.timer, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Timer(timer);
  }
}
