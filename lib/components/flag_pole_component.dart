import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:regatta_timer/providers/flag_provider.dart';
import 'package:regatta_timer/providers/settings_provider.dart';

class FlagPole extends HookConsumerWidget {
  final bool expanded;

  const FlagPole({super.key, this.expanded = false});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentFlags = ref.watch(startProcedureProvider).displayedFlags;

    if (ref.watch(settingsProvider).startProcedureFlagsEnabled && currentFlags.isNotEmpty) {
      final flagPole = Padding(
        padding: const EdgeInsets.only(bottom: 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: currentFlags
              .map(
                (flag) => flag.svgImage,
              )
              .toList(),
        ),
      );

      if (expanded) {
        return Visibility(
          visible: ref.watch(settingsProvider).startProcedureFlagsEnabled,
          child: Expanded(
            child: flagPole,
          ),
        );
      }

      return Visibility(
        visible: ref.watch(settingsProvider).startProcedureFlagsEnabled,
        child: flagPole,
      );
    } else {
      return const SizedBox.shrink();
    }
  }
}
