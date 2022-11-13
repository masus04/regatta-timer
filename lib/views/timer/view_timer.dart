import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:regatta_timer/providers/timer_provider.dart';
import 'package:regatta_timer/views/timer/view_post_start.dart';
import 'package:regatta_timer/views/timer/view_pre_start.dart';

class TimerView extends HookConsumerWidget {
  const TimerView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentTime = ref.watch(timerProvider);

    return Scaffold(body: currentTime!.isNegative ? const PreStartView() : const PostStartView());
  }
}
