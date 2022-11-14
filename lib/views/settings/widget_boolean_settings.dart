import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class BooleanSetting extends HookConsumerWidget {
  final String text;
  final bool value;

  final void Function(bool) onChanged;

  final String? toolTipText;

  final double switchScale;
  final EdgeInsetsGeometry contentPadding;

  const BooleanSetting({
    super.key,
    required this.text,
    required this.value,
    required this.onChanged,
    this.toolTipText,
    this.switchScale = 0.75,
    this.contentPadding = const EdgeInsets.only(left: 35, right: 10),
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ListTile(
      contentPadding: contentPadding,
      title: Text(
        text,
        textAlign: TextAlign.left,
        style: Theme.of(context).textTheme.labelMedium,
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
