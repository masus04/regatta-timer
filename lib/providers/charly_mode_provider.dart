import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

part 'charly_mode_provider.g.dart';

@CopyWith()
class CharlyModeState {
  final bool enabled;

  CharlyModeState({required this.enabled});
}

class CharlyModeNotifier extends StateNotifier<CharlyModeState> {
  CharlyModeNotifier() : super(CharlyModeState(enabled: false));

  set charlyModeEnabled(bool newValue) {
    state = state.copyWith(enabled: newValue);
  }
}

final charlyModeProvider = StateNotifierProvider<CharlyModeNotifier, CharlyModeState>((ref) => CharlyModeNotifier());
