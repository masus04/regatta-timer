import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:regatta_timer/providers/boat_speed_provider.dart';
import 'package:regatta_timer/regatta_timer.dart';

import 'controllers/notification_controller.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await checkLocationPermissions();
  await NotificationController.requestPermissions();
  await NotificationController.init();

  runApp(
    const ProviderScope(
      child: RegattaTimer(),
    ),
  );
}
