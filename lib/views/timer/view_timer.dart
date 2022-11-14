import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:regatta_timer/providers/timer_providers.dart';
import 'package:regatta_timer/views/timer/view_post_start_timer.dart';
import 'package:regatta_timer/views/timer/view_pre_start_timer.dart';

class TimerView extends HookConsumerWidget {
  const TimerView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: ref.watch(timerProvider).nextStartTimer.isNegative ? const PreStartTimerView() : const PostStartTimerView(),
    );
  }
}
