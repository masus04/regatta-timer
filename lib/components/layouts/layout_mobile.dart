import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:regatta_timer/components/controls/button_lock_screen.dart';
import 'package:regatta_timer/providers/app_lock_provider.dart';

class MobileLayout extends HookConsumerWidget {
  final Widget? title;
  final Widget centerWidget;
  final Widget? subtitle;
  final Widget? primaryButton;
  final Widget? secondaryButton;

  final Iterable<Widget> additionalButtons;

  const MobileLayout({
    super.key,
    this.title,
    required this.centerWidget,
    this.subtitle,
    this.primaryButton,
    this.secondaryButton,
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
                  // mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SizedBox(
                      height: 250,
                      child: title ?? const SizedBox.shrink(),
                    ),
                    Container(
                      decoration: BoxDecoration(border: Border.all(color: Colors.indigo, width: 4)),
                      child: centerWidget,
                    ),
                    if (subtitle != null) subtitle!,
                    Expanded(
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          const SizedBox.shrink(),
                          if (primaryButton != null) primaryButton!,
                          if (secondaryButton != null) secondaryButton!,
                          ...additionalButtons,
                        ].expand((element) => [element, const Spacer()]).toList(),
                      ),
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

// class MobileLayoutButton extends StatelessWidget {
//   final String text;
//   final void Function() onPressed;
//
//   final bool longPressRequired;
//
//   final ButtonStyle buttonStyle;
//   final TextStyle? textStyle;
//
//   const MobileLayoutButton({
//     super.key,
//     required this.text,
//     required this.onPressed,
//     required this.longPressRequired,
//     required this.buttonStyle,
//     this.textStyle,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return TextButton(
//       onLongPress: onPressed,
//       onPressed: longPressRequired ? () {} : onPressed,
//       style: buttonStyle,
//       child: Text(text, style: textStyle ?? Theme.of(context).textTheme.labelLarge),
//     );
//   }
// }
