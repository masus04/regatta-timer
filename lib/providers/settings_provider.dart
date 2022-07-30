import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:regatta_timer/views/components/vibration.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StartTimeOption {
  bool enabled;
  final Duration startTime;

  StartTimeOption(this.startTime, {this.enabled = true});

  copyWith({Duration? startTime, bool? enabled}) {
    return StartTimeOption(startTime ?? this.startTime, enabled: enabled ?? this.enabled);
  }
}

enum BoatSpeedUnit { mps, knots, kmh }

BoatSpeedUnit? boatSpeedUnitFromString(String? name) {
  if (name == BoatSpeedUnit.mps.name) return BoatSpeedUnit.mps;

  if (name == BoatSpeedUnit.knots.name) return BoatSpeedUnit.knots;

  if (name == BoatSpeedUnit.kmh.name) return BoatSpeedUnit.kmh;

  return null;
}

class RegattaTimerSettings {
  // Long Press settings
  final bool longPressToStart;
  final bool longPressToResetPreStart;
  final bool longPressToResetPostStart;
  final bool longPressToSync;

  // Wake Lock settings
  final bool timerSelectionWakelockEnabled;
  final bool preStartWakelockEnabled;
  final bool postStartWakelockEnabled;

  // Boat Speed settings
  final bool showPostStartBoatSpeed;
  final BoatSpeedUnit boatSpeedUnit;

  // Timer Options
  final List<StartTimeOption> selectedStartTimeOptions;
  final List<VibrationEvent> selectedVibrations;

  RegattaTimerSettings({
    required this.longPressToStart,
    required this.longPressToResetPreStart,
    required this.longPressToResetPostStart,
    required this.longPressToSync,
    required this.timerSelectionWakelockEnabled,
    required this.preStartWakelockEnabled,
    required this.postStartWakelockEnabled,
    required this.showPostStartBoatSpeed,
    required this.boatSpeedUnit,
    required this.selectedStartTimeOptions,
    required this.selectedVibrations,
  });

  copyWith(
      {bool? longPressToStart,
      bool? longPressToResetPreStart,
      bool? longPressToResetPostStart,
      bool? longPressToSync,
      bool? timerSelectionWakelockEnabled,
      bool? preStartWakelockEnabled,
      bool? postStartWakelockEnabled,
      bool? showPostStartBoatSpeed,
      BoatSpeedUnit? boatSpeedUnit,
      List<StartTimeOption>? selectedStartTimeOptions,
      List<VibrationEvent>? selectedVibrations}) {
    return RegattaTimerSettings(
      longPressToStart: longPressToStart ?? this.longPressToStart,
      longPressToResetPreStart: longPressToResetPreStart ?? this.longPressToResetPreStart,
      longPressToResetPostStart: longPressToResetPostStart ?? this.longPressToResetPostStart,
      longPressToSync: longPressToSync ?? this.longPressToSync,
      timerSelectionWakelockEnabled: timerSelectionWakelockEnabled ?? this.timerSelectionWakelockEnabled,
      preStartWakelockEnabled: preStartWakelockEnabled ?? this.preStartWakelockEnabled,
      postStartWakelockEnabled: postStartWakelockEnabled ?? this.postStartWakelockEnabled,
      showPostStartBoatSpeed: showPostStartBoatSpeed ?? this.showPostStartBoatSpeed,
      boatSpeedUnit: boatSpeedUnit ?? this.boatSpeedUnit,
      selectedStartTimeOptions: selectedStartTimeOptions ?? this.selectedStartTimeOptions,
      selectedVibrations: selectedVibrations ?? this.selectedVibrations,
    );
  }
}

enum _SharedPreferenceKeys {
  // LongPress
  longPressToStart,
  longPressToResetPreStart,
  longPressToResetPostStart,
  longPressToSync,

  // WakeLock
  timerSelectionWakelockEnabled,
  preStartWakelockEnabled,
  postStartWakelockEnabled,

  // BoatSpeed
  showPostStartBoatSpeed,
  boatSpeedUnit,

  // Lists
  selectedStartTimeOptions,
  selectedVibrations,
}

class SettingsNotifier extends StateNotifier<RegattaTimerSettings> {
  late final Future<SharedPreferences> prefs = SharedPreferences.getInstance();

  SettingsNotifier(RegattaTimerSettings defaultSettings) : super(defaultSettings) {
    _initFromSharedPreferences();
  }

