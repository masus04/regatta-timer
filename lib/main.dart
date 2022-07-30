import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:regatta_timer/providers/app_view_provider.dart';
import 'package:regatta_timer/views/set_time/set_time_view.dart';
import 'package:regatta_timer/views/settings/settings_view.dart';
import 'package:regatta_timer/views/timer/timer_view.dart';

void main() {
  runApp(const RegattaTimer());
}

class RegattaTimer extends StatelessWidget {
  const RegattaTimer({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.indigo,
          colorScheme: const ColorScheme.light(
            primary: Colors.indigo,
            secondary: Colors.green,
            tertiary: Colors.red,
          ),
          textTheme: const TextTheme(
            button: TextStyle(
                color: Colors.white, fontSize: 25, fontWeight: FontWeight.bold),
            bodyText1: TextStyle(color: Colors.indigo),
            bodyText2: TextStyle(color: Colors.black),
          ),
        ),
        initialRoute: AppViewNotifier.setTimeView.route,
        routes: {
          AppViewNotifier.setTimeView.route: (context) =>
              const SafeArea(child: SetTimeView()),
          AppViewNotifier.preStartView.route: (context) =>
              const SafeArea(child: TimerView()),
          AppViewNotifier.settingsView.route: (context) =>
              const SafeArea(child: SettingsView()),
        },
      ),
    );
  }
}
