import 'package:flutter/material.dart';

// For hot reload to work, we need a stateless widget.
// Previously we weren't able to automatically see any updates in a hot swap.
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.teal,
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
             children: <Widget>[
               Container(
                 color: Colors.red,
                 child: Text("hello"),
                 padding: EdgeInsets.all(40),
               ),
               SizedBox(height: 10,),
               Container(
                 color: Colors.white,
                 child: Text("hello"),
                 padding: EdgeInsets.all(40),
               ),
               SizedBox(height: 10,),
               Container(
                 color: Colors.blue,
                 child: Text("hello"),
                 padding: EdgeInsets.all(40),
               ),
               SizedBox(height: 10,),
               Container(
                 color: Colors.yellow,
                 child: Text("hello"),
                 padding: EdgeInsets.all(40),
               ),
               SizedBox(height: 10,),
             ],
          ),
        ),
      ),
    );
  }
}
