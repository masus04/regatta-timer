import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:regatta_timer/providers/app_view_provider.dart';
import 'package:regatta_timer/providers/layout_provider.dart';
import 'package:regatta_timer/views/set_time/set_time_view.dart';
import 'package:regatta_timer/views/settings/settings_view.dart';
import 'package:regatta_timer/views/settings/start_timer_settings_view.dart';
import 'package:regatta_timer/views/settings/vibration_pattern_settings_view.dart';
import 'package:regatta_timer/views/timer/timer_view.dart';

class RegattaTimer extends HookConsumerWidget {
  const RegattaTimer({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final uiState = ref.watch(uiProvider);

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
        textTheme: GoogleFonts.ubuntuTextTheme(
          TextTheme(
            labelLarge: TextStyle(color: Colors.white, fontSize: uiState.displayFontSize, fontWeight: FontWeight.bold),
            labelMedium: TextStyle(color: Colors.white, fontSize: uiState.menuFonsSize),
            labelSmall: TextStyle(color: Colors.white, fontSize: uiState.menuFonsSize),
            displayLarge: TextStyle(color: Colors.indigo, fontSize: uiState.displayFontSize, fontWeight: FontWeight.bold),
            displayMedium: TextStyle(color: Colors.indigo, fontSize: uiState.menuFonsSize, fontWeight: FontWeight.bold),
            displaySmall: TextStyle(color: Colors.black, fontSize: uiState.menuFonsSize, fontWeight: FontWeight.bold),
          ),
        ),
      ),
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
