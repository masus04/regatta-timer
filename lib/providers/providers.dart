import 'package:hooks_riverpod/hooks_riverpod.dart';

final startTimeOptionIndexProvider = StateProvider<int>((ref) => 2);

// Provides whether the app screen is locked and all buttons should be disabled
final appLockProvider = StateProvider<bool>((ref) => false);
