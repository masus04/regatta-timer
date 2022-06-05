import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:regatta_timer/constants.dart';
import 'package:regatta_timer/providers/selected_start_time_provider.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:regatta_timer/providers/settings_provider.dart';

class TimeSelector extends HookConsumerWidget {
  const TimeSelector({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final numberPickerIndex = ref.watch(selectedStartTimeProvider);
    final startTimeOptions =
        ref.watch(settingsProvider).selectedStartTimeOptions;

    return Container(
      height: TimerOptions.fontSize * TimerOptions.numItems,
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          NumberPicker(
            minValue: 0,
            maxValue: startTimeOptions.length - 1,
            value: numberPickerIndex,
            onChanged: onChange(ref),
            textStyle: Theme.of(context).textTheme.bodyText2?.copyWith(
                fontSize: TimerOptions.fontSize * 0.5,
                fontWeight: FontWeight.normal),
            selectedTextStyle: Theme.of(context).textTheme.bodyText1?.copyWith(
                  fontWeight: FontWeight.bold,
                  fontSize: TimerOptions.fontSize,
                ),
            textMapper: textMapper(ref),
            itemCount: 3,
            itemHeight: TimerOptions.fontSize,
            itemWidth: TimerOptions.fontSize * 2,
          ),
          Text(
            "min",
            style: Theme.of(context).textTheme.bodyText1?.copyWith(
                  fontSize: TimerOptions.fontSize,
                ),
          ),
        ],
      ),
    );
  }

  onChange(WidgetRef ref) {
    return (int newValue) {
      ref
          .watch(selectedStartTimeProvider.notifier)
          .setSelectedTimeIndex(newValue);
    };
  }

  String Function(String) textMapper(WidgetRef ref) {
    return (String numberString) {
      final index = int.parse(numberString);
      final minutes = ref
          .read(settingsProvider)
          .selectedStartTimeOptions[index]
          .startTime
          .inMinutes;
      return "$minutes";
    };
  }
}
