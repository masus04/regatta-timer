import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:regatta_timer/components/flag_pole_component.dart';
import 'package:regatta_timer/components/layouts/layout_mobile.dart';
import 'package:regatta_timer/components/layouts/layout_watch.dart';
import 'package:regatta_timer/components/widget_accidental_interaction_preventer.dart';
import 'package:regatta_timer/components/widget_charly_mode.dart';
import 'package:regatta_timer/components/widget_timer.dart';
import 'package:regatta_timer/controllers/ui_utils.dart';
import 'package:regatta_timer/providers/settings_provider.dart';
import 'package:regatta_timer/providers/timer_providers.dart';
import 'package:regatta_timer/views/timer/button_race_info.dart';
import 'package:regatta_timer/views/timer/pre_start/button_reset.dart';
import 'package:regatta_timer/views/timer/pre_start/button_sync.dart';

class PreStartTimerView extends HookConsumerWidget {
  const PreStartTimerView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Semantics(
      label: "Pre Start Timer View",
      hint: "Displays the time remaining to race start",
      child: selectView(deviceType: UiUtils(context).deviceType),
    );
  }

  Widget selectView({required DeviceType deviceType}) {
    switch (deviceType) {
      case DeviceType.watch:
        return const PreStartViewWatch();
      default:
        return const PreStartViewMobile();
    }
  }
}

class PreStartViewMobile extends HookConsumerWidget {
  const PreStartViewMobile({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MobileLayout(
      title: const RaceInfoWidget(),
      subtitle: const Column(
        children: [
          FlagPole(),
          CharlyModeToggleWidgetMobile(),
        ],
      ),
      primaryButton: const Expanded(
        flex: 10,
        child: ResetButton(),
      ),
      secondaryButton: const Expanded(
        flex: 10,
        child: SyncButton(),
      ),
      centerWidget: TimerWidget(ref.watch(timerController)), // ref.watch(timerProvider).timeToStart),
    );
  }
}

class PreStartViewWatch extends HookConsumerWidget {
  const PreStartViewWatch({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return WatchLayout(
      topButton: const ResetButton(),
      bottomButton: const SyncButton(),
      centerWidget: Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            flex: 2,
            child: TimerWidget(ref.watch(timerController)),
          ),
          const FlagPole(expanded: true),
        ],
      ),
      leftCircularButton: Visibility(
        visible: ref.watch(settingsProvider).charlyModeToggleEnabled,
        child: const AccidentalInteractionPreventer(
          size: Size(50, 60),
          child: CharlyModeToggleWidgetWatch(),
        ),
      ),
    );
  }
}
