import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:regatta_timer/providers/timer_providers.dart';

part 'charly_mode_provider.g.dart';

final charlyModeEnabledProvider = StateProvider<bool>((ref) {
  return false;
});

@CopyWith()
class CharlyModeState {
  final bool enabled;
  final Duration nextStartDuration;

  CharlyModeState({required this.enabled, required this.nextStartDuration});

  CharlyModeState nextState() {
    if (nextStartDuration.inMinutes <= 1) {
      return copyWith(
        enabled: false,
        // nextStartDuration: const Duration(seconds: -1),
      );
    }

    return copyWith(
      nextStartDuration: Duration(
        minutes: (nextStartDuration.inMinutes / 2).ceil(),
      ),
    );
  }
}

class CharlyModeNotifier extends StateNotifier<CharlyModeState> {
  CharlyModeNotifier(super.state);

  // set charlyModeEnabled(bool newValue) {
  //   state = state.copyWith(enabled: newValue);
  // }

  restart() {
    // state = state.copyWith(nextStartDuration: Duration(minutes: state.nextStartDuration))
  }
}

final charlyModeProvider = StateNotifierProvider<CharlyModeNotifier, CharlyModeState>((ref) {
  return CharlyModeNotifier(
    CharlyModeState(
      enabled: ref.watch(charlyModeEnabledProvider),
      nextStartDuration: ref.watch(startOffsetProvider),
    ),
  );
});
