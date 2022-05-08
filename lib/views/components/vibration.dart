import 'dart:developer';

import 'package:vibration/vibration.dart';

/// Represents a vibration event which is triggered when the start timer is equal to the [activationTimeStep]
/// [numVibrations] describes the number of vibration bursts the pattern consists of
/// [vibrationDuration] describes how many milliseconds the vibration burst last
class VibrationEvent {
  final int numVibrations;
  final int vibrationDuration;
  final int breakDuration;

  final Duration activationTimeStep;

  VibrationEvent(
      {required this.numVibrations,
      this.vibrationDuration = 500,
      required this.activationTimeStep,
      this.breakDuration = 100});

  List<int> get pattern {
    return List.generate(2 * numVibrations,
        (index) => index.isOdd ? breakDuration : vibrationDuration);
  }

  void execute() {
    log("Executing pattern: $activationTimeStep - ${numVibrations}x ${vibrationDuration}ms");
    Vibration.vibrate(pattern: pattern);
  }
}
