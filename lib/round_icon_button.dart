import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:learning_flutter/res.dart';

class RoundIconButton extends StatelessWidget {
  final Widget child;
  Function onTap = (){};

  RoundIconButton({this.child, this.onTap});

  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      shape: CircleBorder(),
      fillColor: ThemeColor.fabColor,
      constraints: BoxConstraints.tightFor(width: 56.0, height: 56.0),
      elevation: 6,
      disabledElevation: 6,
      onPressed: onTap,
      child: child,
    );
  }
}