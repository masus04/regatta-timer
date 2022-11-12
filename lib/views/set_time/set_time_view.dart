import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:regatta_timer/providers/app_view_provider.dart';
import 'package:regatta_timer/providers/boat_speed_provider.dart';
import 'package:regatta_timer/providers/settings_provider.dart';
import 'package:regatta_timer/components/circular_icon_button.dart';
import 'package:regatta_timer/components/layout.dart';
import 'package:regatta_timer/views/set_time/time_selector.dart';

class SetTimeView extends HookConsumerWidget {
  const SetTimeView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Trigger provider initialization
    ref.read(boatSpeedProvider);

    final timerTypeButton = TopButton(
      text: Text("Timer", style: Theme.of(context).textTheme.button),
      onPressed: onTimerTypePressed(context, ref),
      buttonStyle: TextButton.styleFrom(backgroundColor: Theme.of(context).colorScheme.primary),
    );

    final startButton = BottomButton(
      text: Text("Start", style: Theme.of(context).textTheme.button),
      onPressed: onStartPressed(context, ref),
      buttonStyle: TextButton.styleFrom(backgroundColor: Theme.of(context).colorScheme.secondary),
      longPressRequired: ref.watch(settingsProvider).longPressToStart,
    );

    final settingsButton = Stack(
      alignment: AlignmentDirectional.centerStart,
      children: [
        Container(
          color: Colors.transparent,
          height: 60,
          width: 50,
          child: const IgnorePointer(ignoring: true),
        ),
        CircularIconButton(
          icon: Icons.settings,
          onPressed: onSettingsPressed(context, ref),
        ),
      ],
    );

    return Scaffold(
      body: Stack(
        alignment: AlignmentDirectional.centerStart,
        children: [
          RegattaTimerLayout(
            topButton: timerTypeButton,
            bottomButton: startButton,
            centerWidget: const SetStartTimer(),
          ),
          settingsButton,
        ],
      ),
    );
  }

  void Function() onTimerTypePressed(BuildContext context, WidgetRef ref) {
    return () {};
  }

  void Function() onStartPressed(BuildContext context, WidgetRef ref) {
    return () {
      ref.watch(appViewProvider.notifier).enterPreStartState(context);
    };
  }

  void Function() onSettingsPressed(BuildContext context, WidgetRef ref) {
    return () {
      ref.read(appViewProvider.notifier).enterSettingsState(context);
    };
  }
}

class SetStartTimer extends HookConsumerWidget {
  const SetStartTimer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const TimeSelector();
  }
}
