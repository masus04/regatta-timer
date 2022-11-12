import 'package:flutter/material.dart';

class AccidentalInteractionPreventer extends StatelessWidget {
  final Widget child;
  final Size size;
  final AlignmentGeometry alignment;

  const AccidentalInteractionPreventer({Key? key, required this.child, required this.size, this.alignment = AlignmentDirectional.center}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: alignment,
      children: [
        Container(
          // Prevents clicks that miss the LockScreenButton very closely from hitting other nearby buttons
          color: Colors.transparent,
          height: size.height,
          width: size.width,
          child: const IgnorePointer(ignoring: true),
        ),
        child,
      ],
    );
  }
}
