import 'package:audioplayers/audioplayers.dart';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:regatta_timer/controllers/app_view_controller.dart';
import 'package:regatta_timer/controllers/notification_controller.dart';
import 'package:regatta_timer/providers/settings_provider.dart';
import 'package:regatta_timer/providers/timer_providers.dart';
import 'package:regatta_timer/types/sound_events.dart';

part 'timer_extensions.g.dart';

class VibrationsExtension extends Notifier<void> {
  @override
  void build() {}

  /// Watch timerController, updates & creates side effects whenever a relevant tick is recognized
  void tick(Duration timeToStart) {
    final selectedVibrations = ref.read(settingsProvider).selectedVibrations;

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

final vibrationsExtension = NotifierProvider<VibrationsExtension, void>(VibrationsExtension.new);

class SoundExtension extends Notifier<void> {
  @override
  void build() {}

  Future<void> tick(Duration timeToStart) async {
    final selectIndex = SoundEvent.values.indexWhere((soundEvent) => soundEvent.activationTimeStep == timeToStart);

    if (selectIndex >= 0) {
      await playAudio(audioFileName: SoundEvent.values[selectIndex].assetName);
    }
  }

  Future<void> playAudio({required String audioFileName}) async {
    debugPrint("Playing sound: $audioFileName");

    final player = AudioPlayer(playerId: audioFileName);

    await player.play(AssetSource(audioFileName));
    await player.onPlayerComplete.first;

    await player.dispose();
  }
}

final soundExtension = NotifierProvider<SoundExtension, void>(SoundExtension.new);

class NotificationExtension extends Notifier<void> {
  @override
  void build() {}

  Future<void> tick(Duration timeToStart) async {
    await ref.read(notificationController.notifier).updateOngoingActivity(timeToStart: timeToStart);
  }
}

final notificationExtension = NotifierProvider<NotificationExtension, void>(NotificationExtension.new);

/// Provides whether charlyMode is enabled and implements a ticker method for any desired side effects of charly mode
@CopyWith()
class CharlyModeState {
  final bool enabled;
  final Duration lastOffset;

  CharlyModeState({required this.enabled, required this.lastOffset});
}

class CharlyModeExtension extends Notifier<CharlyModeState> {
  @override
  CharlyModeState build() {
    return CharlyModeState(
      enabled: false,
      lastOffset: Duration.zero,
    );
  }

  set charlyModeEnabled(bool enabled) => state = state.copyWith(enabled: enabled);

  void reset() => state = state.copyWith(lastOffset: ref.read(startOffsetProvider));

  Future<void> tick(Duration timeToStart) async {
    // start is reached and last offset was not already at 1 min -> restart
    if (timeToStart.inSeconds == 0 && state.lastOffset.inMinutes > 1) {
      // Stop Timer
      await ref.read(timerController.notifier).stop();

      // Set new timer
      final nextOffset = Duration(minutes: (state.lastOffset.inMinutes / 2).round());
      ref.read(timerController.notifier).setTimer(nextOffset);
      state = state.copyWith(lastOffset: nextOffset);

      // Start new timer
      await ref.read(timerController.notifier).start();
    }
  }
}

final charlyModeExtension = NotifierProvider<CharlyModeExtension, CharlyModeState>(CharlyModeExtension.new);

/// Calls AppViewController.enterPostStartState after starting.
class PostStartExtension extends Notifier<void> {
  @override
  void build() {}

  Future<void> tick(Duration timeToStart) async {
    if (timeToStart.inSeconds == -1) {
      ref.read(appViewController.notifier).enterPostStartState();
    }
  }
}

final postStartExtension = NotifierProvider<PostStartExtension, void>(PostStartExtension.new);
