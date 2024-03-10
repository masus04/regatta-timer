import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:regatta_timer/controllers/notification_controller.dart';
import 'package:regatta_timer/types/sound_events.dart';
import 'package:regatta_timer/types/vibration_events.dart';

class CharlyMode {
  static Duration ticker({required Duration timeToStart, required Duration offset}) {
    // Escape if tts is in pre start state or charlyOffset is recursively 0
    if (timeToStart.inSeconds <= 0 || offset == Duration.zero) {
      return timeToStart;
    }

    return ticker(timeToStart: timeToStart - offset - const Duration(seconds: 1), offset: halfRoundDown(duration: offset));
  }

  static Duration halfRoundDown({required Duration duration}) {
    if (duration.inMinutes.isEven) {
      return Duration(minutes: (duration.inMinutes / 2).round());
    } else {
      return Duration(minutes: ((duration.inMinutes - 1) / 2).round());
    }
  }
}

class VibrationsExtension {
  static void ticker({required Duration timeToStart, required List<VibrationEvent> selectedVibrations}) {
    if (selectedVibrations.isEmpty) {
      return;
    }

    final selectedIndex = selectedVibrations.indexWhere(
      (vibration) => vibration.activationTimeStep.inSeconds == timeToStart.inSeconds,
    );

    if (selectedIndex >= 0) {
      selectedVibrations[selectedIndex].execute();
    }
  }
}

class SoundExtension {
  final AudioPlayer audioPlayer = AudioPlayer();

  Future<void> ticker({required Duration timeToStart, List<SoundEvent> soundEvents = SoundEvent.values}) async {
    final selectIndex = SoundEvent.values.indexWhere((soundEvent) => soundEvent.activationTimeStep == timeToStart);

    if (selectIndex >= 0) {
      debugPrint("Playing audio: ${SoundEvent.values[selectIndex].assetName}");
      await audioPlayer.setUrl("asset:assets/${SoundEvent.values[selectIndex].assetName}");
      await audioPlayer.play();
      debugPrint("Playing sound: ${SoundEvent.values[selectIndex].assetName} with index: $selectIndex");
    }
  }
}

class NotificationExtension {
  static Future<void> ticker({required Duration timeToStart}) async {
    NotificationController.showTimerNotification(timeToStart: timeToStart);
  }
}
