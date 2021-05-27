import 'package:flutter/cupertino.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'dart:io' show Platform;

export 'page_provider.dart';
export 'timer_provider.dart';

// Provides the selected Start Time
final startTimeOptionIndexProvider = StateProvider<int>((ref) => 2);

// Provides whether the app screen is locked and all buttons should be disabled
final appLockProvider = StateProvider<bool>((ref) => false);

// Provides whether the device is a watch (os == gwear)
final isWatchProvider = Provider<bool>((ref) {
  try {
    return Platform.operatingSystemVersion.contains('gwear');
  } on Exception {
    return false;
  }
});
