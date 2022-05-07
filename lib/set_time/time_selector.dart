import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:regatta_timer/constants.dart';
import 'package:regatta_timer/providers/providers.dart';
import 'package:numberpicker/numberpicker.dart';

class TimeSelector extends HookConsumerWidget {
  const TimeSelector({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      height: TimerOptions.fontSize * TimerOptions.numItems,
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          NumberPicker(
            minValue: 0,
            maxValue: startTimeOptions.length - 1,
            value: 3,
            onChanged: onChange(ref),
            textStyle: Theme.of(context).textTheme.bodyText2?.copyWith(
                fontSize: TimerOptions.fontSize * 0.5,
                fontWeight: FontWeight.normal),
            selectedTextStyle: Theme.of(context).textTheme.bodyText1?.copyWith(
                  fontWeight: FontWeight.bold,
                  fontSize: TimerOptions.fontSize,
                ),
            textMapper: (number) => '${startTimeOptions[int.parse(number)]}',
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
      // ref.watch(provider).state = newValue
    };
  }
}
