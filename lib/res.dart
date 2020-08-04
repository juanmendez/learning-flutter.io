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
  static const Color fabColor = Color(0xFf4C4F5e);
  static const Color lightGreen = Color(0xFF24D876);
}

abstract class BmiStyle {
  static const TextStyle bmiLabel = TextStyle(
    fontSize: 18.0,
    color: ThemeColor.lightWhite,
  );

  static const TextStyle numberStyle = TextStyle(
    fontSize: 40.0,
    fontWeight: FontWeight.w900,
  );

  static const TextStyle buttonTextStyle = TextStyle(
    fontSize: 25.0,
    fontWeight: FontWeight.bold,
  );

  static const TextStyle titleStyle = TextStyle(
    fontSize: 45.0,
    fontWeight: FontWeight.bold,
  );

  static const TextStyle resultStyle = TextStyle(
    color: Color(0xFF24D876),
    fontSize: 22.0,
    fontWeight: FontWeight.bold,
  );

  static const bmiStyle = TextStyle(
    fontSize: 100.0,
    fontWeight: FontWeight.bold,
  );
}

abstract class Dimens {
  static const bottomNavHeight = 70.0;
}
