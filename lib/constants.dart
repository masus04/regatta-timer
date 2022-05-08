import 'package:regatta_timer/views/components/vibration.dart';

class Routes {
  static String setTimeRoute = "/setTime";
  static String timerRoute = "/timer";
  static String settingsRoute = "/settings";
}

class TimerOptions {
  static const numItems = 3;
  static const fontSize = 25.0;
}

// TODO: Move the following to settings & use these as defaults

const startTimeOptions = [1, 2, 3, 5, 10, 15, 20, 30, 45, 60];

final vibrationPatterns = [
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
];
