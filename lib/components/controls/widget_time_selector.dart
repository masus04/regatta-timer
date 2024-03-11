import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:regatta_timer/controllers/ui_utils.dart';
import 'package:regatta_timer/providers/timer_providers.dart';
import 'package:wearable_rotary/wearable_rotary.dart';

class TimeSelector extends HookConsumerWidget {
  final int numOptions;

  const TimeSelector({super.key, this.numOptions = 3});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    const rotaryUpdateSeconds = 5;
    final fontSize = UiUtils(context).displayFontSize;

    useEffect(() {
      final rotarySubscription = rotaryEvents.listen((RotaryEvent event) {
        final timer = ref.read(startOffsetProvider);

        if (event.direction == RotaryDirection.clockwise) {
          // debugPrint("Rotary scroll detected clockwise with magnitude ${event.magnitude}");
          final seconds = ((timer.inSeconds % 60) + rotaryUpdateSeconds) % 60;

          ref.read(timerController.notifier).setTimer(
            Duration(
              minutes: seconds == 0 ? timer.inMinutes + 1 : timer.inMinutes,
              seconds: seconds,
            ),
          );
        } else if (event.direction == RotaryDirection.counterClockwise) {
          // debugPrint("Rotary scroll detected counter-clockwise with magnitude ${event.magnitude}");
          final seconds = ((timer.inSeconds % 60) - rotaryUpdateSeconds) % 60;

          ref.read(timerController.notifier).setTimer(
            Duration(
              minutes: seconds == 60 - rotaryUpdateSeconds ? timer.inMinutes - 1 : timer.inMinutes,
              seconds: seconds,
            ),
          );
        }
      });

      return () {
        rotarySubscription.cancel();
      };
    }, []);

    final timer = ref.watch(startOffsetProvider);
    final minutes = timer.inMinutes;
    final seconds = timer.inSeconds % 60;

    return FittedBox(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          NumberPicker(
            minValue: 0,
            maxValue: 999,
            value: timer.inMinutes,
            onChanged: (newMinutes) {
              if (newMinutes != minutes) {
                ref.read(timerController.notifier).setTimer(Duration(minutes: newMinutes, seconds: seconds));
              }
            },
            textStyle: Theme
                .of(context)
                .textTheme
                .displaySmall
                ?.copyWith(color: Theme
                .of(context)
                .colorScheme
                .onBackground
                .withOpacity(.75)),
            selectedTextStyle: Theme
                .of(context)
                .textTheme
                .displayLarge,
            itemCount: 3,
            itemHeight: fontSize*1.2,
            itemWidth: fontSize * 2,
          ),
          Text(
            ":",
            style: Theme
                .of(context)
                .textTheme
                .displayLarge,
          ),
          NumberPicker(
            minValue: 0,
            maxValue: 59,
            infiniteLoop: true,
            value: seconds,
            onChanged: (newSeconds) {
              if (newSeconds != seconds) {
                ref.read(timerController.notifier).setTimer(Duration(minutes: minutes, seconds: newSeconds));
              }
            },
            textStyle: Theme
                .of(context)
                .textTheme
                .displaySmall
                ?.copyWith(color: Theme
                .of(context)
                .colorScheme
                .onBackground
                .withOpacity(.75)),
            selectedTextStyle: Theme
                .of(context)
                .textTheme
                .displayLarge,
            textMapper: (numberText) => numberText.length == 1 ? "0$numberText" : numberText,
            itemCount: 3,
            itemHeight: fontSize*1.2,
            itemWidth: fontSize * 2,
          ),
        ],
      ),
    );
  }
}
