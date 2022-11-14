import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:regatta_timer/components/layouts/layout_mobile.dart';
import 'package:regatta_timer/components/layouts/layout_watch.dart';
import 'package:regatta_timer/components/widget_timer.dart';
import 'package:regatta_timer/providers/layout_provider.dart';
import 'package:regatta_timer/providers/timer_provider.dart';
import 'package:regatta_timer/views/set_time/widget_charly_mode.dart';
import 'package:regatta_timer/views/timer/button_race_info.dart';
import 'package:regatta_timer/views/timer/button_reset.dart';
import 'package:regatta_timer/views/timer/button_sync.dart';

class PreStartTimerView extends HookConsumerWidget {
  const PreStartTimerView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentTime = ref.watch(timerProvider);

    switch (ref.read(uiProvider).deviceType) {
      case DeviceType.watch:
        return WatchLayout(
          topButton: const ResetButton(),
          bottomButton: const SyncButton(),
          centerWidget: TimerWidget(currentTime!.nextStartDuration),
        );
      default:
        return MobileLayout(
          title: const Padding(
            padding: EdgeInsets.only(bottom: 16),
            child: RaceInfoWidget(),
          ),
          subtitle: const CharlyModeEnabledHint(),
          primaryButton: const Expanded(
            flex: 10,
            child: ResetButton(),
          ),
          secondaryButton: const Expanded(
            flex: 10,
            child: SyncButton(),
          ),
          centerWidget: TimerWidget(currentTime!.nextStartDuration),
        );
    }
  }
}

