import 'package:flutter/material.dart';

class CircularIconButton extends StatelessWidget {
  final IconData icon;
  final void Function() onPressed;

  final double borderRadius;
  final Color backgroundColor;
  final Color iconColor;

  const CircularIconButton({
    super.key,
    required this.icon,
    required this.onPressed,
    required this.borderRadius,
    this.backgroundColor = Colors.white,
    this.iconColor = Colors.black,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Ink(
        decoration: ShapeDecoration(
          color: backgroundColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
          ),
        ),
        child: IconButton(
          icon: Icon(
            icon,
            color: iconColor,
            size: borderRadius,
          ),
          onPressed: onPressed,
          constraints: BoxConstraints.tight(Size.fromRadius(borderRadius)),
        ),
      ),
    );
  }
}
