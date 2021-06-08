import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:learning_flutter/utilities/constants.dart';

class LoadingScreen extends StatelessWidget {
  final Function getLocation;
  final String? errorMessage;

  LoadingScreen({
    required this.getLocation,
    this.errorMessage,
  });

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
                onTap: () => getLocation(),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: EdgeInsets.all(20),
                child: errorMessage != null
                    ? Text(
                        errorMessage!,
                        style: kErrorTextStyle,
                        textAlign: TextAlign.center,
                      )
                    : Container(),
              ),
            )
          ],
        ),
      ),
    );
  }
}
