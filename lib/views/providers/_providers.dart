import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'dart:io' show Platform;

export 'page_provider.dart';
export 'timer_provider.dart';

// Provides the selected Start Time
final selectedStartTimeProvider = StateProvider<int>((ref) {
  return 3;
});

// Provides whether the device is a watch (os == gwear)
final isWatchProvider = Provider<bool>((ref) {
  try {
    return Platform.operatingSystemVersion.contains('gwear');
  } on Exception {
    return false;
  }
});
