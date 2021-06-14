// All constants for the Regatta Timer app

import 'dart:math';
import 'package:flutter/widgets.dart';

// Possible start times in minutes
const startTimeOptions = [1, 2, 3, 5, 10, 15, 20, 30, 45, 60];

// FontSize relative to ScreenSize given by context
double fontSizeFromScreenSize(BuildContext context) {
  return (min(MediaQuery.of(context).size.width, MediaQuery.of(context).size.height) / 13 ).floorToDouble();
}
