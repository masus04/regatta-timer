import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:regatta_timer/constants.dart';

class SelectedStartTimeNotifier extends StateNotifier<int> {
  SelectedStartTimeNotifier(int selectedTimeIndex) : super(selectedTimeIndex);

  int get selectedMinutes {
    return startTimeOptions[state];
  }

  void setSelectedTimeIndex(int newValue) {
    state = newValue;
  }
}

final selectedStartTimeProvider = StateNotifierProvider<SelectedStartTimeNotifier, int>((ref) {
  return SelectedStartTimeNotifier(3);
});
