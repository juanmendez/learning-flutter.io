import 'dart:math';

import 'package:flutter/material.dart';

void main() {
  return runApp(
    MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.red,
        appBar: AppBar(
          title: Text('Dicee'),
          backgroundColor: Colors.red,
        ),
        body: DicePage(),
      ),
    ),
  );
}

class DicePage extends StatefulWidget {
  @override
  _DicePageState createState() => _DicePageState();
}

class _DicePageState extends State<DicePage> {
  var leftDiceNumber = 5;
  var rightDiceNumber = 5;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Row(
        children: [
          Expanded(
            child: FlatButton(
              onPressed: () => onFlatButtonPressed(true),
              child: Image.asset("assets/images/dice$leftDiceNumber.png"),
            ),
          ),
          Expanded(
            child: FlatButton(
              onPressed: () => onFlatButtonPressed(false),
              child: Image.asset("assets/images/dice$rightDiceNumber.png"),
            ),
          ),
        ],
      ),
    );
  }

  void onFlatButtonPressed(bool isLeft) {
    setState(() {
      final random = Random().nextInt(6) + 1;

      if (isLeft) {
        leftDiceNumber = random;
      } else {
        rightDiceNumber = random;
      }
    });
  }
}
