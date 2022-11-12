import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:regatta_timer/providers/timer_provider.dart';
import 'package:regatta_timer/views/timer/post_start_view.dart';
import 'package:regatta_timer/views/timer/pre_start_view.dart';

class TimerView extends HookConsumerWidget {
  const TimerView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentTime = ref.watch(timerProvider);

    return Scaffold(body: currentTime!.isNegative ? const PreStartView() : const PostStartView());
  }
}
