import 'package:geolocator/geolocator.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:regatta_timer/providers/settings_provider.dart';

class BoatPosition {
  final Position position;

  BoatPosition({required this.position});

  double get metersPerSecond => position.speed;

  double get knots => position.speed * 1.9438;

  double get kmh => position.speed * 60 * 60 / 1000;
}

final positionProvider = StreamProvider<BoatPosition>((ref) async* {
  if (ref.watch(settingsProvider).displayBoatSpeed) {
    await for (final position in Geolocator.getPositionStream(locationSettings: const LocationSettings(accuracy: LocationAccuracy.best)).asBroadcastStream()) {
      // debugPrint("New boat speed: ${position.speed} m/s");
      yield BoatPosition(position: position);
    }
  } else {
    // yield null;
  }
});

Future<void> checkLocationPermissions() async {
  // TODO: Show permission dialog
  var permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
  }
}
