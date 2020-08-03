import 'package:flutter/material.dart';

abstract class ThemeColor {
  static const Color lightWhite = Color(0xFF8D8E98);
  static const Color activeColor = Color(0xFF111328);
  static const Color inactiveColor = Color(0xFF1D1E33);
}

abstract class Style {
  static const TextStyle bmiLabel = TextStyle(
    fontSize: 18.0,
    color: ThemeColor.lightWhite,
  );
}

abstract class Dimens {
  static const bottomNavHeight = 80.0;
}
