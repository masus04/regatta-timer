import 'package:flutter/material.dart';

class RegattaTimerLayout extends StatelessWidget {
  final Widget topButton;
  final Widget bottomButton;
  final Widget centerWidget;

  const RegattaTimerLayout({
    required this.topButton,
    required this.bottomButton,
    required this.centerWidget,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      // Stack center widget on top of both buttons
      children: [
        Container(color: Colors.white),
        Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(child: topButton),
            SizedBox.fromSize(size: const Size.fromHeight(10)),
            Expanded(child: bottomButton),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Spacer(flex: 1),
            Expanded(
              flex: 3,
              child: Container(
                height: 75,
                color: Colors.white,
                child: centerWidget,
              ),
            ),
            const Spacer(flex: 1),
          ],
        ),
      ],
    );
  }
}
