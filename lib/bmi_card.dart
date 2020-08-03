import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:learning_flutter/res.dart';

import 'main.dart';

class BmiCard extends StatelessWidget {
  // A key is an identifier for Widgets, Elements and SemanticNodes.
  // A new widget will update an existing element if its key is the same
  // as the key of the intended widget.
  /*const ReusableCard({
    Key key,
  }) : super(key: key);*/

  final Color color;
  final Widget cardChild;
  final Function onTap;

  // I made it having a default, but the tutorial uses @required to enforce it
  BmiCard({this.color: ThemeColor.inactiveColor, this.cardChild, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.all(15.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          color: color,
        ),
        child: cardChild,
      ),
    );
  }
}