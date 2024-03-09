import 'package:flutter/material.dart';

class CircularIconButton extends StatelessWidget {
  final Widget? child;
  final IconData? icon;
  final void Function()? onPressed;

  final double borderRadius;
  final Color? backgroundColor;
  final Color? iconColor;
  final double elevation;

  const CircularIconButton({
    super.key,
    this.child,
    this.icon,
    required this.onPressed,
    required this.borderRadius,
    this.backgroundColor,
    this.iconColor,
    this.elevation = 8,
  });

  @override
  Widget build(BuildContext context) {
    if ((icon != null) == (child != null)) {
      throw StateError("Provide either parameter icon or child, but not both");
    }

    return SizedBox.square(
      dimension: borderRadius * 2,
      child: TextButton(
        onPressed: onPressed,
        style: TextButton.styleFrom(
          elevation: elevation,
          padding: EdgeInsets.zero,
          backgroundColor: backgroundColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(200),
          ),
        ),
        child: icon != null
            ? Icon(
                icon,
                color: iconColor ?? Colors.blueGrey.shade900,
                size: borderRadius,
              )
            : child!,
      ),
    );
  }
}
