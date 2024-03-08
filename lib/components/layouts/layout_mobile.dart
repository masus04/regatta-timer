import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:regatta_timer/components/controls/button_lock_screen.dart';
import 'package:regatta_timer/providers/app_lock_provider.dart';

class MobileLayout extends HookConsumerWidget {
  final Widget? title;
  final Widget centerWidget;
  final Widget? subtitle;
  final Widget? primaryButton;
  final Widget? secondaryButton;

  final Iterable<Widget> additionalButtons;

  const MobileLayout({
    super.key,
    this.title,
    required this.centerWidget,
    this.subtitle,
    this.primaryButton,
    this.secondaryButton,
    this.additionalButtons = const [],
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final screenLocked = ref.watch(appLockedProvider);

    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxHeight.abs() > constraints.maxWidth.abs()) {
          /// Vertical Layout
          return Material(
            color: Theme.of(context).colorScheme.background,
            child: SafeArea(
              child: Stack(
                alignment: Alignment.topRight,
                children: [
                  IgnorePointer(
                    ignoring: screenLocked,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 32),
                      child: Column(
                        // mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          const SizedBox(height: 8),
                          SizedBox(
                            height: 250,
                            child: title ?? const SizedBox.shrink(),
                          ),
                          const SizedBox(height: 8),
                          Material(
                            elevation: 8,
                            color: Theme.of(context).colorScheme.background,
                            // decoration: BoxDecoration(border: Border.all(color: Colors.indigo, width: 4)),
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                centerWidget,
                                if (subtitle != null) subtitle!,
                              ],
                            ),
                          ),
                          const SizedBox(height: 4),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 4),
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  if (primaryButton != null) primaryButton!,
                                  if (secondaryButton != null) secondaryButton!,
                                  ...additionalButtons,
                                ].expand((element) => [const SizedBox(height: 4), element, const SizedBox(height: 4)]).toList(),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const LockScreenButton(),
                ],
              ),
            ),
          );
        } else {
          /// Horizontal Layout
          return Material(
            color: Theme.of(context).colorScheme.background,
            child: SafeArea(
              child: Stack(
                alignment: Alignment.topRight,
                children: [
                  IgnorePointer(
                    ignoring: screenLocked,
                    child: Row(
                      children: [
                        Expanded(
                          flex: 2,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Expanded(child: title ?? const SizedBox.shrink()),
                              ].expand((element) => [const SizedBox(height: 4), element, const SizedBox(height: 4)]).toList(),
                            ),
                          ),
                        ),
                        // const VerticalDivider(color: Colors.indigo, thickness: 4),
                        const SizedBox(width: 4),
                        Expanded(
                          flex: 3,
                          child: Material(
                            elevation: 8,
                            color: Theme.of(context).colorScheme.background,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 8),
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  Column(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.stretch,
                                    children: [
                                      // const Divider(color: Colors.indigo, thickness: 4),
                                      centerWidget,
                                      // const Divider(color: Colors.indigo, thickness: 4),
                                      if (subtitle != null) subtitle!,
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        // const VerticalDivider(color: Colors.indigo, thickness: 4),
                        const SizedBox(width: 4),
                        Expanded(
                          flex: 2,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                if (primaryButton != null) primaryButton!,
                                secondaryButton ?? const SizedBox.shrink(),
                                ...additionalButtons,
                              ].expand((element) => [const SizedBox(height: 4), element, const SizedBox(height: 4)]).toList(),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  const LockScreenButton(),
                ],
              ),
            ),
          );
        }
      },
    );
  }
}
