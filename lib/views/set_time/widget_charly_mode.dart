import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:regatta_timer/providers/charly_mode_provider.dart';

class CharlyModeWidget extends HookConsumerWidget {
  const CharlyModeWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ListTile(
      title: Text("Charly Mode", style: Theme.of(context).textTheme.displayMedium),
      trailing: Switch(
        value: ref.watch(charlyModeProvider).enabled,
        activeColor: Colors.indigo,
        onChanged: onCharlyModeToggled(context, ref),
      ),
    );
  }

  void Function(bool) onCharlyModeToggled(BuildContext context, WidgetRef ref) {
    return (bool newValue) {
      ref.read(charlyModeProvider.notifier).charlyModeEnabled = newValue;
    };
  }
}

class CharlyModeEnabledHint extends HookConsumerWidget {
  const CharlyModeEnabledHint({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (ref.watch(charlyModeProvider).enabled) {
      return ListTile(
        title: Text(
          "Charly mode enabled",
          style: Theme.of(context).textTheme.displayMedium?.copyWith(color: Colors.green),
          textAlign: TextAlign.right,
        ),
        trailing: const Icon(
          Icons.check_circle_outline,
          color: Colors.green,
        ),
      );
    } else {
      return const SizedBox.shrink();
    }
  }
}
