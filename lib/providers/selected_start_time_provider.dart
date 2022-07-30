import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:regatta_timer/providers/settings_provider.dart';

class SelectedStartTimeNotifier extends StateNotifier<int> {
  final Ref ref;

  SelectedStartTimeNotifier(int selectedTimeIndex, {required this.ref})
      : super(selectedTimeIndex);

  Duration get selectedDuration {
    return ref.read(settingsProvider).selectedStartTimeOptions[state].startTime;
  }

  void setSelectedTimeIndex(int newValue) {
    state = newValue;
  }
}

final selectedStartTimeProvider =
    StateNotifierProvider<SelectedStartTimeNotifier, int>((ref) {
  return SelectedStartTimeNotifier(4, ref: ref);
});

Stream<Duration> newTimerStreamFromDuration(Duration startTimer) {
  return Stream<Duration>.periodic(const Duration(seconds: 1),
      (int t) => startTimer + Duration(seconds: t + 1)).asBroadcastStream();
}
