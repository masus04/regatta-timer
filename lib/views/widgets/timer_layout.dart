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
    final textSize = isWatch ? TextSize.watch : TextSize.other;

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
          Text(
            title,
            style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: textSize),
          ),
          Icon(
            lockProvider.state ? Icons.lock : Icons.lock_open_outlined,
            color: Colors.white,
          ),
        ]
      ),
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
    final isWatch = useProvider(isWatchProvider);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Expanded(
          flex: 2,
          child: TextButton(
            child: Column(
              children: [
                const Spacer(),
                Text(
                  text,
                  style: TextStyle(
                    color: textColor ?? Theme.of(context).primaryColor,
                    fontWeight: FontWeight.bold,
                    fontSize: isWatch ? TextSize.watch : TextSize.other,
                  ),
                ),
                Spacer(
                  flex: secondaryButton == null ? 2 : 1,
                ),
              ],
            ),
            onPressed: onPressed,
          ),
        ),
        Expanded(
          flex: secondaryButton == null ? 0 : 1,
          child: secondaryButton ?? const SizedBox.shrink(),
        ),
      ],
    );
  }
}
