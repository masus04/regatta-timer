import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:regatta_timer/controllers/ui_utils.dart';
import 'package:regatta_timer/views/set_time/view_set_time_mobile.dart';
import 'package:regatta_timer/views/set_time/view_set_time_watch.dart';

class SetTimeView extends HookConsumerWidget {
  const SetTimeView() : super(key: const Key("SetTimeView"));

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Semantics(
      label: "Set Timer View",
      hint: "Allows the user to select the start time",
      child: buildView(UiUtils(context).deviceType),
    );
  }

  Widget buildView(DeviceType deviceType) {
    switch (deviceType) {
      case DeviceType.watch:
        return const WatchSetTimeView();

      case DeviceType.phone:
        return const MobileSetTimeView();

      case DeviceType.tablet:
        return const MobileSetTimeView();
    }
  }
}
