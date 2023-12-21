import 'package:flutter_test/flutter_test.dart';
import 'package:regatta_timer/providers/timer_extensions.dart';

void main() {
  group("Test halfRoundDown", () {
    test("Zest zero", () => expect(CharlyMode.halfRoundDown(duration: Duration.zero), equals(Duration.zero)));
    test("Zest 1 min", () => expect(CharlyMode.halfRoundDown(duration: const Duration(minutes: 1)), equals(Duration.zero)));
    test("Zest 2 mins", () => expect(CharlyMode.halfRoundDown(duration: const Duration(minutes: 2)), equals(const Duration(minutes: 1))));
    test("Zest 3 mins", () => expect(CharlyMode.halfRoundDown(duration: const Duration(minutes: 3)), equals(const Duration(minutes: 1))));
    test("Zest 4 mins", () => expect(CharlyMode.halfRoundDown(duration: const Duration(minutes: 4)), equals(const Duration(minutes: 2))));
    test("Zest 5 mins", () => expect(CharlyMode.halfRoundDown(duration: const Duration(minutes: 5)), equals(const Duration(minutes: 2))));
    test("Zest 20 mins", () => expect(CharlyMode.halfRoundDown(duration: const Duration(minutes: 20)), equals(const Duration(minutes: 10))));
    test("Zest 50 mins", () => expect(CharlyMode.halfRoundDown(duration: const Duration(minutes: 50)), equals(const Duration(minutes: 25))));
    test("Zest 55 mins", () => expect(CharlyMode.halfRoundDown(duration: const Duration(minutes: 55)), equals(const Duration(minutes: 27))));
  });

  group("Test Charly Mode", () {
    test("Negative timeToStart", () {
      const tts = Duration(seconds: -30);

      expect(CharlyMode.ticker(timeToStart: tts, offset: const Duration(minutes: 1)), equals(tts));
    });

    test("StartTime = 1:00", () {
      expect(CharlyMode.ticker(timeToStart: Duration.zero, offset: Duration.zero), equals(Duration.zero));
      expect(CharlyMode.ticker(timeToStart: const Duration(seconds: 20), offset: Duration.zero), equals(const Duration(seconds: 20)));
    });

    test("StartTime = 2:00", () {
      expect(CharlyMode.ticker(timeToStart: Duration.zero, offset: const Duration(minutes: 1)), equals(const Duration(minutes: -1)));
      expect(CharlyMode.ticker(timeToStart: const Duration(minutes: 1), offset: const Duration(minutes: 1)), equals(Duration.zero));
      expect(CharlyMode.ticker(timeToStart: const Duration(minutes: 2), offset: const Duration(minutes: 1)), equals(const Duration(minutes: 1)));
      expect(CharlyMode.ticker(timeToStart: const Duration(minutes: 3), offset: const Duration(minutes: 1)), equals(const Duration(minutes: 2)));

      expect(CharlyMode.ticker(timeToStart: const Duration(seconds: 20), offset: const Duration(minutes: 1)), equals(const Duration(seconds: -40)));
      expect(CharlyMode.ticker(timeToStart: const Duration(minutes: 1, seconds: 20), offset: const Duration(minutes: 1)), equals(const Duration(seconds: 20)));
    });

    test("StartTime = 3:00", () {
      final offset = CharlyMode.halfRoundDown(duration: const Duration(minutes: 3));

      expect(CharlyMode.ticker(timeToStart: Duration.zero, offset: offset), equals(const Duration(minutes: -1)));
      expect(CharlyMode.ticker(timeToStart: const Duration(minutes: 1), offset: offset), equals(Duration.zero));
      expect(CharlyMode.ticker(timeToStart: const Duration(minutes: 2), offset: offset), equals(const Duration(minutes: 1)));
      expect(CharlyMode.ticker(timeToStart: const Duration(minutes: 3), offset: offset), equals(const Duration(minutes: 2)));

      expect(CharlyMode.ticker(timeToStart: const Duration(seconds: 20), offset: offset), equals(const Duration(seconds: -40)));
      expect(CharlyMode.ticker(timeToStart: const Duration(minutes: 1, seconds: 20), offset: offset), equals(const Duration(seconds: 20)));
      expect(CharlyMode.ticker(timeToStart: const Duration(minutes: 2, seconds: 20), offset: offset), equals(const Duration(minutes: 1, seconds: 20)));
    });

    test("StartTime = 4:00", () {
      expect(CharlyMode.ticker(timeToStart: Duration.zero, offset: const Duration(minutes: 2)), equals(const Duration(minutes: -2)));
      expect(CharlyMode.ticker(timeToStart: const Duration(minutes: 2), offset: const Duration(minutes: 2)), equals(const Duration(minutes: -1)));
      expect(CharlyMode.ticker(timeToStart: const Duration(minutes: 3), offset: const Duration(minutes: 2)), equals(const Duration(minutes: 0)));
      expect(CharlyMode.ticker(timeToStart: const Duration(minutes: 4), offset: const Duration(minutes: 2)), equals(const Duration(minutes: 1)));
    });

    test("StartTime = 5:00", () {
      expect(CharlyMode.ticker(timeToStart: Duration.zero, offset: const Duration(minutes: 2)), equals(const Duration(minutes: -2)));
      expect(CharlyMode.ticker(timeToStart: const Duration(minutes: 2), offset: const Duration(minutes: 2)), equals(const Duration(minutes: -1)));
      expect(CharlyMode.ticker(timeToStart: const Duration(minutes: 3), offset: const Duration(minutes: 2)), equals(const Duration(minutes: 0)));
      expect(CharlyMode.ticker(timeToStart: const Duration(minutes: 4), offset: const Duration(minutes: 2)), equals(const Duration(minutes: 1)));
    });
  });
}
