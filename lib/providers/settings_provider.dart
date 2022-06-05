import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../views/components/vibration.dart';

class StartTimeOption {
  final bool enabled;
  final Duration startTime;

  StartTimeOption(this.startTime, {this.enabled = true});
}

class RegattaTimerSettings {
  // Long Press settings
  final bool longPressToResetPreStart;
  final bool longPressToResetPostStart;
  final bool longPressToSync;

  // Wake Lock settings
  final bool timerSelectionWakelockEnabled;
  final bool preStartWakelockEnabled;
  final bool postStartWakelockEnabled;

  // Timer Options
  final List<StartTimeOption> selectedStartTimeOptions;
  final List<VibrationEvent> selectedVibrations;

  RegattaTimerSettings({
    required this.longPressToResetPreStart,
    required this.longPressToResetPostStart,
    required this.longPressToSync,
    required this.timerSelectionWakelockEnabled,
    required this.preStartWakelockEnabled,
    required this.postStartWakelockEnabled,
    required this.selectedStartTimeOptions,
    required this.selectedVibrations,
  });
}

class SettingsNotifier extends StateNotifier<RegattaTimerSettings> {
  SettingsNotifier(RegattaTimerSettings defaultSettings)
      : super(defaultSettings);
}

final settingsProvider =
    StateNotifierProvider<SettingsNotifier, RegattaTimerSettings>((ref) {
  return SettingsNotifier(
    RegattaTimerSettings(
      // Long Press settings
      // These options are not quite intuitive for first time users
      longPressToResetPostStart: false,
      longPressToResetPreStart: false,
      longPressToSync: false,

      // Wake Lock settings
      // This option is not quite intuitive for first time users
      timerSelectionWakelockEnabled: false,
      preStartWakelockEnabled: true,
      postStartWakelockEnabled: false,

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
