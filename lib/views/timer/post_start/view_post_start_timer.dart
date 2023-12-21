import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:regatta_timer/components/layouts/layout_mobile.dart';
import 'package:regatta_timer/components/layouts/layout_watch.dart';
import 'package:regatta_timer/components/widget_timer.dart';
import 'package:regatta_timer/controllers/ui_utils.dart';
import 'package:regatta_timer/providers/timer_providers.dart';
import 'package:regatta_timer/views/timer/button_race_info.dart';
import 'package:regatta_timer/views/timer/post_start/button_end_race.dart';

class PostStartTimerView extends HookConsumerWidget {
  const PostStartTimerView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ref.watch(timeToStartProvider).when(
          data: (tts) => Semantics(
            label: "Post Start Timer View",
            hint: "Displays the time passed since the race start",
            child: buildView(deviceType: UiUtils(context).deviceType, currentTime: tts),
          ),
          error: (error, stackTrace) => throw error,
          loading: () => const CircularProgressIndicator(),
        );
  }

  Widget buildView({required DeviceType deviceType, required Duration currentTime}) {
    switch (deviceType) {
      case DeviceType.watch:
        return WatchLayout(
          topButton: const EndRaceButton(),
          bottomButton: const RaceInfoWidget(),
          centerWidget: TimerWidget(currentTime),
        );
      default:
        return MobileLayout(
          title: const RaceInfoWidget(),
          primaryButton: const Expanded(
            flex: 10,
            child: EndRaceButton(),
          ),
          centerWidget: TimerWidget(currentTime),
        );
    }
  }
}
