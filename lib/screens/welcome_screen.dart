import 'dart:developer' as d;

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:learning_flutter/screens/widgets/pill_button.dart';

import '../constants.dart';

class WelcomeScreen extends StatefulWidget {
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen>
    with SingleTickerProviderStateMixin {
  AnimationController controller;
  Animation animation;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
      duration: Duration(seconds: 2),
      vsync: this,
    );

    // can't use upper-bound beyond 1.0
    animation = ColorTween(
      begin: Colors.grey,
      end: Colors.white,
    ).animate(controller);

    controller.forward();

    controller.addListener(() {
      d.log('controller.value: ${controller.value}');
      setState(() {});
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  } // when the screen is disposed, ensure we dispose the controller

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: animation.value, // odd, no more controller.value
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Row(
              children: <Widget>[
                Hero(
                  tag: 'logo',
                  child: Container(
                    child: Image.asset('assets/images/logo.png'),
                    height: 60,
                  ),
                ),
                TypewriterAnimatedTextKit(
                  text: ['Flash Chat'],
                  textStyle: TextStyle(
                    fontSize: 45.0,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 48.0,
            ),
            PillButton(
              'Log In',
              Colors.lightBlueAccent,
                  () {
                Navigator.of(context).pushNamed(Routes.LOGIN_ROUTE);
              },
            ),
            PillButton(
              'Register',
              Colors.blueAccent,
              () {
                Navigator.of(context).pushNamed(Routes.REGISTRATION_ROUTE);
              },
            ),
          ],
        ),
      ),
    );
  }
}
