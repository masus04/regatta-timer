import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:regatta_timer/controllers/ui_utils.dart';

class BooleanSetting extends HookConsumerWidget {
  final String text;
  final bool value;

  final void Function(bool) onChanged;

  final EdgeInsetsGeometry contentPadding;

  const BooleanSetting({
    super.key,
    required this.text,
    required this.value,
    required this.onChanged,
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
        scale: UiUtils(context).switchScaleFactor,
        child: Switch(
          value: value,
          onChanged: onChanged,
          activeTrackColor: Colors.indigo.shade200,
          inactiveTrackColor: Colors.indigo.shade400,
          thumbColor: MaterialStateProperty.all(Theme.of(context).colorScheme.onPrimary),
          trackOutlineColor: MaterialStateProperty.all(Colors.transparent),
          thumbIcon: MaterialStateProperty.resolveWith<Icon?>(
            (Set<MaterialState> states) {
              if (states.contains(MaterialState.selected)) {
                return Icon(
                  Icons.check,
                  color: Theme.of(context).colorScheme.primary,
                );
              }
              return null;
            },
          ),
        ),
      ),
      dense: true,
      visualDensity: VisualDensity.compact,
    );
  }
}
