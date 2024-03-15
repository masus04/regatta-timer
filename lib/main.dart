import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:regatta_timer/controllers/fallback_notification_controller.dart';
import 'package:regatta_timer/providers/boat_speed_provider.dart';
import 'package:regatta_timer/regatta_timer.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await checkLocationPermissions();
  // await OngoingNotificationController.init(); // Ongoing Notifications for wearOS platform
  await FallbackNotificationController.init(); // Fallback for android mobile platforms

  runApp(
    const ProviderScope(
      child: RegattaTimer(),
    ),
  );
}