  _initFromSharedPreferences() async {
    final preferences = await prefs;

    state = state.copyWith(
      longPressToStart: preferences.getBool(_SharedPreferenceKeys.longPressToStart.name),
      longPressToResetPreStart: preferences.getBool(_SharedPreferenceKeys.longPressToResetPreStart.name),
      longPressToResetPostStart: preferences.getBool(_SharedPreferenceKeys.longPressToResetPostStart.name),
      longPressToSync: preferences.getBool(_SharedPreferenceKeys.longPressToSync.name),
      timerSelectionWakelockEnabled: preferences.getBool(_SharedPreferenceKeys.timerSelectionWakelockEnabled.name),
      showPostStartBoatSpeed: preferences.getBool(_SharedPreferenceKeys.showPostStartBoatSpeed.name),
      boatSpeedUnit: boatSpeedUnitFromString(preferences.getString(_SharedPreferenceKeys.boatSpeedUnit.name)),
      preStartWakelockEnabled: preferences.getBool(_SharedPreferenceKeys.preStartWakelockEnabled.name),
      postStartWakelockEnabled: preferences.getBool(_SharedPreferenceKeys.postStartWakelockEnabled.name),
    );
  }

  _setBoolToSharedPrefs(_SharedPreferenceKeys key, bool value) async {
    (await prefs).setBool(key.name, value);
  }

  _setStringToSharedPrefs(_SharedPreferenceKeys key, String value) async {
    (await prefs).setString(key.name, value);
  }

  setLongPressToStart(bool newValue) {
    state = state.copyWith(
      longPressToStart: newValue,
    );

    _setBoolToSharedPrefs(_SharedPreferenceKeys.longPressToStart, newValue);
  }

  setLongPressToResetPreStart(bool newValue) {
    state = state.copyWith(
      longPressToResetPreStart: newValue,
    );

    _setBoolToSharedPrefs(_SharedPreferenceKeys.longPressToResetPreStart, newValue);
  }

  setLongPressToResetPostStart(bool newValue) {
    state = state.copyWith(
      longPressToResetPostStart: newValue,
    );

    _setBoolToSharedPrefs(_SharedPreferenceKeys.longPressToResetPostStart, newValue);
  }

  toggleLongPressToSync(bool newValue) {
    state = state.copyWith(
      longPressToSync: newValue,
    );

    _setBoolToSharedPrefs(_SharedPreferenceKeys.longPressToSync, newValue);
  }

  setTimerSelectionWakelockEnabled(bool newValue) {
    state = state.copyWith(
      timerSelectionWakelockEnabled: newValue,
    );

    _setBoolToSharedPrefs(_SharedPreferenceKeys.timerSelectionWakelockEnabled, newValue);
  }

  setPreStartWakelockEnabled(bool newValue) {
    state = state.copyWith(
      preStartWakelockEnabled: newValue,
    );

    _setBoolToSharedPrefs(_SharedPreferenceKeys.preStartWakelockEnabled, newValue);
  }

  setPostStartWakelockEnabled(bool newValue) {
    state = state.copyWith(
      postStartWakelockEnabled: newValue,
    );

    _setBoolToSharedPrefs(_SharedPreferenceKeys.postStartWakelockEnabled, newValue);
  }

  setShowPostStartBoatSpeed(bool newValue) {
    state = state.copyWith(
      showPostStartBoatSpeed: newValue,
    );

    _setBoolToSharedPrefs(_SharedPreferenceKeys.showPostStartBoatSpeed, newValue);
  }

  setBoatSpeedUnit(BoatSpeedUnit newValue) {
    state = state.copyWith(
      boatSpeedUnit: newValue,
    );

    _setStringToSharedPrefs(_SharedPreferenceKeys.boatSpeedUnit, newValue.name);
  }

  setStartTimeOptions(StartTimeOption startTime, bool newValue) {
    // TODO: Fix issue where dependent widgets are not notified of the update. Probably requires deep copy

    final startTimeOptions = state.selectedStartTimeOptions;
    final index = startTimeOptions.indexOf(startTime);

    startTimeOptions[index].enabled = newValue;

    state = state.copyWith(selectedStartTimeOptions: startTimeOptions);

    // TODO: store to shared preferences
  }

  setVibrationPatterns() {
    throw Exception("Not yet implemented");
    // TODO: Implement this similar to setStartTime
  }
}

