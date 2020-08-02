import 'package:flutter/material.dart';

import 'input_page.dart';

void main() => runApp(BMICalculator());

abstract class ThemeColor {
  static const Color blue = Color(0xFF1D1E33);
}

class BMICalculator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(),
      home: InputPage(),
    );
  }
}
