// import 'package:copy_with_extension/copy_with_extension.dart';
// import 'package:hooks_riverpod/hooks_riverpod.dart';
//
// part 'charly_mode_provider.g.dart';
//
// final charlyModeEnabledProvider = StateProvider<bool>((ref) {
//   return false;
// });
//
// @CopyWith()
// class CharlyModeState {
//   final bool enabled;
//   final Duration nextStartDuration;
//
//   CharlyModeState({required this.enabled, required this.nextStartDuration});
//
//   CharlyModeState nextState() {
//     if (nextStartDuration.inMinutes <= 1) {
//       return copyWith(
//         enabled: false,
//         // nextStartDuration: const Duration(seconds: -1),
//       );
//     }
//
//     return copyWith(
//       nextStartDuration: Duration(
//         minutes: (nextStartDuration.inMinutes / 2).ceil(),
//       ),
//     );
//   }
// }
