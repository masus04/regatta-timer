import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:regatta_timer/constants.dart';
import 'package:regatta_timer/views/page_provider.dart';

import '_providers.dart';

class TimerLayout extends HookWidget {
  final String title;
  final Widget body;
  final TimerButton button;

  const TimerLayout({
    required this.title,
    required this.body,
    required this.button,
    required Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isWatch = useProvider(isWatchProvider);

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _LayoutHeader(title: title),
          Expanded(
            child: Container(
                alignment: isWatch ? Alignment.bottomCenter : Alignment.center,
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: body),
          ),
          Expanded(
            flex: 2,
            child: Container(
                decoration:
                    BoxDecoration(color: Colors.black12.withOpacity(0.05)),
                width: double.infinity,
                child: button),
          )
        ],
      ),
    );
  }
}

class _LayoutHeader extends HookWidget {
  const _LayoutHeader({
    Key? key,
    required this.title,
  }) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    final isWatch = useProvider(isWatchProvider);

    return Expanded(
      child: Container(
        color: Colors.indigo,
        child: Center(
            child: Text(
          title,
          style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: isWatch ? TextSize.watch : TextSize.other),
        )),
      ),
    );
  }
}

class TimerButton extends HookWidget {
  final String text;
  final void Function(PageNotifier, List<Page>) onPressed;

  const TimerButton({
    required this.text,
    required this.onPressed,
    required this.isWatch,
    required Key key,
  }) : super(key: key);

  final bool isWatch;

  @override
  Widget build(BuildContext context) {
    var pages = useProvider(pageNotifierProvider);
    var pagesNotifier = useProvider(pageNotifierProvider.notifier);

    return TextButton(
      onPressed: () => onPressed(pagesNotifier, pages),
      child: Column(
        children: [
          const Spacer(),
          Text(
            'Start',
            style: TextStyle(
              color: Colors.green,
              fontWeight: FontWeight.bold,
              fontSize: isWatch ? TextSize.watch : TextSize.other,
            ),
          ),
          const Spacer(
            flex: 2,
          ),
        ],
      ),
    );
  }
}
