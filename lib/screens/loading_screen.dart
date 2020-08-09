import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:learning_flutter/screens/location_screen.dart';
import 'package:learning_flutter/services/weather.dart';
import 'package:learning_flutter/utilities/no_transition_route.dart';

class LoadingScreen extends StatefulWidget {
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
    final result = await WeatherModel.getWeatherByLocation();

    if (result.data != null) {
      // pushReplacement simply removes current screen from the stack
      // replacing next screen, and avoid swiping back here
      Navigator.pushReplacement(context, NoSlidingRoute(builder: (context) {
        return LocationScreen(result.data);
      }));
    } else {
      setState(() {
        networkStatus = "Network error";
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
              child: SpinKitDoubleBounce(
                color: Colors.white,
                size: 100.0,
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Text(networkStatus),
              ),
            )
          ],
        ),
      ),
    );
  }
}
