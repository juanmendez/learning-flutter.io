import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:learning_flutter/model/message.dart';
import '../constants.dart';

class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final _firestore = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;
  StreamSubscription<QuerySnapshot> _subscription;
  User _loggedInUser;
  String messageText;

  @override
  void initState() {
    super.initState();
    _loadUser();
  }


  @override
  void dispose() {
    _subscription?.cancel();
    super.dispose();
  }

  void _loadUser() {
    final user = _auth.currentUser;

    if(user != null) {
      _loggedInUser = user;
      getMessages();
    }
  }

  void _logout() {
    _auth.signOut().then((value) {
      Navigator.pushNamedAndRemoveUntil(
        context,
        Routes.WELCOME_ROUTE,
        (Route route) => false,
      );
    });
  }

  void getMessages() {
    _subscription?.cancel();
    _subscription = _firestore.collection("messages").snapshots().listen((event) {
      event.docs.forEach((doc) {
        /// As we are learning how to work with both Freeze and Json-Serializable
        /// We are making an instance from json and also printing it back to json.
        final message = Message.fromJson(doc.data());
        print("message received $message");
        print("message in json ${message.toJson()}");
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: null,
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.close),
              onPressed: _logout,
          ),
        ],
        title: Text('⚡️Chat'),
        backgroundColor: Colors.lightBlueAccent,
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Container(
              decoration: kMessageContainerDecoration,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      onChanged: (value) {
                        messageText = value;
                      },
                      decoration: kMessageTextFieldDecoration,
                    ),
                  ),
                  FlatButton(
                    onPressed: () {
                      _firestore.collection("messages").add( {
                        "sender": _loggedInUser.email,
                        "text": messageText
                      });
                    },
                    child: Text(
                      'Send',
                      style: kSendButtonTextStyle,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
