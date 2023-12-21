import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:regatta_timer/controllers/ui_utils.dart';

enum WatchLayoutButtonType { topButton, bottomButton }

class LayoutButton extends HookConsumerWidget {
  final String? text;
  final Widget? child;
  final void Function()? onPressed;

  final Color buttonColor;
  final double elevation;

  final bool longPressRequired;

  final WatchLayoutButtonType watchLayoutButtonType;

  const LayoutButton({
    super.key,
    this.text,
    this.child,
    this.onPressed,
    required this.buttonColor,
    required this.watchLayoutButtonType,
    this.elevation = 8,
    this.longPressRequired = false,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (!((text != null) ^ (child != null))) {
      throw Exception("Either text or child parameters must be passed to LayoutButton");
    }

    switch (UiUtils(context).deviceType) {
      case DeviceType.watch:
        switch (watchLayoutButtonType) {
          case WatchLayoutButtonType.topButton:
            return WatchLayoutTopButton(
              onPressed: onPressed,
              buttonColor: buttonColor,
              longPressRequired: longPressRequired,
              elevation: elevation,
              child: child ??
                  Text(
                    text!,
                    style: Theme.of(context).textTheme.labelLarge,
                  ),
            );
          case WatchLayoutButtonType.bottomButton:
            return WatchLayoutBottomButton(
              onPressed: onPressed,
              buttonColor: buttonColor,
              longPressRequired: longPressRequired,
              elevation: elevation,
              child: child ??
                  Text(
                    text!,
                    style: Theme.of(context).textTheme.labelLarge,
                  ),
            );
        }
      default:
        return MobileLayoutButton(
          onPressed: onPressed,
          buttonColor: buttonColor,
          longPressRequired: longPressRequired,
          elevation: elevation,
          child: child ??
              Text(
                text!,
                style: Theme.of(context).textTheme.labelLarge?.copyWith(
                      color: Theme.of(context).colorScheme.onPrimary,
                    ),
              ),
        );
    }
  }
}

class MobileLayoutButton extends StatelessWidget {
  final Widget child;
  final void Function()? onPressed;

  final Color buttonColor;
  final double elevation;

  final bool longPressRequired;

  const MobileLayoutButton({
    super.key,
    required this.child,
    this.onPressed,
    required this.buttonColor,
    this.elevation = 8,
    this.longPressRequired = false,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onLongPress: onPressed,
      onPressed: longPressRequired ? () {} : onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: buttonColor,
        elevation: 8,
        shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
      ),
      child: child,
    );
  }
}

class WatchLayoutTopButton extends StatelessWidget {
  final Widget child;
  final void Function()? onPressed;

  final Color buttonColor;
  final double elevation;

  final bool longPressRequired;

  const WatchLayoutTopButton({
    super.key,
    required this.child,
    this.onPressed,
    required this.buttonColor,
    this.elevation = 8,
    this.longPressRequired = false,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onLongPress: onPressed,
      onPressed: longPressRequired ? () {} : onPressed,
      style: TextButton.styleFrom(
        backgroundColor: buttonColor,
        elevation: 8,
        shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
      ),
      child: Column(
        /// Place Text in the middle between center element & screen edge
        children: [
          Expanded(
            flex: 4,
            child: FittedBox(
              fit: BoxFit.scaleDown,
              child: child,
            ),
          ),
          const Spacer(
            flex: 1,
          ),
        ],
      ),
    );
  }
}

class WatchLayoutBottomButton extends StatelessWidget {
  final Widget child;
  final void Function()? onPressed;

  final Color buttonColor;
  final double elevation;

  final bool longPressRequired;

  const WatchLayoutBottomButton({
    super.key,
    required this.child,
    this.onPressed,
    required this.buttonColor,
    this.elevation = 8,
    this.longPressRequired = false,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onLongPress: onPressed,
      onPressed: longPressRequired ? () {} : onPressed,
      style: TextButton.styleFrom(
        backgroundColor: buttonColor,
        elevation: 8,
        shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
      ),
      child: Column(
        /// Place Text in the middle between center element & screen edge
        children: [
          const Spacer(
            flex: 1,
          ),
          Expanded(
            flex: 4,
            child: FittedBox(
              fit: BoxFit.scaleDown,
              child: child,
            ),
          ),
        ],
      ),
    );
  }
}
