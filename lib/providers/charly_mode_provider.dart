import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:regatta_timer/providers/timer_providers.dart';

part 'charly_mode_provider.g.dart';

@CopyWith()
class CharlyModeState {
  final bool enabled;
  final Duration nextStartDuration;

  CharlyModeState({required this.enabled, required this.nextStartDuration});
}

class CharlyModeNotifier extends StateNotifier<CharlyModeState> {
  CharlyModeNotifier(super.state);

  set charlyModeEnabled(bool newValue) {
    state = state.copyWith(enabled: newValue);
  }

  restart() {
    // state = state.copyWith(nextStartDuration: Duration(minutes: state.nextStartDuration))
  }

  static CharlyModeState nextState(CharlyModeState charlyModeState) {
    if (charlyModeState.nextStartDuration.inMinutes <= 1) {
      return charlyModeState.copyWith(
        enabled: false,
        // nextStartDuration: const Duration(seconds: -1),
      );
    }

    return charlyModeState.copyWith(
      nextStartDuration: Duration(
        minutes: (charlyModeState.nextStartDuration.inMinutes / 2).ceil(),
      ),
    );
  }
}

final charlyModeProvider = StateNotifierProvider<CharlyModeNotifier, CharlyModeState>((ref) {
  return CharlyModeNotifier(
    CharlyModeState(
      enabled: false,
      nextStartDuration: ref.watch(startOffsetProvider),
    ),
  );
});
