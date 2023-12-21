import 'package:regatta_timer/types/flag.dart';

enum StartProcedureEvent {
  ocr5min(timeStep: Duration(minutes: 5), flags: [Flag.classFlag]),
  orc4min(timeStep: Duration(minutes: 4), flags: [Flag.classFlag, Flag.normalStart]),
  orc1min(timeStep: Duration(minutes: 1), flags: [Flag.classFlag]),
  orcStart(timeStep: Duration(minutes: 0), flags: []);

  const StartProcedureEvent({required this.timeStep, required this.flags});

  final Duration timeStep;
  final List<Flag> flags;
}

enum StartProcedure {
  orc(events: [StartProcedureEvent.ocr5min, StartProcedureEvent.orc4min, StartProcedureEvent.orc1min, StartProcedureEvent.orcStart]);

  const StartProcedure({required this.events});

  final List<StartProcedureEvent> events;
}
