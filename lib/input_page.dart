import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:learning_flutter/main.dart';

class InputPage extends StatefulWidget {
  @override
  _InputPageState createState() => _InputPageState();
}

class _InputPageState extends State<InputPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('BMI CALCULATOR'),
      ),
      body: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Expanded(
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: BmiCard(color: Colors.pink,),
                  ),
                  Expanded(
                    child: BmiCard(),
                  ),
                ],
              ),
            ),
            Expanded(
              child: BmiCard(),
            ),
            Expanded(
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: BmiCard(),
                  ),
                  Expanded(
                    child: BmiCard(),
                  ),
                ],
              ),
            ),
            Container(
              color: Colors.pink,
              margin: EdgeInsets.only(top: 10),
              height: 80,
            )
          ],
        ),
      ),
    );
  }
}

class BmiCard extends StatelessWidget {
  // A key is an identifier for Widgets, Elements and SemanticNodes.
  // A new widget will update an existing element if its key is the same
  // as the key of the intended widget.
  /*const ReusableCard({
    Key key,
  }) : super(key: key);*/

  Color color;

  // I made it having a default, but the tutorial uses @required to enforce it
  BmiCard({this.color: ThemeColor.blue});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(15.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        color: color,
      ),
    );
  }
}
