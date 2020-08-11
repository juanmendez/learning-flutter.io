import 'dart:developer';
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:learning_flutter/model/photo_models.dart';
import 'package:learning_flutter/model/weather_models.dart';
import 'package:learning_flutter/screens/city_screen.dart';
import 'package:learning_flutter/screens/loading_screen.dart';
import 'package:learning_flutter/services/network_result.dart';
import 'package:learning_flutter/services/weather.dart';
import 'package:learning_flutter/utilities/Strings.dart';
import 'package:learning_flutter/utilities/constants.dart';
import 'package:learning_flutter/utilities/no_sliding_route.dart';
import 'package:sprintf/sprintf.dart';

class LocationScreen extends StatefulWidget {
  final WeatherResult weatherResult;

  LocationScreen(this.weatherResult);

  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  int temperature;
  String condition;
  String message;
  String imageUrl;

  @override
  void initState() {
    super.initState();

    final weatherResult = widget.weatherResult;
    updateWeatherResult(weatherResult);
  }

  void updateWeatherResult(WeatherResult weatherResult) {
    temperature = weatherResult.main.temp.round();

    var weather = weatherResult.weather;

    if (weather.isNotEmpty) {
      int id = weather.first.id;
      condition = WeatherModel.getWeatherIcon(id);
    } else {
      condition = WeatherModel.getWeatherIcon(0);
    }

    final cityName = weatherResult.name;
    final activity = WeatherModel.getMessage(temperature);
    message = sprintf(Strings.TIME_IN_LOCAtION, [activity, cityName]);

    getPhotoByCity(cityName);
  }

  void getPhotoByCity(String city) async {
    NetworkResult<PhotoResult> photoResult = await WeatherModel.getPhoto(city);

    setState(() {
      imageUrl = "";
      if(photoResult.data != null) {
        if(photoResult.data.photos.isNotEmpty) {
          imageUrl = photoResult.data.photos.first.src.large ?? "";
        }
      }
    });
  }

  void updateWeatherLocation() {
    Navigator.pushReplacement(
      context,
      NoSlidingRoute(builder: (context) {
        return LoadingScreen();
      }),
    );
  }

  void searchByCity() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) {
        return CityScreen();
      }),
    );
  }

  BoxDecoration getBoxDecoration() {
    ImageProvider provider;

    if(imageUrl != null) {
      if(imageUrl.isNotEmpty) {
        provider = NetworkImage(imageUrl);
      } else if(imageUrl.isEmpty){
        provider = AssetImage('assets/images/location_background.jpg');
      }
    }

    if(provider != null) {
      return BoxDecoration(
        image: DecorationImage(
          image: provider,
          fit: BoxFit.cover,
          colorFilter: ColorFilter.mode(
            Colors.white.withOpacity(0.8),
            BlendMode.dstATop,
          ),
        ),
      );
    } else {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
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
                    onPressed: updateWeatherLocation,
                    child: Icon(
                      Icons.near_me,
                      size: 50.0,
                    ),
                  ),
                  FlatButton(
                    onPressed: searchByCity,
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
