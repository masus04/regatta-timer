import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:regatta_timer/types/vibration_events.dart';

part 'settings_types.g.dart';

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

  // App Lock settings
  final bool lockPreventPopBack;

  // Boat Speed settings
  final bool displayBoatSpeed;
  final BoatSpeedUnit boatSpeedUnit;

  // Start Procedure Flags
  final bool startProcedureFlagsEnabled;

  // Charly Mode
  final bool charlyModeToggleEnabled;

  final List<VibrationEvent> selectedVibrations;
  final bool soundEventsEnabled;

  RegattaTimerSettings({
    required this.longPressToStart,
    required this.longPressToResetPreStart,
    required this.longPressToResetPostStart,
    required this.longPressToSync,
    required this.timerSelectionWakelockEnabled,
    required this.preStartWakelockEnabled,
    required this.postStartWakelockEnabled,
    required this.displayBoatSpeed,
    required this.boatSpeedUnit,
    required this.startProcedureFlagsEnabled,
    required this.charlyModeToggleEnabled,
    required this.selectedVibrations,
    required this.soundEventsEnabled,
    required this.lockPreventPopBack,
  });
}
