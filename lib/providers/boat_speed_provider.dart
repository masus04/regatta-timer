import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class BoatSpeed {
  final double metersPerSecond;

  BoatSpeed({required this.metersPerSecond});

  double get knots {
    return metersPerSecond * 1.9438;
  }

  double get kmh {
    return metersPerSecond * 60 * 60 / 1000;
  }
}

class BoatSpeedNotifier extends StateNotifier<AsyncValue<BoatSpeed>> {
  final Ref ref;
  late StreamSubscription subscription;

  BoatSpeedNotifier({required this.ref}) : super(const AsyncValue.loading()) {
    try {
      init();
    } catch (err, stacktrace) {
      state = AsyncValue.error(err, stacktrace);
    }
  }

  void init() async {
    debugPrint("Initializing boatSpeedProvider");
    if (![LocationPermission.whileInUse, LocationPermission.always].contains(await Geolocator.checkPermission())) {
      if (![LocationPermission.whileInUse, LocationPermission.always].contains(await Geolocator.requestPermission())) {
        throw Exception("Location permissions denied by user");
      }
    }

    debugPrint("Boat speed: ${(await Geolocator.getCurrentPosition()).speed}");

    subscription = Geolocator.getPositionStream(locationSettings: const LocationSettings(distanceFilter: 1)).listen(
      (updatedPosition) {
        debugPrint("New boat speed: ${updatedPosition.speed} m/s");

        state = AsyncValue.data(
          BoatSpeed(metersPerSecond: updatedPosition.speed),
        );
      },
    );
  }

  void stop() async {
    await subscription.cancel();
  }
}

final boatSpeedProvider = StateNotifierProvider<BoatSpeedNotifier, AsyncValue<BoatSpeed>>((ref) {
  return BoatSpeedNotifier(ref: ref);
});
