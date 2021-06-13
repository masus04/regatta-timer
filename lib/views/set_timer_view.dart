import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:numberpicker/numberpicker.dart';
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
    final selectedTimeIndexProvider = useProvider(startTimeOptionIndexProvider);

    _startTimerPressed() {
      // Reset Timer
      timerNotifier.set(Duration(
          minutes: -startTimeOptions[selectedTimeIndexProvider.state]));

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
        title: 'Regatta Timer',
        body: const _TimeSelector(key: Key('TimerSelector'),),
        button: TimerButton(
          text: 'Start',
          textColor: Colors.green,
          onPressed: _startTimerPressed,
          key: const Key('StartTimerButton'),
        ),
        key: const Key('StartTimerLayout'));
  }
}

class _TimeSelector extends HookWidget {

  const _TimeSelector({required Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final selectedTimeIndexProvider = useProvider(startTimeOptionIndexProvider);

    final isWatch = useProvider(isWatchProvider);
    final textSize = isWatch ? TextSize.watch : TextSize.other;

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        NumberPicker(
          minValue: 0,
          maxValue: startTimeOptions.length - 1,
          value: selectedTimeIndexProvider.state,
          onChanged: (selected) {
            selectedTimeIndexProvider.state = selected;
          },
          textStyle: TextStyle(fontSize: textSize * 0.75),
          selectedTextStyle: TextStyle(
            fontSize: textSize,
            fontWeight: FontWeight.bold,
          ),
          textMapper: (number) => '${startTimeOptions[int.parse(number)]}',
          itemHeight: textSize * 1.2,
          itemWidth: 3 * textSize,
          itemCount: 3,
        ),
        Text(
          'Minutes',
          style: TextStyle(fontSize: textSize, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}
