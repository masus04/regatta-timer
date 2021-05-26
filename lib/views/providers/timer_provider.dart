// Provides a Stream of Strings, representing the countdown from the selected Start Time
import 'dart:async';
import 'package:rxdart/rxdart.dart';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:wakelock/wakelock.dart';

import '_providers.dart';

final startTimerProvider = StateNotifierProvider<SyncedTimerNotifier, Duration>(
  (ref) {
    // Set selected Start Time as initial state
    final selectedStartTime = ref.read(selectedStartTimeProvider).state;
    return SyncedTimerNotifier(-selectedStartTime);
  },
);

class SyncedTimerNotifier extends StateNotifier<Duration> {
  Duration syncTarget;
  late Stream<Duration> _stream;
  final List<StreamSubscription<Duration>> subscriptions = [];

  SyncedTimerNotifier(int startTimer)
      : syncTarget = Duration(minutes: startTimer),
        super(Duration(minutes: startTimer)) {
    // Setup all required streams
    set(syncTarget);
  }

  // Sync Timer to nearest minute
  sync() {
    set(syncTarget);
  }

  // Set Timer to given Duration
  set(Duration timer) {
    // Create new Stream
    state = timer;
    _stream = _newTimerStreamFromDuration(timer);

    // Cancel all subscriptions
    for (var subscription in subscriptions) {
      subscription.cancel();
    }

    // Subscribe to new Stream
    final subscription = _stream.listen((tick) {
      state = tick;
    });
    subscriptions.add(subscription);

    // Create a new stream for syncTarget updates
    final resetTimerSubscription = _stream
        .where((tick) => tick.inSeconds.remainder(60).abs() == 30)
        .listen((syncTick) {
      syncTarget = Duration(minutes: syncTick.inMinutes);

      // Disable Wakelock after start
      if (syncTick == Duration.zero) {
        Wakelock.disable();
      }
    });

    subscriptions.add(resetTimerSubscription);
  }

  clear() {
    for (var sub in subscriptions) {
      sub.cancel();
    }

    _stream.drain();
  }
}

// -------------------- Helper Functions -------------------- //

Stream<Duration> _newTimerStreamFromDuration(Duration startTimer) {
  return Stream<Duration>.periodic(const Duration(seconds: 1),
      (int t) => startTimer + Duration(seconds: t + 1)).asBroadcastStream();
}
