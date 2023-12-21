import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/cupertino.dart';
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
  final AudioPlayer audioPlayer = AudioPlayer()
    ..setPlayerMode(PlayerMode.lowLatency)
    ..setReleaseMode(ReleaseMode.release);

  Future<void> ticker({required Duration timeToStart, List<SoundEvent> soundEvents = SoundEvent.values}) async {
    final selectIndex = SoundEvent.values.indexWhere((soundEvent) => soundEvent.activationTimeStep == timeToStart);

    // await audioPlayer.play(AssetSource(SoundEvent.values[4].assetName));

    if (selectIndex >= 0) {
      await audioPlayer.play(AssetSource(SoundEvent.values[selectIndex].assetName), volume: 1);
      debugPrint("Playing sound: ${SoundEvent.values[selectIndex].assetName} with index: $selectIndex");
    }
  }
}
