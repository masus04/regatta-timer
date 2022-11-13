import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:regatta_timer/providers/layout_provider.dart';
import 'package:regatta_timer/views/set_time/mobile_set_time_view.dart';
import 'package:regatta_timer/views/set_time/watch_set_time_view.dart';

class SetTimeView extends HookConsumerWidget {
  const SetTimeView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
