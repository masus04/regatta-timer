import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:regatta_timer/components/layouts/mobile_layouts/mobile_layout.dart';
import 'package:regatta_timer/components/layouts/watch_layouts/watch_layout.dart';
import 'package:regatta_timer/components/timer.dart';
import 'package:regatta_timer/providers/layout_provider.dart';
import 'package:regatta_timer/providers/timer_provider.dart';
import 'package:regatta_timer/views/timer/end_race_button.dart';
import 'package:regatta_timer/views/timer/race_info_button.dart';

class PostStartView extends HookConsumerWidget {
  const PostStartView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentTime = ref.watch(timerProvider);

    switch (ref.watch(uiProvider).deviceType) {
      case DeviceType.watch:
        return WatchLayout(
          topButton: const EndRaceButton(),
          bottomButton: const RaceInfoButton(),
          centerWidget: Timer(currentTime!),
        );
      default:
        return MobileLayout(
          primaryButton: const EndRaceButton(),
          secondaryButton: const RaceInfoButton(),
          centerWidget: Timer(currentTime!),
        );
    }
  }
}
