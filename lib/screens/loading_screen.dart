import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:learning_flutter/model/analytics_diccionary.dart';
import 'package:learning_flutter/model/weather_models.dart';
import 'package:learning_flutter/screens/location_screen.dart';
import 'package:learning_flutter/services/analytics.dart';
import 'package:learning_flutter/services/injection.dart';
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

  Analytics get analytics => getIt.get<Analytics>();

  @override
  void initState() {
    super.initState();

    analytics.logEvent(
      AnalyticsEvent.VIEW_SCREEN,
      eventProperties: <String, dynamic>{
        AnalyticsKey.SCREEN: AnalyticsValue.LOADING_SCREEN,
      },
    );

    if (widget.city.isNotEmpty) {
      analytics.logEvent(
        AnalyticsEvent.CITY_SEARCHED,
        eventProperties: <String, dynamic>{
          AnalyticsKey.CITY: widget.city,
        },
      );
    }

    getLocation();
  }

  void getLocation() async {
    late NetworkResult<WeatherResult> result;

    try {
      if (widget.city.isNotEmpty) {
        result = await WeatherModel.getWeatherByCity(widget.city);
      } else {
        result = await WeatherModel.getWeatherByLocation();

        if(result.data?.name != null) {
          analytics.logEvent(
            AnalyticsEvent.CITY_DETECTED,
            eventProperties: <String, dynamic>{
              AnalyticsKey.CITY: result.data!.name,
            },
          );
        }
      }
    } catch (e, s) {
      print('weather error: $e $s');
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
