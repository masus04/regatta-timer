import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:regatta_timer/components/controls/button_lock_screen.dart';
import 'package:regatta_timer/components/widget_accidental_interaction_preventer.dart';
import 'package:regatta_timer/providers/app_lock_provider.dart';

class WatchLayout extends HookConsumerWidget {
  final Widget topButton;
  final Widget bottomButton;
  final Widget centerWidget;

  final Widget leftCircularButton;

  const WatchLayout({
    super.key,
    required this.topButton,
    required this.bottomButton,
    required this.centerWidget,
    this.leftCircularButton = const SizedBox.shrink(),
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final screenLocked = ref.watch(appLockedProvider);

    return Material(
      /// Background
      color: Theme.of(context).colorScheme.surface,
      child: Stack(
        fit: StackFit.expand,
        // Stack center widget on top of both buttons
        children: [
          /// Top & Bottom Buttons
          IgnorePointer(
            ignoring: screenLocked,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(child: topButton),
                SizedBox.fromSize(size: const Size.fromHeight(5)),
                Expanded(child: bottomButton),
              ],
            ),
          ),

          /// Center elements
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IgnorePointer(
                ignoring: screenLocked,
                child: SizedBox(
                  width: 45,
                  height: 60,
                  child: leftCircularButton,
                ),
              ),
              const Spacer(),
              // Take up space vertically
              Expanded(
                flex: 15,
                // Take up space horizontally
                child: SizedBox(
                  height: 75,
                  child: IgnorePointer(
                    ignoring: screenLocked,
                    child: Material(
                      elevation: 8,
                      color: Theme.of(context).colorScheme.surface,
                      child: centerWidget,
                    ),
                  ),
                ),
              ),
              const Spacer(),
              const AccidentalInteractionPreventer(
                size: Size(45, 60),
                alignment: AlignmentDirectional.centerEnd,
                child: LockScreenButton(),
              ),
            ],
          ),
        ],
      ),
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
