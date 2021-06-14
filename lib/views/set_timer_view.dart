import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:wakelock/wakelock.dart';

import 'providers/_providers.dart';
import '_views.dart';
import 'package:regatta_timer/values.dart';

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
    final fontSize = fontSizeFromScreenSize(context);

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: NumberPicker(
            minValue: 0,
            maxValue: startTimeOptions.length - 1,
            value: selectedTimeIndexProvider.state,
            onChanged: (selected) {
              selectedTimeIndexProvider.state = selected;
            },
            textStyle: TextStyle(fontSize: fontSize * 0.75),
            selectedTextStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
            ),
            textMapper: (number) => '${startTimeOptions[int.parse(number)]}',
            itemHeight: fontSize * 1.2,
            itemWidth: fontSize * 3,
            itemCount: 3,
          ),
        ),
        Expanded(
          child: AutoSizeText(
            'Minutes',
            maxLines: 1,
            style: TextStyle(fontSize: fontSize, fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }
}
