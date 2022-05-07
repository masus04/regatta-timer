import 'package:hooks_riverpod/hooks_riverpod.dart';

// Provides whether the app screen is locked and all buttons should be disabled
final appLockProvider = StateProvider<bool>((ref) => false);

