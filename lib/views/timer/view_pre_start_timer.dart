import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:regatta_timer/components/layouts/layout_watch.dart';
import 'package:regatta_timer/components/widget_timer.dart';
import 'package:regatta_timer/providers/timer_provider.dart';
import 'package:regatta_timer/views/timer/button_reset.dart';
import 'package:regatta_timer/views/timer/button_sync.dart';

class PreStartTimerView extends HookConsumerWidget {
  const PreStartTimerView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentTime = ref.watch(timerProvider);

    return WatchLayout(
      topButton: const ResetButton(),
      bottomButton: const SyncButton(),
      centerWidget: TimerWidget(currentTime!),
    );
  }
}
