import 'dart:ui' as ui;

import 'package:hooks_riverpod/hooks_riverpod.dart';

enum DeviceType {
  watch,
  phone,
  tablet;

  bool get isMobile => this == DeviceType.phone || this == DeviceType.tablet;
}

class UIState {
  final DeviceType deviceType;
  final double displayFontSize;
  final double menuFonsSize;

  const UIState({required this.deviceType, required this.displayFontSize, required this.menuFonsSize});

  factory UIState.fromDeviceType() {
    final height = ui.window.devicePixelRatio * ui.window.physicalSize.height;
    final width = ui.window.devicePixelRatio * ui.window.physicalSize.width;

    final aspectRatio = width / height;

    /// Watch Constants
    if (aspectRatio == 1) {
      return const UIState(deviceType: DeviceType.watch, displayFontSize: 25, menuFonsSize: 10);
    }

    /// Phone Constants
    if (aspectRatio >= 16 / 9 || aspectRatio <= 9 / 16) {
      return const UIState(deviceType: DeviceType.phone, displayFontSize: 50, menuFonsSize: 20);
    }

    /// Tablet Constants
    return const UIState(deviceType: DeviceType.tablet, displayFontSize: 50, menuFonsSize: 20);
  }
}

final uiProvider = StateProvider<UIState>((ref) => UIState.fromDeviceType());
