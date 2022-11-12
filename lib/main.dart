import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:regatta_timer/providers/app_view_provider.dart';
import 'package:regatta_timer/views/set_time/set_time_view.dart';
import 'package:regatta_timer/views/settings/settings_view.dart';
import 'package:regatta_timer/views/settings/start_timer_settings_view.dart';
import 'package:regatta_timer/views/settings/vibration_pattern_settings_view.dart';
import 'package:regatta_timer/views/timer/timer_view.dart';

void main() {

  WidgetsFlutterBinding.ensureInitialized();

  runApp(
    const ProviderScope(
      child: RegattaTimer(),
    ),
  );
}

class RegattaTimer extends StatelessWidget {
  const RegattaTimer({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Regatta Timer',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.indigo,
        colorScheme: const ColorScheme.light(
          primary: Colors.indigo,
          secondary: Colors.green,
          tertiary: Colors.red,
        ),
        textTheme: const TextTheme(
          button: TextStyle(color: Colors.white, fontSize: 25, fontWeight: FontWeight.bold),
          bodyText1: TextStyle(color: Colors.indigo),
          bodyText2: TextStyle(color: Colors.black),
        ),
      ),
      // builder: (context, child) => SafeArea(child: child!),
      initialRoute: AppViewNotifier.setTimeView.route,
      routes: {
        AppViewNotifier.setTimeView.route: (context) => const SetTimeView(),
        AppViewNotifier.preStartView.route: (context) => const TimerView(),
        AppViewNotifier.settingsView.route: (context) => const SettingsView(),
        AppViewNotifier.startTimeSettingsView.route: (context) => const StartTimerSettingsView(),
        AppViewNotifier.vibrationAlertSettingsView.route: (context) => const VibrationPatternSettingsView(),
      },
    );
  }
}
