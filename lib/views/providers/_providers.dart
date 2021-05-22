import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'dart:io' show Platform;

export 'page_provider.dart';

final selectedTimerProvider = StateProvider<int>((ref) {
  return 3;
});

final isWatchProvider = Provider<bool>((ref) {
  try {
    return Platform.operatingSystemVersion.contains('gwear');
  } on Exception {
    return false;
  }
});
