void main() {
  /// In order to run these tests, use the following command from the apps base directory:
  /// flutter drive --driver=test_driver/integration_test.dart --target=integration_test/views_test.dart
  /// or use the alias ftest --target=integration_test/views_test.dart

  // final binding = IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  // testWidgets("Test SetTimer View", (WidgetTester tester) async {
  //   // Init test settings
  //   tester.binding.window.physicalSizeTestValue = const Size(250, 250);
  //   addTearDown(tester.binding.window.clearPhysicalSizeTestValue);
  //
  //   // Init App
  //   WidgetsFlutterBinding.ensureInitialized();
  //
  //   // Integration Test
  //   app.main();
  //
  //   await binding.convertFlutterSurfaceToImage();
  //   await tester.pumpAndSettle();
  //
  //   await tester.pumpAndSettle();
  //   await binding.takeScreenshot("Initial state");
  //
  //   // Start Tests
  //   expect(find.byKey(const Key("SetTimeView")), findsOneWidget);
  // });
}
