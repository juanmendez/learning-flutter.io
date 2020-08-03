import 'package:flutter/material.dart';
import 'package:learning_flutter/res.dart';

class IconWidget extends StatelessWidget {
  final String text;
  final IconData iconData;

  IconWidget(this.text, this.iconData);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Icon(
          iconData,
          size: 80.0,
        ),
        SizedBox(
          height: 15.0,
        ),
        Text(
          text,
          style: Style.bmiLabel,
        )
      ],
    );
  }
}
