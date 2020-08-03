import 'package:flutter/material.dart';
import 'package:learning_flutter/res.dart';

import 'input_page.dart';

void main() => runApp(BMICalculator());

class BMICalculator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark().copyWith(
        primaryColor: ThemeColor.primaryColor,
        scaffoldBackgroundColor: ThemeColor.scaffoldColor,
      ),
      home: InputPage(),
    );
  }
}
