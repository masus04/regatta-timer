import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:regatta_timer/components/accidental_interaction_preventer.dart';
import 'package:regatta_timer/components/controls/lock_screen_button.dart';
import 'package:regatta_timer/providers/app_lock_provider.dart';

class WatchLayout extends HookConsumerWidget {
  final WatchLayoutTopButton topButton;
  final WatchLayoutBottomButton bottomButton;
  final Widget centerWidget;

  const WatchLayout({required this.topButton, required this.bottomButton, required this.centerWidget, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final screenLocked = ref.watch(appLockedProvider);

    return Stack(
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
        const AccidentalInteractionPreventer(
          size: Size(50, 60),
          alignment: AlignmentDirectional.centerEnd,
          child: LockScreenButton(),
        ),
      ],
    );
  }
}

class WatchLayoutTopButton extends StatelessWidget {
  final String text;
  final void Function() onPressed;

  final ButtonStyle buttonStyle;
  final TextStyle? textStyle;

  final bool longPressRequired;

  const WatchLayoutTopButton({
    required this.text,
    required this.onPressed,
    required this.buttonStyle,
    this.textStyle,
    this.longPressRequired = false,
    Key? key
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
              child: Text(
                text,
                style: textStyle ?? Theme.of(context).textTheme.button,
                maxLines: 2,
              ),
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

class WatchLayoutBottomButton extends StatelessWidget {
  final String text;
  final void Function() onPressed;

  final ButtonStyle buttonStyle;
  final TextStyle? textStyle;

  final bool longPressRequired;

  const WatchLayoutBottomButton({
    Key? key,
    required this.text,
    required this.onPressed,
    required this.buttonStyle,
    this.textStyle,
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
              child: Text(
                text,
                style: textStyle ?? Theme.of(context).textTheme.button,
                maxLines: 2,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
