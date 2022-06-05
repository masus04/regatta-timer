import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:regatta_timer/providers/app_lock_provider.dart';

class RegattaTimerLayout extends HookConsumerWidget {
  final TopButton topButton;
  final BottomButton bottomButton;
  final Widget centerWidget;

  const RegattaTimerLayout({
    required this.topButton,
    required this.bottomButton,
    required this.centerWidget,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final screenLocked = ref.watch(appLockedProvider);

    return SafeArea(
      child: Stack(
        alignment: AlignmentDirectional.centerEnd,
        children: [
          IgnorePointer(
            ignoring: screenLocked,
            child: Stack(
              fit: StackFit.expand,
              // Stack center widget on top of both buttons
              children: [
                Container(color: Colors.white),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Expanded(child: topButton),
                    SizedBox.fromSize(size: const Size.fromHeight(5)),
                    Expanded(child: bottomButton),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Spacer(flex: 1),
                    Expanded(
                      flex: 3,
                      child: Container(
                        height: 75,
                        color: Colors.white,
                        child: centerWidget,
                      ),
                    ),
                    const Spacer(flex: 1),
                  ],
                ),
              ],
            ),
          ),
          const LockScreenButton(),
        ],
      ),
    );
  }
}

class TopButton extends StatelessWidget {
  final Text text;
  final void Function() onPressed;
  final ButtonStyle buttonStyle;
  final bool longPressRequired;

  const TopButton({
    Key? key,
    required this.text,
    required this.onPressed,
    required this.buttonStyle,
    this.longPressRequired = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onLongPress: onPressed,
      onPressed: longPressRequired ? () {} : onPressed,
      style: buttonStyle,
      child: Column(
        children: [
          Expanded(
            flex: 4,
            child: FittedBox(
              fit: BoxFit.scaleDown,
              child: text,
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

class BottomButton extends StatelessWidget {
  final Text text;
  final void Function() onPressed;
  final ButtonStyle buttonStyle;
  final bool longPressRequired;

  const BottomButton({
    Key? key,
    required this.text,
    required this.onPressed,
    required this.buttonStyle,
    this.longPressRequired = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onLongPress: onPressed,
      onPressed: longPressRequired ? () {} : onPressed,
      style: buttonStyle,
      child: Column(
        children: [
          const Spacer(
            flex: 2,
          ),
          Expanded(
            flex: 4,
            child: FittedBox(
              fit: BoxFit.scaleDown,
              child: text,
            ),
          ),
        ],
      ),
    );
  }
}

class LockScreenButton extends HookConsumerWidget {
  const LockScreenButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isScreenLocked = ref.watch(appLockedProvider);

    return Padding(
      padding: const EdgeInsets.only(right: 1),
      child: Material(
        color: Colors.transparent,
        child: Ink(
          decoration: ShapeDecoration(
            color: Colors.white,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          ),
          child: IconButton(
            onPressed: onLockScreenPressed(context, ref),
            icon: Icon(
              isScreenLocked ? Icons.lock : Icons.lock_open,
              size: 18,
            ),
            constraints: BoxConstraints.tight(const Size.fromRadius(18)),
          ),
        ),
      ),
    );
  }

  void Function() onLockScreenPressed(BuildContext context, WidgetRef ref) {
    return () {
      ref.watch(appLockedProvider.notifier).toggle();
    };
  }
}
