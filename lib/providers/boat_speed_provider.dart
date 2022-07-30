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
  var permission = Geolocator.checkPermission();
  late StreamSubscription subscription;

  BoatSpeedNotifier({required this.ref}) : super(const AsyncValue.loading()) {
    try {
      init();
    } catch (err) {
      state = AsyncValue.error(err);
    }
  }

  void init() async {
    debugPrint("Initializing boatSpeedProvider");
    if (await permission == LocationPermission.denied) {
      permission = Geolocator.requestPermission();
    }

    if (await permission == LocationPermission.denied) {
      throw Exception("Location permissions denied");
    }

    subscription = Geolocator.getPositionStream(locationSettings: const LocationSettings(distanceFilter: 1)).listen(
      (updatedPosition) {
        debugPrint("New boat speed: ${updatedPosition.speed} m/s");

        state = AsyncValue.data(
          BoatSpeed(metersPerSecond: updatedPosition.speed),
        );
      },
    );
  }

  get isEnabled async {
    // TODO: Check settings for boatSpeedEnabled flag
    return [LocationPermission.whileInUse, LocationPermission.always].contains(await permission);
  }

  void stop() async {
    await subscription.cancel();
  }
}

final boatSpeedProvider = StateNotifierProvider<BoatSpeedNotifier, AsyncValue<BoatSpeed>>((ref) {
  return BoatSpeedNotifier(ref: ref);
});
