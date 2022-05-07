import 'package:flutter/material.dart';

import 'post_start/post_start_view.dart';
import 'pre_start/pre_start_view.dart';
import 'set_time/set_time_view.dart';
import 'settings/settings_view.dart';


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
      ),
      routes: {
        "/": (context) => const SetTimeView(),
        "/pre-start": (context) => const PreStartView(),
        "/post-start": (context) => const PostStartView(),
        "/settings": (context) => const SettingsView(),
      },
    );
  }
}



