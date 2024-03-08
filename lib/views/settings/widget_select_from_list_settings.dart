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
        icon: Icon(Icons.list, color: Theme.of(context).colorScheme.onPrimary),
      ),
      dense: true,
      visualDensity: VisualDensity.compact,
    );
  }
}
