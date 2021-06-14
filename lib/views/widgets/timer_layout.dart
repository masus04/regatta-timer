import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:regatta_timer/constants.dart';

import '../providers/_providers.dart';

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

    final lock = useProvider(appLockProvider);

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Header
          Expanded(
            flex: 4,
            child: _LayoutHeader(title: title),
          ),
          // Time Slot
          Expanded(
            flex: 4,
            child: IgnorePointer(
              ignoring: lock.state,
              child: Container(
                color: Colors.white,
                alignment: isWatch ? Alignment.bottomCenter : Alignment.center,
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: body,
              ),
            ),
          ),
          // Buttons
          Expanded(
            flex: 6,
            child: IgnorePointer(
              ignoring: lock.state,
              child: Container(
                decoration:
                    BoxDecoration(color: Colors.black12.withOpacity(0.05)),
                width: double.infinity,
                child: button,
              ),
            ),
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
    final fontSize = (MediaQuery.of(context).size.width / 13).floorToDouble();

    final lockProvider = useProvider(appLockProvider);

    _onLockPressed() {
      lockProvider.state = !lockProvider.state;
    }

    return TextButton(
      style: ElevatedButton.styleFrom(elevation: 0, primary: Colors.indigo),
      child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            AutoSizeText(
              title,
              textAlign: TextAlign.center,
              maxLines: 1,
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: fontSize,
              ),
            ),
            Icon(
              lockProvider.state ? Icons.lock : Icons.lock_open_outlined,
              color: Colors.white,
              size: fontSize,
            ),
          ]),
      onPressed: _onLockPressed,
    );
  }
}

class TimerButton extends HookWidget {
  final String text;
  final Color? textColor;
  final void Function() onPressed;

  final TextButton? secondaryButton;

  const TimerButton({
    required this.text,
    this.textColor,
    required this.onPressed,
    this.secondaryButton,
    required Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final fontSize =
        (MediaQuery.of(context).size.width / 13).floorToDouble() * 1.5;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Expanded(
          flex: 3,
          child: TextButton(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  flex: 3,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      AutoSizeText(
                        text,
                        maxLines: 1,
                        style: TextStyle(
                          color: textColor ?? Theme.of(context).primaryColor,
                          fontWeight: FontWeight.bold,
                          fontSize: fontSize,
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                    flex: secondaryButton == null ? 2 : 0,
                    child: const SizedBox.shrink())
              ],
            ),
            onPressed: onPressed,
          ),
        ),
        Expanded(
          flex: secondaryButton == null ? 0 : 2,
          child: secondaryButton ?? const SizedBox.shrink(),
        ),
      ],
    );
  }
}
