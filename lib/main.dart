import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'views/providers/page_provider.dart';

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
    final pages = useProvider(pageNotifierProvider);

    return Navigator(
      pages: pages,
      onPopPage: (route, result) => route.didPop(result),
    );
  }
}
