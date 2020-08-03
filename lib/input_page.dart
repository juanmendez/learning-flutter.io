import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:learning_flutter/res.dart';

import 'bmi_card.dart';
import 'icon_widget.dart';

class InputPage extends StatefulWidget {
  @override
  _InputPageState createState() => _InputPageState();
}

class _InputPageState extends State<InputPage> {
  Color maleBackground = ThemeColor.inactiveColor;
  Color femaleBackground = ThemeColor.inactiveColor;
  Gender selectedGender;

  void updateOnTap(Gender gender) {
    selectedGender = gender;

    setState(() {
      if (selectedGender == Gender.MALE) {
        maleBackground = ThemeColor.activeColor;
      } else {
        maleBackground = ThemeColor.inactiveColor;
      }

      if (selectedGender == Gender.FEMALE) {
        femaleBackground = ThemeColor.activeColor;
      } else {
        femaleBackground = ThemeColor.inactiveColor;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('BMI CALCULATOR'),
      ),
      body: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Expanded(
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: BmiCard(
                      color: maleBackground,
                      cardChild: IconWidget("MALE", FontAwesomeIcons.mars),
                      onTap: () => updateOnTap(Gender.MALE),
                    ),
                  ),
                  Expanded(
                    child: BmiCard(
                      color: femaleBackground,
                      cardChild: IconWidget("FEMALE", FontAwesomeIcons.venus),
                      onTap: () => updateOnTap(Gender.FEMALE),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: BmiCard(

              ),
            ),
            Expanded(
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: BmiCard(),
                  ),
                  Expanded(
                    child: BmiCard(),
                  ),
                ],
              ),
            ),
            Container(
              color: Colors.pink,
              margin: EdgeInsets.only(top: 10),
              height: Dimens.bottomNavHeight,
            )
          ],
        ),
      ),
    );
  }
}

enum Gender {
  MALE,
  FEMALE,
}
