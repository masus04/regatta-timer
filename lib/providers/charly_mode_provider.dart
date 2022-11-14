import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:regatta_timer/providers/timer_provider.dart';

part 'charly_mode_provider.g.dart';

@CopyWith()
class CharlyModeState {
  final bool enabled;
  final Duration nextStartDuration;

  CharlyModeState({this.enabled = false, required this.nextStartDuration});
}

class CharlyModeNotifier extends StateNotifier<CharlyModeState> {
  Ref ref;

  CharlyModeNotifier({required Duration nextStartDuration, required this.ref}) : super(CharlyModeState(nextStartDuration: nextStartDuration)) {
    ref.listen<TimerNotifierState?>(
      timerProvider,
      (previous, next) {
        // Listen to next tick after zero, because otherwise this might interfere with vibrations etc.
        if (next!.nextStartDuration == const Duration(seconds: 1)) {
          state = state.copyWith(nextStartDuration: Duration(seconds: (state.nextStartDuration.inMilliseconds / 2000).round()));
          if (state.nextStartDuration > Duration.zero) {
            ref.read(timerProvider.notifier).reset(nextStartDuration: state.nextStartDuration);
          }
        }
      },
    );
  }

  set charlyModeEnabled(bool newValue) {
    state = state.copyWith(enabled: newValue);
  }
}

final charlyModeProvider = StateNotifierProvider<CharlyModeNotifier, CharlyModeState>((ref) {
  return CharlyModeNotifier(
    nextStartDuration: ref.watch(timerProvider)!.nextStartDuration,
    ref: ref,
  );
});
