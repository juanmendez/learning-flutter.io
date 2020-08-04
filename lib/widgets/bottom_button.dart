import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:learning_flutter/res.dart';

class BottomButton extends StatelessWidget {
  final String label;
  final Function() onTap;

  BottomButton({this.label, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        color: Colors.pink,
        margin: EdgeInsets.only(top: 10),
        height: Dimens.bottomNavHeight,
        child: Center(
          child: Text(
            label,
            style: BmiStyle.bmiLabel.copyWith(color: Colors.white),
          ),
        ),
      ),
    );
  }
}
