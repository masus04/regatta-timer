import 'package:flutter/material.dart';
import 'package:regatta_timer/constants.dart';
import 'package:regatta_timer/post_start/post_start_view.dart';
import 'package:regatta_timer/pre_start/pre_start_view.dart';
import 'package:regatta_timer/set_time/set_time_view.dart';
import 'package:regatta_timer/settings/settings_view.dart';

void main() {
  runApp(const RegattaTimer());
}

class RegattaTimer extends StatelessWidget {
  const RegattaTimer({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
        colorScheme: const ColorScheme.light(
          primary: Colors.indigo,
          secondary: Colors.green,
          tertiary: Colors.red,
        ),
        textTheme: Theme.of(context).textTheme.apply(
          bodyColor: Colors.white,
          displayColor: Colors.white,
        ),
      ),
      initialRoute: Routes.setTimeRoute,
      routes: {
        Routes.setTimeRoute: (context) => const SetTimeView(),
        Routes.preStartRoute: (context) => const PreStartView(),
        Routes.postStartRoute: (context) => const PostStartView(),
        // Routes.setTimeRoute: (context) => const SettingsView(),
      },
    );
  }
}
