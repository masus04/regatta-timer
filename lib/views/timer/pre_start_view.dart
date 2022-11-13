import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:regatta_timer/components/layouts/watch_layouts/watch_layout.dart';
import 'package:regatta_timer/components/timer.dart';
import 'package:regatta_timer/providers/timer_provider.dart';
import 'package:regatta_timer/views/timer/reset_button.dart';
import 'package:regatta_timer/views/timer/sync_button.dart';

class PreStartView extends HookConsumerWidget {
  const PreStartView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentTime = ref.watch(timerProvider);

    return WatchLayout(
      topButton: const ResetButton(),
      bottomButton: const SyncButton(),
      centerWidget: Timer(currentTime!),
    );
  }
}
