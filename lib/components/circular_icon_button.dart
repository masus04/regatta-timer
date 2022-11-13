import 'package:flutter/material.dart';

class CircularIconButton extends StatelessWidget {
  final IconData icon;
  final void Function() onPressed;
  
  final double borderRadius;

  const CircularIconButton({super.key, required this.icon, required this.onPressed, required this.borderRadius});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Ink(
        decoration: ShapeDecoration(
          color: Colors.white,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(borderRadius)),
        ),
        child: IconButton(
          icon: Icon(
            icon,
            size: borderRadius,
          ),
          onPressed: onPressed,
          constraints: BoxConstraints.tight(Size.fromRadius(borderRadius)),
        ),
      ),
    );
  }
}
