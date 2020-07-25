import 'package:flutter/material.dart';

void main() {
  final title = "Workers of the world, unite!!";
  final assetImage = "assets/images/workers.jpeg";

  // keeping commas is a good practice for dart-fmt formatter
  runApp(
    MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.blueGrey.shade200,
        appBar: AppBar(
          title: Text(title),
          backgroundColor: Colors.lightBlue,
          centerTitle: true,
        ),
        body: Center(
          child: Image(
            image: AssetImage(assetImage),
          ),
        ),
      ),
    ),
  );
}
