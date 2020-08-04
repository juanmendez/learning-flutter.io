import 'package:flutter/material.dart';
import 'package:learning_flutter/bmi_calculator.dart';
import 'package:learning_flutter/res.dart';
import 'package:learning_flutter/widgets/bmi_card.dart';

import '../widgets/bottom_button.dart';

class ResultsPage extends StatelessWidget {
  String bmiPrint = "";
  String condition = "";
  String status = "";

  ResultsPage({personWeight, personHeight}) {
    final calculator = Calculator(height: personHeight, weight: personWeight);
    final bmi = calculator.calculate();
    bmiPrint = calculator.showCalculation(bmi);
    condition = calculator.getResult(bmi);
    status = calculator.getStatus(bmi);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("BMI CALCULATOR"),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Expanded(
            child: Container(
              child: Center(
                child: Text(
                  "Your Results",
                  style: BmiStyle.titleStyle,
                ),
              ),
            ),
          ),
          Expanded(
            flex: 5,
            child: BmiCard(
              color: ThemeColor.activeColor,
              cardChild: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text(
                    status,
                    style: BmiStyle.resultStyle,
                  ),
                  Text(
                    bmiPrint,
                    style: BmiStyle.bmiStyle,
                  ),
                  Text(
                    condition,
                    style: BmiStyle.bmiLabel,
                  )
                ],
              ),
            ),
          ),
          BottomButton(
            label: "RE-CALCULATE",
            onTap: () => Navigator.pop(context),
          ),
        ],
      ),
    );
  }
}
