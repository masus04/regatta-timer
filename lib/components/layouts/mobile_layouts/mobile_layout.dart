import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:regatta_timer/components/controls/lock_screen_button.dart';
import 'package:regatta_timer/providers/app_lock_provider.dart';
import 'package:regatta_timer/views/set_time/start_button.dart';

class MobileLayout extends HookConsumerWidget {
  final Widget primaryButton;
  final Widget secondaryButton;
  final Widget centerWidget;

  final Iterable<Widget> additionalButtons;

  const MobileLayout({
    super.key,
    required this.primaryButton,
    required this.secondaryButton,
    required this.centerWidget,
    this.additionalButtons = const [],
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final screenLocked = ref.watch(appLockedProvider);

    return Material(
      color: Colors.white,
      child: SafeArea(
        child: Stack(
          alignment: Alignment.topRight,
          children: [
            IgnorePointer(
              ignoring: screenLocked,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    SizedBox(
                      height: 250,
                      child: Image.asset("assets/icons/regatta_timer_with_border.png"),
                    ),
                    Container(
                      decoration: BoxDecoration(border: Border.all(color: Colors.indigo, width: 4)),
                      child: centerWidget,
                    ),
                    // const Spacer(),
                    // const RaceInfoWidget(),
                    const Spacer(),
                    const Expanded(
                      flex: 3,
                      child: StartButton(),
                    ),
                    const Spacer(),
                    ...additionalButtons.expand(
                      (button) => [
                        button,
                        const Spacer(),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const LockScreenButton(),
          ],
        ),
      ),
    );
  }
}

class MobileLayoutButton extends StatelessWidget {
  final String text;
  final void Function() onPressed;

  final bool longPressRequired;

  final ButtonStyle buttonStyle;

  const MobileLayoutButton({
    super.key,
    required this.text,
    required this.onPressed,
    required this.longPressRequired,
    required this.buttonStyle,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onLongPress: onPressed,
      onPressed: longPressRequired ? () {} : onPressed,
      style: buttonStyle,
      child: Text(text, style: Theme.of(context).textTheme.labelLarge),
    );
  }
}
