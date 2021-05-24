// Provides a Stream of Strings, representing the countdown from the selected Start Time
import 'dart:async';
import 'package:rxdart/rxdart.dart';

import 'package:hooks_riverpod/hooks_riverpod.dart';

import '_providers.dart';

final syncedTimerNotifier =
    StateNotifierProvider.autoDispose<SyncedTimerNotifier, Duration>(
  (ref) {
    // Set selected Start Time as initial state
    final selectedStartTime = ref.read(selectedStartTimeProvider).state;
    return SyncedTimerNotifier(selectedStartTime);
  },
);

class SyncedTimerNotifier extends StateNotifier<Duration> {
  late Stream<Duration> _stream;
  late Duration syncTarget;
  final List<StreamSubscription<Duration>> subscriptions = [];

  SyncedTimerNotifier(startTimer) : super(Duration(minutes: startTimer)) {
    syncTarget = Duration(minutes: startTimer);

    // Setup all required streams
    set(syncTarget);
  }

  // Sync Timer to nearest minute
  sync() {
    set(syncTarget);
  }

  // Set Timer to given Duration
  set(Duration timer) {
    state = timer;

    // Cancel all subscriptions
    for (var subscription in subscriptions) {
      subscription.cancel();
    }

    // set new Stream
    _stream = _newTimerStreamFromDuration(timer);

    // subscribe to new Stream
    final subscription = _stream.listen((tick) {
      state = tick;
    });
    subscriptions.add(subscription);

    // Create, listen and store one time Stream in order to update syncTarget
    var resetTimerSubscription = Rx.timer(
            syncTarget - const Duration(minutes: 1),
            const Duration(seconds: 30))
        .listen((newMinute) {
      syncTarget = newMinute;
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
  Duration _timerCallback(int t) {
    final currentTimer = startTimer - Duration(seconds: t + 1);

    // Min Value = 0:00
    return currentTimer > Duration.zero ? currentTimer : Duration.zero;
  }

  return Stream<Duration>.periodic(const Duration(seconds: 1), _timerCallback);
}
