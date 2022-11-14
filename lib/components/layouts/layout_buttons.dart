import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:regatta_timer/providers/layout_provider.dart';

enum WatchLayoutButtonType { topButton, bottomButton }

class LayoutButton extends HookConsumerWidget {
  final String text;
  final void Function() onPressed;

  final ButtonStyle buttonStyle;
  final TextStyle? textStyle;

  final bool longPressRequired;

  final WatchLayoutButtonType watchLayoutButtonType;

  const LayoutButton({
    super.key,
    required this.text,
    required this.onPressed,
    required this.buttonStyle,
    required this.watchLayoutButtonType,
    this.textStyle,
    this.longPressRequired = false,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    switch (ref.watch(uiProvider).deviceType) {
      case DeviceType.watch:
        switch (watchLayoutButtonType) {
          case WatchLayoutButtonType.topButton:
            return WatchLayoutTopButton(text: text, onPressed: onPressed, buttonStyle: buttonStyle);
          case WatchLayoutButtonType.bottomButton:
            return WatchLayoutBottomButton(text: text, onPressed: onPressed, buttonStyle: buttonStyle);
        }
      default:
        return MobileLayoutButton(text: text, onPressed: onPressed, buttonStyle: buttonStyle, longPressRequired: longPressRequired);
    }
  }
}

class MobileLayoutButton extends StatelessWidget {
  final String text;
  final void Function() onPressed;

  final ButtonStyle buttonStyle;
  final TextStyle? textStyle;

  final bool longPressRequired;

  const MobileLayoutButton({
    super.key,
    required this.text,
    required this.onPressed,
    required this.buttonStyle,
    this.textStyle,
    this.longPressRequired = false,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onLongPress: onPressed,
      onPressed: longPressRequired ? () {} : onPressed,
      style: buttonStyle,
      child: Text(text, style: textStyle ?? Theme.of(context).textTheme.labelLarge),
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
    super.key,
    required this.text,
    required this.onPressed,
    required this.buttonStyle,
    this.textStyle,
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
  final TextStyle? textStyle;

  final bool longPressRequired;

  const WatchLayoutBottomButton({
    super.key,
    required this.text,
    required this.onPressed,
    required this.buttonStyle,
    this.textStyle,
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
