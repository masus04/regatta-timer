import 'package:flutter/material.dart';

class CircularIconButton extends StatelessWidget {
  final IconData icon;
  final void Function() onPressed;

  const CircularIconButton({super.key, required this.icon, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Ink(
        decoration: ShapeDecoration(
          color: Colors.white,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        ),
        child: IconButton(
          icon: Icon(
            icon,
            size: 18,
          ),
          onPressed: onPressed,
          constraints: BoxConstraints.tight(const Size.fromRadius(18)),
        ),
      ),
    );
  }
}
