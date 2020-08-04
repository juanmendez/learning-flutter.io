import 'dart:math';

class Calculator {
  Calculator({this.height, this.weight});

  final int height;
  final int weight;

  double calculate() => weight / pow(height / 100, 2);
  String showCalculation(double bmi) => bmi.toStringAsFixed(1);

  String getResult(double bmi) {
    if(bmi >= 25) {
      return "You need to eat less";
    } else if (bmi >= 18.5) {
      return "You are eating well";
    } else {
      return "You need to eat more";
    }
  }

  String getStatus(double bmi) {
    if(bmi >= 25) {
      return "Everyday at Popeye's";
    } else if (bmi >= 18.5) {
      return "Once a month at Popeye's";
    } else {
      return "0 times at Popeye's";
    }
  }
}
