import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:regatta_timer/components/button_circular_icon.dart';
import 'package:regatta_timer/controllers/ui_utils.dart';
import 'package:regatta_timer/providers/timer_extensions.dart';

class CharlyModeToggleWidgetMobile extends HookConsumerWidget {
  const CharlyModeToggleWidgetMobile({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ListTile(
      title: Text("Charly Mode", style: Theme.of(context).textTheme.displayMedium),
      trailing: Transform.scale(
        scale: UiUtils(context).switchScaleFactor,
        child: Switch(
          value: ref.watch(charlyModeExtension.select((state) => state.enabled)),
          thumbColor: MaterialStateProperty.all(Theme.of(context).colorScheme.onPrimary),
          activeTrackColor: Theme.of(context).colorScheme.primary,
          inactiveTrackColor: Theme.of(context).colorScheme.primary.withOpacity(.5),
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
          onChanged: (newValue) => ref.read(charlyModeExtension.notifier).charlyModeEnabled = newValue,
        ),
      ),
    );
  }
}

class CharlyModeToggleWidgetWatch extends HookConsumerWidget {
  const CharlyModeToggleWidgetWatch({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return CircularIconButton(
      borderRadius: 20,
      backgroundColor: Theme.of(context).colorScheme.background,
      iconColor: Theme.of(context).colorScheme.onBackground,
      onPressed: () => ref.read(charlyModeExtension.notifier).charlyModeEnabled = !ref.watch(charlyModeExtension.select((state) => state.enabled)),
      child: CharlyModeIconWatch(
        enabled: ref.watch(charlyModeExtension).enabled,
      ),
    );
  }
}

class CharlyModeIconWatch extends StatelessWidget {
  final bool enabled;

  const CharlyModeIconWatch({super.key, required this.enabled});

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      child: Padding(
        padding: const EdgeInsets.only(top: 16, bottom: 8, left: 16, right: 16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            FittedBox(
              child: Text(
                "Charly",
                style: TextStyle(
                  fontWeight: FontWeight.w900,
                  color: Theme.of(context).colorScheme.onBackground,
                ),
              ),
            ),
            Switch(
              value: enabled,
              onChanged: null,
              activeColor: Theme.of(context).colorScheme.onBackground,
              activeTrackColor: Theme.of(context).colorScheme.onBackground.withOpacity(.5),
              inactiveTrackColor: Theme.of(context).colorScheme.onBackground.withOpacity(.2),
            ),
          ],
        ),
      ),
    );
  }
}
