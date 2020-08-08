import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  var location = 'Get Location';

  void getLocation() async {
    // make sure to select location under simulator, as the default is none.
    // Android has one already defined, but you can also update the emulator current location
    final position = await Geolocator().getCurrentPosition(desiredAccuracy: LocationAccuracy.low);

    setState(() {
      location = position.toString();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: RaisedButton(
          color: Colors.blue,
          onPressed: ()=> getLocation(),
          child: Text(location),
        ),
      ),
    );
  }
}
