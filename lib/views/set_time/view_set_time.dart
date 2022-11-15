import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:regatta_timer/providers/layout_provider.dart';
import 'package:regatta_timer/views/set_time/view_set_time_mobile.dart';
import 'package:regatta_timer/views/set_time/view_set_time_watch.dart';

class SetTimeView extends HookConsumerWidget {
  const SetTimeView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Trigger provider initialization
    // ref.watch(positionProvider);

    switch (ref.watch(uiProvider).deviceType) {
      case DeviceType.watch:
        return const WatchSetTimeView();
      case DeviceType.phone:
        return const MobileSetTimeView();
      case DeviceType.tablet:
        return const MobileSetTimeView();
    }
  }
}
