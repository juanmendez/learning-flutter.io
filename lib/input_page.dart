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
  static const PERSON_MIN_HEIGHT = 100.0;
  static const PERSON_MAX_HEIGHT = 250.0;

  Color maleBackground = ThemeColor.inactiveColor;
  Color femaleBackground = ThemeColor.inactiveColor;
  Gender selectedGender;
  int personHeight = 180;

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

  void onSlideChange(double value) {
    setState(() {
      personHeight = value.toInt();
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
                cardChild: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      "HEIGHT",
                      style: Style.bmiLabel,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.baseline,
                      textBaseline: TextBaseline.alphabetic,
                      children: <Widget>[
                        Text(
                          personHeight.toString(),
                          style: Style.numberStyle,
                        ),
                        Text(
                          "cm",
                          style: Style.bmiLabel,
                        ),
                      ],
                    ),
                    SliderTheme(
                      /**
                       * we added here the styling, as we could have done the same in our main.dart file
                       * by adding sliderThemeData in order to have any slider widget with that style.
                       *
                       * It is a good practice to start like this and then whenever
                       * there are more instances with the same styling switch to global.
                       */
                      data: SliderTheme.of(context).copyWith(
                        thumbColor: ThemeColor.sliderHandle,
                        overlayColor: ThemeColor.sliderHandleOverlay,
                        thumbShape: RoundSliderThumbShape(
                          enabledThumbRadius: 15.0,
                        ),
                        overlayShape: RoundSliderOverlayShape(
                          overlayRadius: 20.0,
                        ),
                        activeTrackColor: ThemeColor.sliderActive,
                      ),
                      child: Slider(
                        min: PERSON_MIN_HEIGHT,
                        value: personHeight.toDouble(),
                        max: PERSON_MAX_HEIGHT,
                        inactiveColor: ThemeColor.sliderInactive,
                        onChanged: onSlideChange,
                      ),
                    )
                  ],
                ),
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
