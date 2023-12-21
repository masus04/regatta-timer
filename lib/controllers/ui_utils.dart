import 'package:flutter/material.dart';

enum DeviceType {
  watch,
  phone,
  tablet;

  bool get isMobile => this == DeviceType.phone || this == DeviceType.tablet;

  bool get isWatch => this == DeviceType.watch;
}

class UiUtils {
  final BuildContext context;

  final double _mobileFontSize = 50;
  final double _mobileMenuFontSize = 20;
  final double _watchScaleFactor = .75;

  UiUtils(this.context);

  DeviceType get deviceType {
    final view = View.of(context);

    final height = view.devicePixelRatio * view.physicalSize.height;
    final width = view.devicePixelRatio * view.physicalSize.width;

    final aspectRatio = width / height;

    /// Watch Constants
    if (aspectRatio == 1) {
      return DeviceType.watch;
    }

    /// Phone Constants
    if (aspectRatio >= 16 / 9 || aspectRatio <= 9 / 16) {
      return DeviceType.phone;
    }

    /// Tablet Constants
    return DeviceType.tablet;
  }

  double get displayFontSize {
    switch (deviceType) {
      case DeviceType.watch:
        return _mobileFontSize / 2;
      default:
        return _mobileFontSize;
    }
  }

  double get menuFontSize {
    switch (deviceType) {
      case DeviceType.watch:
        return _mobileMenuFontSize / 2;
      default:
        return _mobileMenuFontSize;
    }
  }

  double get switchScaleFactor {
    switch (deviceType) {
      case DeviceType.watch:
        return _watchScaleFactor;
      default:
        return 1;
    }
  }
}
