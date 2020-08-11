import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:learning_flutter/model/weather_models.dart';
import 'package:learning_flutter/screens/location_screen.dart';
import 'package:learning_flutter/services/network_result.dart';
import 'package:learning_flutter/services/weather.dart';
import 'package:learning_flutter/utilities/constants.dart';
import 'package:learning_flutter/utilities/no_sliding_route.dart';

class LoadingScreen extends StatefulWidget {
  final String city;

  LoadingScreen({this.city = ""});

  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  var networkStatus = '';

  @override
  void initState() {
    super.initState();
    getLocation();
  }

  void getLocation() async {
    NetworkResult<WeatherResult> result;

    if (widget.city.isNotEmpty) {
      result = await WeatherModel.getWeatherByCity(widget.city);
    } else {
      result = await WeatherModel.getWeatherByLocation();
    }

    if (result.data != null) {
      // pushReplacement simply removes current screen from the stack
      // replacing next screen, and avoid swiping back here
      Navigator.pushReplacement(context, NoSlidingRoute(builder: (context) {
        return LocationScreen(result.data);
      }));
    } else {
      setState(() {
        if (widget.city.isNotEmpty) {
          networkStatus = "Cannot find weather for ${widget.city}.";
        } else {
          networkStatus = "There is a network or location issue.";
        }

        networkStatus += "\nPress on the circle to try again.";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: <Widget>[
            Center(
              child: GestureDetector(
                child: SpinKitDoubleBounce(
                  color: Colors.white,
                  size: 100.0,
                ),
                onTap: getLocation,
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Text(
                  networkStatus,
                  style: kErrorTextStyle,
                  textAlign: TextAlign.center,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
