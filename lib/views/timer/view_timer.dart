import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:regatta_timer/providers/timer_providers.dart';
import 'package:regatta_timer/views/timer/post_start/view_post_start_timer.dart';
import 'package:regatta_timer/views/timer/pre_start/view_pre_start_timer.dart';

class TimerView extends HookConsumerWidget {
  const TimerView() : super(key: const Key("TimerView"));

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: PopScope(
        canPop: false,
        child: ref.watch(timeToStartProvider).value?.isNegative ?? false ? const PreStartTimerView() : const PostStartTimerView(),
      ),
    );
  }
}
