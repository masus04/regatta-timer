import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:regatta_timer/providers/layout_provider.dart';
import 'package:regatta_timer/providers/selected_start_time_provider.dart';
import 'package:regatta_timer/providers/settings_provider.dart';

class TimeSelector extends HookConsumerWidget {
  final int numOptions;

  const TimeSelector({super.key, this.numOptions = 3});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final numberPickerIndex = ref.watch(selectedStartTimeProvider);
    final startTimeOptions = ref.watch(settingsProvider).selectedStartTimeOptions;

    final fontSize = ref.read(uiProvider).displayFontSize;

    return Container(
      height: fontSize * numOptions,
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          NumberPicker(
            minValue: 0,
            maxValue: startTimeOptions.length - 1,
            value: numberPickerIndex,
            onChanged: onChange(ref),
            textStyle: Theme.of(context).textTheme.displaySmall,
            selectedTextStyle: Theme.of(context).textTheme.displayLarge,
            textMapper: textMapper(ref),
            itemCount: 3,
            itemHeight: fontSize,
            itemWidth: fontSize * 2,
          ),
          Text(
            "min",
            style: Theme.of(context).textTheme.displayLarge,
          ),
        ],
      ),
    );
  }

  onChange(WidgetRef ref) {
    return (int newValue) {
      ref.watch(selectedStartTimeProvider.notifier).setSelectedTimeIndex(newValue);
    };
  }

  String Function(String) textMapper(WidgetRef ref) {
    return (String numberString) {
      final index = int.parse(numberString);
      final minutes = ref.watch(settingsProvider).selectedStartTimeOptions[index].startTime.inMinutes;
      return "$minutes";
    };
  }
}
