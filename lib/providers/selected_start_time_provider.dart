import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:regatta_timer/providers/settings_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum _SharedPrefsKeys { selectedTimer }

class SelectedStartTimeNotifier extends StateNotifier<int> {
  final Ref ref;
  late final Future<SharedPreferences> prefs = SharedPreferences.getInstance();

  SelectedStartTimeNotifier(int selectedTimeIndex, {required this.ref}) : super(selectedTimeIndex) {
    _initFromSharedPreferences();
  }

  void _initFromSharedPreferences() async {
    final preferences = await prefs;

    state = preferences.getInt(_SharedPrefsKeys.selectedTimer.name) ?? state;
  }

  void _setIntToSharedPreferences(_SharedPrefsKeys key, int value) async {
    (await prefs).setInt(key.name, value);
  }

  Duration get selectedDuration {
    return ref.read(settingsProvider).selectedStartTimeOptions[state].startTime;
  }

  void setSelectedTimeIndex(int newValue) {
    state = newValue;

    _setIntToSharedPreferences(_SharedPrefsKeys.selectedTimer, newValue);
  }
}

final selectedStartTimeProvider = StateNotifierProvider<SelectedStartTimeNotifier, int>((ref) {
  return SelectedStartTimeNotifier(4, ref: ref);
});

Stream<Duration> newTimerStreamFromDuration(Duration startTimer) {
  return Stream<Duration>.periodic(const Duration(seconds: 1), (int t) => startTimer + Duration(seconds: t + 1)).asBroadcastStream();
}
