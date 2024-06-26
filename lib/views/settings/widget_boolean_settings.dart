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
        style: Theme.of(context).textTheme.labelMedium?.copyWith(color: Theme.of(context).colorScheme.onSurface),
      ),
      trailing: Transform.scale(
        scale: UiUtils(context).switchScaleFactor,
        child: Switch(
          value: value,
          onChanged: onChanged,
          activeColor: Theme.of(context).colorScheme.onSurface,
          inactiveTrackColor: Theme.of(context).colorScheme.onSurface.withAlpha(100),
          activeTrackColor: Theme.of(context).colorScheme.onSurface.withAlpha(200),
          thumbColor: WidgetStateProperty.all(Theme.of(context).colorScheme.onPrimary),
          trackOutlineColor: WidgetStateProperty.all(Colors.transparent),
          thumbIcon: WidgetStateProperty.resolveWith<Icon?>(
            (Set<WidgetState> states) {
              if (states.contains(WidgetState.selected)) {
                return const Icon(
                  Icons.check,
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
