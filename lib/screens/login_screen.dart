import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:learning_flutter/screens/widgets/pill_button.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

import '../constants.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String _email, _password;
  FirebaseAuth _auth = FirebaseAuth.instance;
  bool showSpinner = false;

  void _login() {
    showSpinner = true;

    if (_email != null && _password != null) {
      _auth
          .signInWithEmailAndPassword(
        email: _email,
        password: _password,
      )
          .then((value) {
        _isLoading(false);

        if (value.user != null) {
          Navigator.pushNamed(context, Routes.CHAT_ROUTE);
        }
      }, onError: (error) {
        _isLoading(false);
      });
    }
  }

  void _isLoading(bool loading) {
    setState(() {
      showSpinner = loading;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Flexible(
                child: Hero(
                  tag: 'logo',
                  child: Container(
                    height: 200.0,
                    child: Image.asset('assets/images/logo.png'),
                  ),
                ),
              ),
              SizedBox(
                height: 48.0,
              ),
              TextField(
                onChanged: (value) {
                  _email = value;
                },
                decoration: kInputDecoration.copyWith(
                  hintText: 'Enter your email',
                ),
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
                decoration: kInputDecoration.copyWith(
                  hintText: 'Enter your password',
                ),
                style: TextStyle(color: Colors.black),
                textAlign: TextAlign.center,
                obscureText: true,
              ),
              SizedBox(
                height: 24.0,
              ),
              PillButton(
                'Log In',
                Colors.lightBlueAccent,
                _login,
              ),
            ],
          ),
        ),
        color: Colors.lightBlueAccent,
      ),
    );
  }
}
