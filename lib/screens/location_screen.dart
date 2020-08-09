import 'package:flutter/material.dart';
import 'package:learning_flutter/model/models.dart';
import 'package:learning_flutter/screens/loading_screen.dart';
import 'package:learning_flutter/services/weather.dart';
import 'package:learning_flutter/utilities/Strings.dart';
import 'package:learning_flutter/utilities/constants.dart';
import 'package:learning_flutter/utilities/no_transition_route.dart';
import 'package:sprintf/sprintf.dart';

class LocationScreen extends StatefulWidget {
  final WeatherResult weatherResult;

  LocationScreen(this.weatherResult);

  @override _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {

  int temperature;
  String condition;
  String message;

  @override
  void initState() {
    super.initState();

    final weatherResult = widget.weatherResult;
    updateWeatherResult(weatherResult);
  }

  void updateWeatherResult(WeatherResult weatherResult) {
    temperature = weatherResult.main.temp.round();

    var weather = weatherResult.weather;

    if(weather.isNotEmpty) {
      int id = weather.first.id;
      condition = WeatherModel.getWeatherIcon(id);
    } else {
      condition = WeatherModel.getWeatherIcon(0);
    }

    final cityName = weatherResult.name;
    final activity = WeatherModel.getMessage(temperature);
    message = sprintf(Strings.TIME_IN_LOCAtION, [activity, cityName]);
  }

  void updateWeatherLocation() {
    Navigator.pushReplacement(context, NoSlidingRoute(builder: (context) {
      return LoadingScreen();
    }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/location_background.jpg'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
              Colors.white.withOpacity(0.8),
              BlendMode.dstATop,
            ),
          ),
        ),
        constraints: BoxConstraints.expand(),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  FlatButton(
                    onPressed: updateWeatherLocation,
                    child: Icon(
                      Icons.near_me,
                      size: 50.0,
                    ),
                  ),
                  FlatButton(
                    onPressed: () {},
                    child: Icon(
                      Icons.location_city,
                      size: 50.0,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(left: 15.0),
                child: Row(
                  children: <Widget>[
                    Text(
                      '$temperature°',
                      style: kTempTextStyle,
                    ),
                    Text(
                      condition,
                      style: kConditionTextStyle,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(right: 15.0),
                child: Text(
                  message,
                  textAlign: TextAlign.right,
                  style: kMessageTextStyle,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
