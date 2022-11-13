import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:regatta_timer/components/widget_accidental_interaction_preventer.dart';
import 'package:regatta_timer/components/controls/button_settings.dart';
import 'package:regatta_timer/components/controls/widget_time_selector.dart';
import 'package:regatta_timer/components/layouts/layout_watch.dart';
import 'package:regatta_timer/providers/boat_speed_provider.dart';
import 'package:regatta_timer/views/set_time/button_start.dart';
import 'package:regatta_timer/views/set_time/button_timer.dart';

class WatchSetTimeView extends HookConsumerWidget {
  const WatchSetTimeView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Trigger provider initialization
    ref.read(boatSpeedProvider);

    return Scaffold(
      body: Stack(
        alignment: AlignmentDirectional.centerStart,
        children: const [
          WatchLayout(
            topButton: TimerButton(),
            bottomButton: StartButton(),
            centerWidget: TimeSelector(),
            leftButton: AccidentalInteractionPreventer(
              size: Size(50, 60),
              alignment: AlignmentDirectional.centerStart,
              child: SettingsButton(),
            ),
          ),
        ],
      ),
    );
  }
}
