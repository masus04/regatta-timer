import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:regatta_timer/providers/app_lock_provider.dart';

class MobileLayout extends HookConsumerWidget {
  final MobileLayoutButton primaryButton;
  final MobileLayoutButton secondaryButton;
  final Widget centerWidget;

  final Iterable<Widget> additionalButtons;

  const MobileLayout({super.key, required this.primaryButton, required this.secondaryButton, required this.centerWidget, required this.additionalButtons});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final screenLocked = ref.watch(appLockedProvider);

    return Container();
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
      child: Text(text),
    );
  }
}
