import 'package:flutter/material.dart';

class RegattaTimerLayout extends StatelessWidget {
  final TopButton topButton;
  final BottomButton bottomButton;
  final Widget centerWidget;

  const RegattaTimerLayout({
    required this.topButton,
    required this.bottomButton,
    required this.centerWidget,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Stack(
        fit: StackFit.expand,
        // Stack center widget on top of both buttons
        children: [
          Container(color: Colors.white),
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(child: topButton),
              SizedBox.fromSize(size: const Size.fromHeight(5)),
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
      ),
    );
  }
}

class TopButton extends StatelessWidget {
  final Text text;
  final void Function() onPressed;
  final ButtonStyle buttonStyle;

  const TopButton({
    Key? key,
    required this.text,
    required this.onPressed,
    required this.buttonStyle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      style: buttonStyle,
      child: Column(
        children: [
          Expanded(
            flex: 4,
            child: FittedBox(
              fit: BoxFit.scaleDown,
              child: text,
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

class BottomButton extends StatelessWidget {
  final Text text;
  final void Function() onPressed;
  final ButtonStyle buttonStyle;

  const BottomButton({
    Key? key,
    required this.text,
    required this.onPressed,
    required this.buttonStyle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      style: buttonStyle,
      child: Column(
        children: [
          const Spacer(
            flex: 2,
          ),
          Expanded(
            flex: 4,
            child: FittedBox(
              fit: BoxFit.scaleDown,
              child: text,
            ),
          ),
        ],
      ),
    );
    ;
  }
}
