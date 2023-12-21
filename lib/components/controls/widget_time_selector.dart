import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:regatta_timer/controllers/ui_utils.dart';
import 'package:regatta_timer/providers/timer_providers.dart';

class TimeSelector extends HookConsumerWidget {
  final int numOptions;

  const TimeSelector({super.key, this.numOptions = 3});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final minutes = useState(5);
    final seconds = useState(0);

    final fontSize = UiUtils(context).displayFontSize;

    return FittedBox(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          NumberPicker(
            minValue: 0,
            maxValue: 999,
            value: minutes.value,
            onChanged: (newMinutes) {
              minutes.value = newMinutes;
              TimerController.setTimer(ref, Duration(minutes: minutes.value, seconds: seconds.value));
            },
            textStyle: Theme.of(context).textTheme.displaySmall?.copyWith(color: Theme.of(context).colorScheme.onBackground.withOpacity(.75)),
            selectedTextStyle: Theme.of(context).textTheme.displayLarge,
            itemCount: 3,
            itemHeight: fontSize,
            itemWidth: fontSize * 2,
          ),
          Text(
            ":",
            style: Theme.of(context).textTheme.displayLarge,
          ),
          NumberPicker(
            minValue: 0,
            maxValue: 59,
            infiniteLoop: true,
            value: seconds.value,
            onChanged: (newSeconds) {
              seconds.value = newSeconds;
              TimerController.setTimer(ref, Duration(minutes: minutes.value, seconds: seconds.value));
            },
            textStyle: Theme.of(context).textTheme.displaySmall?.copyWith(color: Theme.of(context).colorScheme.onBackground.withOpacity(.75)),
            selectedTextStyle: Theme.of(context).textTheme.displayLarge,
            textMapper: (numberText) => numberText.length == 1 ? "0$numberText" : numberText,
            itemCount: 3,
            itemHeight: fontSize,
            itemWidth: fontSize * 2,
          ),
        ],
      ),
    );
  }
}
