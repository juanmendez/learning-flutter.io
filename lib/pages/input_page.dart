import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:learning_flutter/pages/results_page.dart';
import 'package:learning_flutter/res.dart';
import 'package:learning_flutter/widgets/bmi_card.dart';
import 'package:learning_flutter/widgets/bottom_button.dart';
import 'package:learning_flutter/widgets/icon_widget.dart';
import 'package:learning_flutter/widgets/round_icon_button.dart';

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
  int personWeight = 100;
  int personAge = 20;

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

  void onWeightChange(bool increase) {
    setState(() {
      increase ? personWeight++ : personWeight--;
    });
  }

  void onAgeChange(bool increase) {
    setState(() {
      increase ? personAge++ : personAge--;
    });
  }

  void onSubmit() {
    // Navigator.pushNamed(context, "/result");

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ResultsPage(
          personWeight: personWeight,
          personHeight: personHeight,
        ),
      ),
    );
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
                      style: BmiStyle.bmiLabel,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.baseline,
                      textBaseline: TextBaseline.alphabetic,
                      children: <Widget>[
                        Text(
                          personHeight.toString(),
                          style: BmiStyle.numberStyle,
                        ),
                        Text(
                          "cm",
                          style: BmiStyle.bmiLabel,
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
                    child: BmiCard(
                      cardChild: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text("WEIGHT", style: BmiStyle.bmiLabel),
                          Text(personWeight.toString(),
                              style: BmiStyle.numberStyle),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              RoundIconButton(
                                child: Icon(FontAwesomeIcons.minus),
                                onTap: () => onWeightChange(false),
                              ),
                              RoundIconButton(
                                child: Icon(FontAwesomeIcons.plus),
                                onTap: () => onWeightChange(true),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: BmiCard(
                      cardChild: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text("AGE", style: BmiStyle.bmiLabel),
                          Text(personAge.toString(),
                              style: BmiStyle.numberStyle),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              RoundIconButton(
                                child: Icon(FontAwesomeIcons.minus),
                                onTap: () => onAgeChange(false),
                              ),
                              RoundIconButton(
                                child: Icon(FontAwesomeIcons.plus),
                                onTap: () => onAgeChange(true),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            BottomButton(
              label: "CALCULATE",
              onTap: onSubmit,
            ),
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
