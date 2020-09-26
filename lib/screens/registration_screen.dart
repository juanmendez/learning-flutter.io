import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:learning_flutter/constants.dart';
import 'package:learning_flutter/screens/widgets/pill_button.dart';

class RegistrationScreen extends StatefulWidget {
  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  FirebaseAuth _auth = FirebaseAuth.instance;
  String _email, _password;

  void _register() {
    _auth.createUserWithEmailAndPassword(
      email: _email,
      password: _password,
    ).then((newUser) {
      if (newUser != null) {
        Navigator.pushNamed(context, Routes.CHAT_ROUTE);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Hero(
              tag: 'logo',
              child: Container(
                height: 200.0,
                child: Image.asset('assets/images/logo.png'),
              ),
            ),
            SizedBox(
              height: 48.0,
            ),
            TextField(
              onChanged: (value) {
                _email = value;
              },
              decoration:
                  kInputDecoration.copyWith(hintText: 'Enter your email'),
              style: TextStyle(color: Colors.black),
              textAlign: TextAlign.center,
              keyboardType: TextInputType.emailAddress,
            ),
            SizedBox(
              height: 8.0,
            ),
            TextField(
              onChanged: (value) {
                _password = value;
              },
              decoration:
                  kInputDecoration.copyWith(hintText: 'Enter your password'),
              style: TextStyle(color: Colors.black),
              textAlign: TextAlign.center,
              obscureText: true,
            ),
            SizedBox(
              height: 24.0,
            ),
            PillButton(
              'Register',
              Colors.blueAccent,
              _register,
            ),
          ],
        ),
      ),
    );
  }
}
