import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:regatta_timer/providers/timer_providers.dart';
import 'package:regatta_timer/types/flag.dart';
import 'package:regatta_timer/types/start_procedure.dart';

class StartProcedureState {
  StartProcedureEvent currentEvent;

  StartProcedureState({this.currentEvent = StartProcedureEvent.orcStart});

  List<Flag> get displayedFlags => currentEvent.flags;
}

class StartProcedureNotifier extends StateNotifier<StartProcedureState> {
  final Duration time;
  final StartProcedure startProcedure;

  StartProcedureEvent currentEvent = StartProcedureEvent.orcStart;

  StartProcedureNotifier({required this.time, required this.startProcedure}) : super(StartProcedureState()) {
    StartProcedureEvent? candidateEvent;

    // Display last triggered event
    for (final event in startProcedure.events) {
      if (event.timeStep.inMinutes >= (time.abs() + const Duration(seconds: 59)).inMinutes) {
        candidateEvent = event;
      }
    }

    state = StartProcedureState(currentEvent: candidateEvent ?? StartProcedureEvent.orcStart);
  }
}

final startProcedureProvider = StateNotifierProvider<StartProcedureNotifier, StartProcedureState>((ref) {
  return StartProcedureNotifier(
    time: ref.watch(timeToStartProvider).value!,
    startProcedure: StartProcedure.orc, // TODO: Make configurable in settings
  );
});
