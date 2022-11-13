import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:regatta_timer/providers/selected_start_time_provider.dart';
import 'package:regatta_timer/providers/timer_provider.dart';

part 'charly_mode_provider.g.dart';

@CopyWith()
class CharlyModeState {
  final bool enabled;
  final Duration? nextStartDuration;

  CharlyModeState({required this.enabled, this.nextStartDuration});
}

class CharlyModeNotifier extends StateNotifier<CharlyModeState> {
  Ref ref;

  CharlyModeNotifier({required this.ref}) : super(CharlyModeState(enabled: false, nextStartDuration: Duration.zero)) {
    ref.listen<Duration?>(
      timerProvider,
      (previous, next) {
        if (state.nextStartDuration == null) {
          state = state.copyWith(lastDuration: ref.watch(selectedStartTimeProvider.notifier).selectedDuration);
        } else {
          state = state.copyWith(lastDuration: Duration(minutes: (state.nextStartDuration!.inMinutes / 2).round()));
        }

        if (next == const Duration(seconds: 1)) {
          if (state.nextStartDuration! >= const Duration(minutes: 1)) {
            ref.read(timerProvider.notifier).reset(duration: state.nextStartDuration);
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
  return CharlyModeNotifier(ref: ref);
});
