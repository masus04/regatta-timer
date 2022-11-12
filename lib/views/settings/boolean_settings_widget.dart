import 'package:flutter/material.dart';

class BooleanSetting extends StatelessWidget {
  final String text;
  final bool value;

  final void Function(bool) onChanged;

  final double switchScale;
  final double fontSize;
  final EdgeInsetsGeometry contentPadding;

  const BooleanSetting({
    Key? key,
    required this.text,
    required this.value,
    required this.onChanged,
    this.switchScale = 0.75,
    this.fontSize = 10,
    this.contentPadding = const EdgeInsets.only(left: 35, right: 10),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: contentPadding,
      title: Text(
        text,
        textAlign: TextAlign.left,
        style: TextStyle(
          color: Colors.white,
          fontSize: fontSize,
        ),
      ),
      trailing: Transform.scale(
        scale: switchScale,
        child: Switch(
          value: value,
          onChanged: onChanged,
          activeColor: Colors.white,
        ),
      ),
      dense: true,
      visualDensity: VisualDensity.compact,
    );
  }
}
