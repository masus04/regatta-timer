import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:regatta_timer/types/vibration.dart';

part 'settings_types.g.dart';

class StartTimeOption {
  bool enabled;
  final Duration startTime;

  StartTimeOption(this.startTime, {this.enabled = true});

  copyWith({Duration? startTime, bool? enabled}) {
    return StartTimeOption(startTime ?? this.startTime, enabled: enabled ?? this.enabled);
  }
}

enum BoatSpeedUnit { mps, knots, kmh }

@CopyWith()
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

  // Charly Mode
  final bool charlyModeToggleEnabled;

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
    required this.charlyModeToggleEnabled,
    required this.selectedStartTimeOptions,
    required this.selectedVibrations,
  });
}
