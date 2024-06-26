import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:regatta_timer/controllers/app_view_controller.dart';
import 'package:regatta_timer/controllers/ui_utils.dart';
import 'package:regatta_timer/providers/settings_provider.dart';
import 'package:regatta_timer/views/set_time/view_set_time.dart';
import 'package:regatta_timer/views/settings/view_settings.dart';
import 'package:regatta_timer/views/settings/view_vibration_pattern_settings.dart';
import 'package:regatta_timer/views/timer/end_of_race/view_end_of_race.dart';
import 'package:regatta_timer/views/timer/view_timer.dart';

class RegattaTimer extends HookConsumerWidget {
  static final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  const RegattaTimer({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final uiState = UiUtils(context);

    final background = UiUtils(context).deviceType == DeviceType.watch ? Colors.black : Colors.white;
    final onBackground = UiUtils(context).deviceType == DeviceType.watch ? Colors.white : Colors.blueGrey.shade900;

    return PopScope(
      // Prevent app from being closed if AppLock is active and this feature was enabled in settings
      canPop: ref.watch(settingsProvider).lockPreventPopBack,
      child: MaterialApp(
        title: 'Regatta Timer',
        navigatorKey: navigatorKey,
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.black,
            primary: const Color(0xFF0000A0),
            onPrimary: Colors.white,
            secondary: const Color(0xFF00A000),
            onSecondary: Colors.white,
            tertiary: const Color(0xFFB00000),
            onTertiary: Colors.white,
            surface: background,
            onSurface: onBackground,
          ),
          textTheme: GoogleFonts.ubuntuTextTheme(
            TextTheme(
              labelLarge: TextStyle(color: onBackground, fontSize: uiState.displayFontSize, fontWeight: FontWeight.bold),
              labelMedium: TextStyle(color: onBackground, fontSize: uiState.menuFontSize),
              labelSmall: TextStyle(color: onBackground, fontSize: uiState.menuFontSize),
              displayLarge: TextStyle(color: onBackground, fontSize: uiState.displayFontSize, fontWeight: FontWeight.bold),
              displayMedium: TextStyle(color: onBackground, fontSize: uiState.menuFontSize, fontWeight: FontWeight.bold),
              displaySmall: TextStyle(color: onBackground, fontSize: uiState.menuFontSize, fontWeight: FontWeight.bold),
            ),
          ),
        ),
        initialRoute: AppView.setTimeView.route,
        routes: {
          AppView.setTimeView.route: (context) => const SetTimeView(),
          AppView.preStartView.route: (context) => const TimerView(),
          AppView.endOfRaceView.route: (context) => const EndOfRaceView(),
          AppView.settingsView.route: (context) => const SettingsView(),
          AppView.vibrationSettingsView.route: (context) => const VibrationSettingsView(),
        },
      ),
    );
  }
}
