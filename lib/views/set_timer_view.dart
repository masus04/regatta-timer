import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:wakelock/wakelock.dart';

import 'providers/_providers.dart';
import '_views.dart';
import 'package:regatta_timer/constants.dart';

import 'widgets/_widgets.dart';

class SetTimerView extends HookWidget {
  const SetTimerView({required Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final pageNotifier = useProvider(pageNotifierProvider.notifier);
    final pages = useProvider(pageNotifierProvider);
    final timerNotifier = useProvider(startTimerProvider.notifier);
    final startTimer = useProvider(selectedStartTimeProvider).state;

    startTimerPressed() {
      // Reset Timer
      timerNotifier.set(Duration(minutes: -startTimer));

      // Navigate to TimerView
      pageNotifier.add(
        MaterialPage(
          child: const TimerView(
            key: Key('TimerView'),
          ),
          key: ValueKey('NewWidget-${pages.length}'),
          name: 'NewWidget-${pages.length}',
          fullscreenDialog: true,
          maintainState: true,
        ),
      );

      // Enable Wakelock - Wakelock is disabled once timer reaches 0:00
      Wakelock.enable();
    }

    return TimerLayout(
        title: 'Start Timer',
        body: const _TimerSelector(),
        button: TimerButton(
          text: 'Start',
          textColor: Colors.green,
          onPressed: startTimerPressed,
          key: const Key('StartTimerButton'),
        ),
        key: const Key('StartTimerLayout'));
  }
}

class _TimerSelector extends HookWidget {
  static const timerOptions = [3, 5];

  const _TimerSelector({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isWatch = useProvider(isWatchProvider);
    final selectedTimer = useProvider(selectedStartTimeProvider);

    final textSize = isWatch ? TextSize.watch : TextSize.other;

    return DropdownButton<int>(
      isExpanded: true,
      value: selectedTimer.state,
      style: TextStyle(
        fontSize: textSize,
        color: Colors.black87,
      ),
      menuMaxHeight: double.infinity,
      underline: const SizedBox.shrink(),
      items: timerOptions
          .map((minute) => DropdownMenuItem(
                value: minute,
                child: Text(
                  '$minute min',
                  style: TextStyle(
                    fontSize: textSize,
                    height: 0.5,
                    color: Colors.black87,
                  ),
                ),
              ))
          .toList(),
      onChanged: (selected) {
        selectedTimer.state = selected ?? selectedTimer.state;
      },
    );
  }
}
