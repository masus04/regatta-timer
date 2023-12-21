import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:regatta_timer/types/settings_types.dart';
import 'package:regatta_timer/types/vibration_events.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsNotifier extends StateNotifier<RegattaTimerSettings> {
  late final Future<SharedPreferences> prefs = SharedPreferences.getInstance();

  SettingsNotifier(super.defaultSettings) {
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
        displayBoatSpeed: preferences.getBool(_SharedPreferenceKeys.displayBoatSpeed.name),
        boatSpeedUnit: boatSpeedUnitFromString(preferences.getString(_SharedPreferenceKeys.boatSpeedUnit.name)),
        startProcedureFlagsEnabled: preferences.getBool(_SharedPreferenceKeys.startProcedureFlagsEnabled.name),
        charlyModeToggleEnabled: preferences.getBool(_SharedPreferenceKeys.charlyModeToggleEnabled.name),
        soundEventsEnabled: preferences.getBool(_SharedPreferenceKeys.soundEventsEnabled.name),
        preStartWakelockEnabled: preferences.getBool(_SharedPreferenceKeys.preStartWakelockEnabled.name),
        postStartWakelockEnabled: preferences.getBool(_SharedPreferenceKeys.postStartWakelockEnabled.name),
        lockPreventPopBack: preferences.getBool(_SharedPreferenceKeys.lockPreventPopBack.name));
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

  setLockPreventPopBack(bool newValue) {
    state = state.copyWith(
      lockPreventPopBack: newValue,
    );

    _setBoolToSharedPrefs(_SharedPreferenceKeys.lockPreventPopBack, newValue);
  }

  setDisplayBoatSpeed(bool newValue) {
    state = state.copyWith(
      displayBoatSpeed: newValue,
    );

    _setBoolToSharedPrefs(_SharedPreferenceKeys.displayBoatSpeed, newValue);
  }

  setBoatSpeedUnit(BoatSpeedUnit newValue) {
    state = state.copyWith(
      boatSpeedUnit: newValue,
    );

    _setStringToSharedPrefs(_SharedPreferenceKeys.boatSpeedUnit, newValue.name);
  }

  setStartProcedureFlags(bool newValue) {
    state = state.copyWith(startProcedureFlagsEnabled: newValue);
    _setBoolToSharedPrefs(_SharedPreferenceKeys.startProcedureFlagsEnabled, newValue);
  }

  setCharlyModeToggleEnabled(bool newValue) {
    state = state.copyWith(charlyModeToggleEnabled: newValue);
    _setBoolToSharedPrefs(_SharedPreferenceKeys.charlyModeToggleEnabled, newValue);
  }

  setSoundEventsEnabled(bool newValue) {
    state = state.copyWith(soundEventsEnabled: newValue);
    _setBoolToSharedPrefs(_SharedPreferenceKeys.soundEventsEnabled, newValue);
  }

  setVibrationPatterns() {
    throw Exception("Not yet implemented");
    // TODO: Implement this similar to setStartTime
  }

  static BoatSpeedUnit? boatSpeedUnitFromString(String? name) {
    if (name == BoatSpeedUnit.mps.name) return BoatSpeedUnit.mps;

    if (name == BoatSpeedUnit.knots.name) return BoatSpeedUnit.knots;

    if (name == BoatSpeedUnit.kmh.name) return BoatSpeedUnit.kmh;

    return null;
  }
}

final settingsProvider = StateNotifierProvider<SettingsNotifier, RegattaTimerSettings>((ref) {
  // Set default settings here:
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
      timerSelectionWakelockEnabled: true,
      preStartWakelockEnabled: true,
      postStartWakelockEnabled: false,

      // App Lock settings
      lockPreventPopBack: false,

      // Boat Speed Settings
      displayBoatSpeed: true,
      // Enable for Mobile
      boatSpeedUnit: BoatSpeedUnit.knots,
      // TODO: Support selecting different units

      // Start Procedure Flags
      startProcedureFlagsEnabled: true,

      // Charly Mode
      charlyModeToggleEnabled: false,

      // Sound Events
      soundEventsEnabled: true,

      // Timer settings
      selectedVibrations: [
        VibrationEvent(
          activationTimeStep: const Duration(minutes: -60),
          numVibrations: 1,
          vibrationDuration: 2000,
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
          vibrationDuration: 1000,
        ),
        VibrationEvent(
          activationTimeStep: const Duration(minutes: -5),
          numVibrations: 5,
          vibrationDuration: 1000,
        ),
        VibrationEvent(
          activationTimeStep: const Duration(minutes: -4),
          numVibrations: 4,
          vibrationDuration: 1000,
        ),
        VibrationEvent(
          activationTimeStep: const Duration(minutes: -3),
          numVibrations: 3,
          vibrationDuration: 1000,
        ),
        VibrationEvent(
          activationTimeStep: const Duration(minutes: -2),
          numVibrations: 2,
          vibrationDuration: 1000,
        ),
        VibrationEvent(
          activationTimeStep: const Duration(minutes: -1),
          numVibrations: 1,
          vibrationDuration: 1000,
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
          activationTimeStep: const Duration(seconds: -5),
          numVibrations: 1,
          vibrationDuration: 100,
        ),
        VibrationEvent(
          activationTimeStep: const Duration(seconds: -4),
          numVibrations: 1,
          vibrationDuration: 100,
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

  // App Lock
  lockPreventPopBack,

  // BoatSpeed
  displayBoatSpeed,
  boatSpeedUnit,

  // Start Procedure Flags
  startProcedureFlagsEnabled,

  // Charly Mode
  charlyModeToggleEnabled,

  // Sound Events
  soundEventsEnabled,

  // Lists
  // selectedStartTimeOptions,
  // selectedVibrations,
}
