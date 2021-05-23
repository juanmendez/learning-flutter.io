import 'package:flutter/material.dart';
import 'package:learning_flutter/model/analytics_diccionary.dart';
import 'package:learning_flutter/screens/loading_screen.dart';
import 'package:learning_flutter/services/analytics.dart';
import 'package:learning_flutter/services/injection.dart';
import 'package:learning_flutter/utilities/constants.dart';

class CityScreen extends StatefulWidget {
  @override
  _CityScreenState createState() => _CityScreenState();
}

class _CityScreenState extends State<CityScreen> {
  String city = "";

  Analytics get analytics => getIt.get<Analytics>();

  @override
  void initState() {
    super.initState();

    analytics.logEvent(
      AnalyticsEvent.VIEW_SCREEN,
      eventProperties: <String, dynamic>{
        AnalyticsKey.SCREEN: AnalyticsValue.CITY_SCREEN,
      },
    );
  }

  void onChange(String value) {
    city = value.trim();
  }

  void submit() {
    if (city.isNotEmpty) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) {
          return LoadingScreen(
            city: city,
          );
        }),
      );
    }
  }

  void goBack() {
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/city_background.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        constraints: BoxConstraints.expand(),
        child: SafeArea(
          child: Column(
            children: <Widget>[
              Align(
                alignment: Alignment.topLeft,
                child: FlatButton(
                  onPressed: goBack,
                  child: Icon(
                    Icons.arrow_back_ios,
                    size: 50.0,
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.all(20.0),
                child: TextField(
                  decoration: kTextFieldInputDecoration,
                  style: TextStyle(color: Colors.black),
                  onChanged: onChange,
                ),
              ),
              FlatButton(
                onPressed: submit,
                child: Text(
                  'Get Weather',
                  style: kButtonTextStyle,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
