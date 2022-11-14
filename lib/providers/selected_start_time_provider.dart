// import 'package:copy_with_extension/copy_with_extension.dart';
// import 'package:hooks_riverpod/hooks_riverpod.dart';
// import 'package:regatta_timer/providers/settings_provider.dart';
// import 'package:shared_preferences/shared_preferences.dart';
//
// part 'selected_start_time_provider.g.dart';
//
// enum _SharedPrefsKeys { selectedTimer }
//
// @CopyWith()
// class SelectStartTimerState {
//   final Ref ref;
//
//   final int index;
//
//   SelectStartTimerState({required this.index, required this.ref});
//
//   Duration get selectedDuration {
//     return ref.read(settingsProvider).selectedStartTimeOptions[index].startTime;
//   }
// }
//
// class SelectedStartTimeNotifier extends StateNotifier<SelectStartTimerState> {
//   final Ref ref;
//   late final Future<SharedPreferences> prefs = SharedPreferences.getInstance();
//
//   SelectedStartTimeNotifier(int selectedTimeIndex, {required this.ref}) : super(SelectStartTimerState(index: selectedTimeIndex, ref: ref)) {
//     _initFromSharedPreferences();
//   }
//
//   void _initFromSharedPreferences() async {
//     final preferences = await prefs;
//
//     state = SelectStartTimerState(
//       index: preferences.getInt(_SharedPrefsKeys.selectedTimer.name) ?? state.index,
//       ref: ref,
//     );
//   }
//
//   void _setIntToSharedPreferences(_SharedPrefsKeys key, int value) async {
//     (await prefs).setInt(key.name, value);
//   }
//
//   // Duration get selectedDuration {
//   //   return ref.read(settingsProvider).selectedStartTimeOptions[state.index].startTime;
//   // }
//
//   void setSelectedTimeIndex(int newValue) {
//     state = state.copyWith(index: newValue);
//
//     _setIntToSharedPreferences(_SharedPrefsKeys.selectedTimer, newValue);
//   }
// }
//
// final selectedStartTimeProvider = StateNotifierProvider<SelectedStartTimeNotifier, SelectStartTimerState>((ref) {
//   return SelectedStartTimeNotifier(4, ref: ref);
// });
//
// Stream<Duration> newTimerStreamFromDuration(Duration startTimer) {
//   return Stream<Duration>.periodic(const Duration(seconds: 1), (int t) => startTimer + Duration(seconds: t + 1)).asBroadcastStream();
// }
