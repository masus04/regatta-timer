import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:regatta_timer/views/providers/_providers.dart';

void main() {
  runApp(const RegattaTimer(
    key: Key('RegattaTimer'),
  ));
}

class RegattaTimer extends StatelessWidget {
  const RegattaTimer({required Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Regatta Timer',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
      ),
      home: const ProviderScope(
        child: SafeArea(
          child: Scaffold(
            body: _RegattaTimerNavigator(key: Key('RegattaTimerNavigator'),),
          ),
        ),
      ),
    );
  }
}

class _RegattaTimerNavigator extends HookWidget {
  const _RegattaTimerNavigator({
    required Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isWatch = useProvider(isWatchProvider);
    final pages = useProvider(pageNotifierProvider);

    return Container(
      margin: isWatch ? const EdgeInsets.all(0) : const EdgeInsets.all(10),

      child: Navigator(
        pages: pages,
        onPopPage: (route, result) => route.didPop(result),
      ),
    );
  }
}
