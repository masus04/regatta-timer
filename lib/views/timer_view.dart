import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:regatta_timer/views/providers/_providers.dart';
import 'package:regatta_timer/views/widgets/_widgets.dart';

import '../constants.dart';
import 'providers/page_provider.dart';

class TimerView extends HookWidget {
  const TimerView({required Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var pagesNotifier = useProvider(pageNotifierProvider.notifier);

    return const TimerLayout(
      title: 'Racing',
      body: _RaceTimer(
        key: Key('RaceTimer'),
      ),
      button: TimerButton(
        text: 'Sync',
        onPressed: _onTimerStopped,
        key: Key('StopButton'),
      ),
      key: Key('TimerViewLayout'),
    );
  }
}

_onTimerStopped(PageNotifier pageNotifier, List<Page> pages) {
  pageNotifier.removeLast();
}

class _RaceTimer extends HookWidget {
  const _RaceTimer({required Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const String time = '3:30';

    final isWatch = useProvider(isWatchProvider);

    return Container(
      alignment: Alignment.center,
      child: Text(
        time,
        style: TextStyle(
            fontSize: isWatch ? TextSize.watch * 2 : TextSize.other * 2.5,
            fontWeight: FontWeight.bold,
            letterSpacing: 2),
      ),
    );
  }
}
