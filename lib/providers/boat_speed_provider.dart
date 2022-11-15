import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:regatta_timer/providers/settings_provider.dart';

class BoatSpeed {
  final Position position;

  BoatSpeed({required this.position});

  double get metersPerSecond => position.speed;

  double get knots => position.speed * 1.9438;

  double get kmh => position.speed * 60 * 60 / 1000;
}

final positionProvider = StreamProvider<BoatSpeed>((ref) async* {
  if (ref.watch(settingsProvider).displayBoatSpeed) {
    await for (final position in Geolocator.getPositionStream(locationSettings: const LocationSettings(distanceFilter: 1)).asBroadcastStream()) {
      debugPrint("New boat speed: ${position.speed} m/s");
      yield BoatSpeed(position: position); // BoatSpeed(metersPerSecond: position.speed);
    }
  } else {
    // yield null;
  }
});
