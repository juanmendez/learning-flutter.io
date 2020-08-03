import 'package:flutter/material.dart';

abstract class ThemeColor {
  static const Color primaryColor = Color(0xFF0A0E21);
  static const Color scaffoldColor = Color(0xFF0A0E21);
  static const Color lightWhite = Color(0xFF8D8E98);
  static const Color activeColor = Color(0xFF111328);
  static const Color inactiveColor = Color(0xFF1D1E33);
  static const Color sliderActive = Colors.white;
  static const Color sliderInactive = lightWhite;
  static const Color sliderHandle = Colors.pink;

  static final Color sliderHandleOverlay = Colors.pink.shade200;

  static final Color fabColor = Color(0xFf4C4F5e);
}

abstract class Style {
  static const TextStyle bmiLabel = TextStyle(
    fontSize: 18.0,
    color: ThemeColor.lightWhite,
  );

  static const TextStyle numberStyle = TextStyle(
    fontSize: 40.0,
    fontWeight: FontWeight.w900,
  );
}

abstract class Dimens {
  static const bottomNavHeight = 70.0;
}
