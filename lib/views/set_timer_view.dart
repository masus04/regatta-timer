import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'providers/_providers.dart';
import '_views.dart';
import 'package:regatta_timer/constants.dart';

import 'widgets/_widgets.dart';

class SetTimerView extends HookWidget {
  const SetTimerView({required Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isWatch = useProvider(isWatchProvider);

    return const TimerLayout(
        title: 'Start Timer',
        body: _TimerSelector(),
        button: TimerButton(
          text: 'Start Timer',
          textColor: Colors.green,
          onPressed: _onStartButtonPressed,
          key: Key('StartTimerButton'),
        ),
        key: Key('StartTimerLayout'));
  }
}

_onStartButtonPressed(PageNotifier pageNotifier, List<Page> pages) {
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
}

class _TimerSelector extends HookWidget {
  static const timerOptions = [3, 5];

  const _TimerSelector({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isWatch = useProvider(isWatchProvider);
    final selectedTimer = useProvider(selectedTimerProvider);

    return DropdownButtonHideUnderline(
      child: DropdownButton<int>(
        isExpanded: true,
        value: selectedTimer.state,
        style: TextStyle(
            fontSize: isWatch ? TextSize.watch : TextSize.other,
            color: Colors.blueGrey),
        items: timerOptions
            .map((minute) => DropdownMenuItem(
                  value: minute,
                  child: Text(
                    '$minute min',
                    style: TextStyle(
                      fontSize: isWatch ? TextSize.watch : TextSize.other,
                      height: 0.5,
                    ),
                  ),
                ))
            .toList(),
        onChanged: (selected) {
          selectedTimer.state = selected ?? selectedTimer.state;
        },
      ),
    );
  }
}
