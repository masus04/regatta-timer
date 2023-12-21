// import 'package:flutter/material.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:hooks_riverpod/hooks_riverpod.dart';
// import 'package:regatta_timer/regatta_timer.dart';
//
// const screenSizes = {
//   "Watch": [
//     Size(300, 300),
//     Size(360, 360),
//     Size(460, 460),
//     Size(520, 520),
//   ],
//   "Phone": [
//     Size(1080, 2400),
//     Size(2400, 1080),
//     Size(1440, 2560),
//     Size(2560, 1440),
//   ],
//   "Tablet": [
//     Size(1280, 900),
//     Size(900, 1280),
//     Size(2560, 1800),
//     Size(1800, 2560),
//   ],
// };
//
// void main() {
//   group("SetTimer Smoke Test", () {
//     for (final deviceSizes in screenSizes.entries) {
//       final deviceName = deviceSizes.key;
//       final screenSizes = deviceSizes.value;
//
//       group("$deviceName View Tests", () {
//         for (final size in screenSizes) {
//           testWidgets("Test SetTimer View $deviceName:($size)", (WidgetTester tester) async {
//             // Init test settings
//             tester.binding.window.physicalSizeTestValue = size;
//             addTearDown(tester.binding.window.clearPhysicalSizeTestValue);
//             // Integration Test
//
//             await tester.pumpWidget(
//               const ProviderScope(
//                 child: RegattaTimer(),
//               ),
//             );
//
//             // Start Tests
//             expect(find.byKey(const Key("SetTimeView")), findsOneWidget);
//           });
//         }
//       });
//     }
//   });
// }
