import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:learning_flutter/services/location.dart';
import 'package:learning_flutter/services/networking.dart';

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  var location = 'Get Location';

  void getLocation() async {
    // any code under can be executed, as Future is handle asynchronously
    // there is no need to set getLocation with async
    /*
    Location.getLocation().then((value) {
      setState(() {
        location = value.toString();
      });
    });*/

    // here await halts until the promise is release and continues executing
    final Position position = await Location.getLocation();
    final result = await NetworkHelper.getWeatherResult(position);

    setState(() {
      if (result.data != null) {
        location = "${result.data.coord.lat} : ${result.data.coord.lon}";
      } else {
        location = "Network error";
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: RaisedButton(
          color: Colors.blue,
          onPressed: () => getLocation(),
          child: Text(location),
        ),
      ),
    );
  }
}
