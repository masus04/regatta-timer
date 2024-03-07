import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:regatta_timer/regatta_timer.dart';

import 'controllers/notification_controller.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  NotificationController.init();

  runApp(
    const ProviderScope(
      child: RegattaTimer(),
    ),
  );
}
