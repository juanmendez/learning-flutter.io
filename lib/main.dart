import 'package:flutter/material.dart';

// For hot reload to work, we need a stateless widget.
// Previously we weren't able to automatically see any updates in a hot swap.
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final profileUrl = "https://avatars2.githubusercontent.com/u/3371622?s=400&u=9dcf47146ab4693708877582baacc5731ff50855&v=4";

    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.teal,
        body: SafeArea(
          child: ConstrainedBox(
            constraints: BoxConstraints.expand(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                CircleAvatar(
                  radius: 50.0,
                  backgroundImage: NetworkImage(profileUrl),
                ),
                SizedBox(height: 10),
                Text(
                  "Juan Mendez",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 40.0,
                      fontFamily: "Pacifico"
                  ),
                ),
                Text(
                  "ANDROID DEVELOPER",
                  style: TextStyle(
                      color: Colors.teal[100],
                      fontSize: 20.0,
                      fontFamily: "Source Sans Pro",
                    letterSpacing: 1.8,
                    fontWeight: FontWeight.bold
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
