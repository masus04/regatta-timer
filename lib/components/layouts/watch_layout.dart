import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:regatta_timer/components/accidental_interaction_preventer.dart';
import 'package:regatta_timer/components/controls/lock_screen_button.dart';
import 'package:regatta_timer/providers/app_lock_provider.dart';

class WatchLayout extends HookConsumerWidget {
  final WatchLayoutTopButton topButton;
  final WatchLayoutBottomButton bottomButton;
  final Widget centerWidget;

  final Widget leftButton;
  final Widget rightButton;

  const WatchLayout({
    super.key,
    required this.topButton,
    required this.bottomButton,
    required this.centerWidget,
    this.leftButton = const SizedBox(width: 50, height: 60),
    this.rightButton = const AccidentalInteractionPreventer(
      /// Lock Screen Button
      size: Size(50, 60),
      alignment: AlignmentDirectional.centerEnd,
      child: LockScreenButton(),
    ),
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final screenLocked = ref.watch(appLockedProvider);

    return Stack(
      fit: StackFit.expand,
      // Stack center widget on top of both buttons
      children: [
        IgnorePointer(
          ignoring: screenLocked,
          child: Column(
            /// Top & Bottom Buttons
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(child: topButton),
              SizedBox.fromSize(size: const Size.fromHeight(5)),
              Expanded(child: bottomButton),
            ],
          ),
        ),
        Row(
          /// Center elements
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IgnorePointer(
              ignoring: screenLocked,
              child: leftButton,
            ),
            // const Spacer(flex: 1),
            Expanded(
              child: IgnorePointer(
                ignoring: screenLocked,
                child: Container(
                  height: 75,
                  color: Colors.white,
                  child: centerWidget,
                ),
              ),
            ),
            // const Spacer(flex: 1),
            rightButton,
          ],
        ),
      ],
    );
  }
}

class WatchLayoutTopButton extends StatelessWidget {
  final String text;
  final void Function() onPressed;

  final bool longPressRequired;

  final ButtonStyle buttonStyle;

  const WatchLayoutTopButton({
    super.key,
    required this.text,
    required this.onPressed,
    required this.buttonStyle,
    this.longPressRequired = false,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onLongPress: onPressed,
      onPressed: longPressRequired ? () {} : onPressed,
      style: buttonStyle,
      child: Column(
        /// Place Text in the middle between center element & screen edge
        children: [
          Expanded(
            flex: 4,
            child: FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                text,
                style: Theme.of(context).textTheme.labelLarge,
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

  final bool longPressRequired;

  const WatchLayoutBottomButton({super.key, required this.text, required this.onPressed, required this.buttonStyle, this.longPressRequired = false});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onLongPress: onPressed,
      onPressed: longPressRequired ? () {} : onPressed,
      style: buttonStyle,
      child: Column(
        /// Place Text in the middle between center element & screen edge
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
                style: Theme.of(context).textTheme.labelLarge,
                maxLines: 2,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
