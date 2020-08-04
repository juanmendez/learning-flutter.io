import 'package:flutter/material.dart';
import 'package:learning_flutter/pages/results_page.dart';
import 'package:learning_flutter/res.dart';

import 'pages/input_page.dart';

void main() => runApp(BMICalculator());

class BMICalculator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme:
      ThemeData.dark().copyWith(
        primaryColor: ThemeColor.primaryColor,
        scaffoldBackgroundColor: ThemeColor.scaffoldColor,
      ),
      initialRoute: "/",
      routes: {
        "/": (context) => InputPage(),
        "/result": (context) => ResultsPage(),
      },
    );
  }
}