final settingsProvider = StateNotifierProvider<SettingsNotifier, RegattaTimerSettings>((ref) {
  return SettingsNotifier(
    RegattaTimerSettings(
      // Long Press settings
      // These options are not quite intuitive for first time users
      longPressToStart: false,
      longPressToResetPostStart: false,
      longPressToResetPreStart: false,
      longPressToSync: false,

      // Wake Lock settings
      // This option is not quite intuitive for first time users
      timerSelectionWakelockEnabled: false,
      preStartWakelockEnabled: true,
      postStartWakelockEnabled: false,

      // Boat Speed Settings
      showPostStartBoatSpeed: true,
      boatSpeedUnit: BoatSpeedUnit.knots,

      // Timer settings
      selectedStartTimeOptions: [
        StartTimeOption(const Duration(minutes: 1)),
        StartTimeOption(const Duration(minutes: 2)),
        StartTimeOption(const Duration(minutes: 3)),
        StartTimeOption(const Duration(minutes: 4)),
        StartTimeOption(const Duration(minutes: 5)),
        StartTimeOption(const Duration(minutes: 6)),
        StartTimeOption(const Duration(minutes: 10)),
        StartTimeOption(const Duration(minutes: 15)),
        StartTimeOption(const Duration(minutes: 20)),
        StartTimeOption(const Duration(minutes: 30)),
        StartTimeOption(const Duration(minutes: 45)),
        StartTimeOption(const Duration(minutes: 60)),
      ],
      selectedVibrations: [
        VibrationEvent(
          activationTimeStep: const Duration(minutes: -60),
          numVibrations: 6,
          vibrationDuration: 1000,
        ),
        VibrationEvent(
          activationTimeStep: const Duration(minutes: -45),
          numVibrations: 4,
          vibrationDuration: 1000,
        ),
        VibrationEvent(
          activationTimeStep: const Duration(minutes: -30),
          numVibrations: 3,
          vibrationDuration: 1000,
        ),
        VibrationEvent(
          activationTimeStep: const Duration(minutes: -20),
          numVibrations: 2,
          vibrationDuration: 2000,
        ),
        VibrationEvent(
          activationTimeStep: const Duration(minutes: -15),
          numVibrations: 1,
          vibrationDuration: 1000,
        ),
        VibrationEvent(
          activationTimeStep: const Duration(minutes: -10),
          numVibrations: 1,
          vibrationDuration: 1000,
        ),
        VibrationEvent(
          activationTimeStep: const Duration(minutes: -6),
          numVibrations: 6,
          vibrationDuration: 500,
        ),
        VibrationEvent(
          activationTimeStep: const Duration(minutes: -5),
          numVibrations: 5,
          vibrationDuration: 500,
        ),
        VibrationEvent(
          activationTimeStep: const Duration(minutes: -4),
          numVibrations: 4,
          vibrationDuration: 500,
        ),
        VibrationEvent(
          activationTimeStep: const Duration(minutes: -3),
          numVibrations: 3,
          vibrationDuration: 500,
        ),
        VibrationEvent(
          activationTimeStep: const Duration(minutes: -2),
          numVibrations: 2,
          vibrationDuration: 500,
        ),
        VibrationEvent(
          activationTimeStep: const Duration(minutes: -1),
          numVibrations: 1,
          vibrationDuration: 500,
        ),
        VibrationEvent(
          activationTimeStep: const Duration(seconds: -30),
          numVibrations: 3,
          vibrationDuration: 200,
        ),
        VibrationEvent(
          activationTimeStep: const Duration(seconds: -20),
          numVibrations: 2,
          vibrationDuration: 200,
        ),
        VibrationEvent(
          activationTimeStep: const Duration(seconds: -10),
          numVibrations: 1,
          vibrationDuration: 200,
        ),
        VibrationEvent(
          activationTimeStep: const Duration(seconds: -3),
          numVibrations: 1,
          vibrationDuration: 100,
        ),
        VibrationEvent(
          activationTimeStep: const Duration(seconds: -2),
          numVibrations: 1,
          vibrationDuration: 100,
        ),
        VibrationEvent(
          activationTimeStep: const Duration(seconds: -1),
          numVibrations: 1,
          vibrationDuration: 100,
        ),
        VibrationEvent(
          activationTimeStep: Duration.zero,
          numVibrations: 1,
          vibrationDuration: 3000,
        ),
      ],
    ),
  );
});
