import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'page_provider.dart';

class TimerView extends HookWidget {
  const TimerView({required Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    var pagesNotifier = useProvider(pageNotifierProvider.notifier);

    return Container(
      color: Colors.pink,
      child: TextButton(
        child: const Text('Stop'),
        onPressed: () {
          pagesNotifier.removeLast();
        },
      ),
    );
  }
}
