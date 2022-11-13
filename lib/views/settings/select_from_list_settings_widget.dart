import 'package:flutter/material.dart';

class SelectFromListSetting extends StatelessWidget {
  final String text;
  final void Function() onPressed;

  final EdgeInsetsGeometry contentPadding;

  const SelectFromListSetting({
    super.key,
    required this.text,
    required this.onPressed,
    this.contentPadding = const EdgeInsets.only(left: 35, right: 10),
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: contentPadding,
      title: Text(
        text,
        textAlign: TextAlign.left,
        style: Theme.of(context).textTheme.labelMedium,
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
