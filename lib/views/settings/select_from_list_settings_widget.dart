import 'package:flutter/material.dart';

class SelectFromListSetting extends StatelessWidget {
  final String text;
  final void Function() onPressed;

  final double fontSize;
  final EdgeInsetsGeometry contentPadding;

  const SelectFromListSetting({
    Key? key,
    required this.text,
    required this.onPressed,
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
      trailing: IconButton(
        onPressed: onPressed,
        icon: const Icon(Icons.list, color: Colors.white),
      ),
      dense: true,
      visualDensity: VisualDensity.compact,
    );
  }
}
