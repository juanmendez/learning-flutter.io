import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:learning_flutter/bloc/photo_bloc.dart';
import 'package:learning_flutter/bloc/weather_bloc.dart';
import 'package:learning_flutter/model/location_result.dart';
import 'package:learning_flutter/model/weather_models.dart';
import 'package:learning_flutter/services/weather.dart';
import 'package:learning_flutter/utilities/Strings.dart';
import 'package:learning_flutter/utilities/constants.dart';
import 'package:learning_flutter/utilities/routes.dart';
import 'package:sprintf/sprintf.dart';

class LocationScreen extends StatelessWidget {
  LocationScreen(this.locationResult);
  final LocationResult locationResult;

  int _temperature = 0;
  String? _condition;
  String? _message;

  void updateProperties(BuildContext context) {

    final weatherResult = locationResult.weatherResult;

    if (weatherResult != null) {
      updateWeatherResult(weatherResult);

      if(locationResult.locationBackground == null) {
        // we now request photo by location
        BlocProvider.of<PhotoBloc>(context).add(
          PhotoEvent(weatherResult.name),
        );
      }
    }
  }

  void updateWeatherResult(WeatherResult weatherResult) {
    _temperature = weatherResult.main.temp.round();

    var weather = weatherResult.weather;

    if (weather.isNotEmpty) {
      int id = weather.first.id;
      _condition = WeatherModel.getWeatherIcon(id);
    } else {
      _condition = WeatherModel.getWeatherIcon(0);
    }

    final locationName = weatherResult.name;

    final activity = WeatherModel.getMessage(_temperature);

    _message = sprintf(Strings.TIME_IN_LOCAtION, [activity, locationName]);
  }

  void updateWeatherLocation(BuildContext context) {
    BlocProvider.of<WeatherBloc>(context).add(WeatherByGeolocationEvent());
  }

  void searchByCity(BuildContext context) {
    Navigator.of(context).pushNamed(Routes.CITY);
  }

  BoxDecoration? getBoxDecoration() {
    ImageProvider? provider;
    final imageUrl = locationResult.locationBackground;

    if (imageUrl != null) {
      if (imageUrl.isNotEmpty) {
        provider = NetworkImage(imageUrl);
      } else {
        provider = AssetImage('assets/images/location_background.jpg');
      }

      return BoxDecoration(
        image: DecorationImage(
          image: provider,
          fit: BoxFit.cover,
          colorFilter: ColorFilter.mode(Colors.white.withOpacity(0.8), BlendMode.dstATop),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    updateProperties(context);

    return Scaffold(
      body: Container(
        decoration: getBoxDecoration(),
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
                    onPressed: () => updateWeatherLocation(context),
                    child: Icon(
                      Icons.near_me,
                      size: 50.0,
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () => searchByCity(context),
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
                      '$_temperature°',
                      style: kTempTextStyle,
                    ),
                    Text(
                      _condition ?? '',
                      style: kConditionTextStyle,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(right: 15.0),
                child: Text(
                  _message ?? '',
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

