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
  User _loggedInUser;
  String messageText;

  @override
  void initState() {
    super.initState();
    _loadUser();
  }

  void _loadUser() {
    final user = _auth.currentUser;

    if (user != null) {
      _loggedInUser = user;
      _getMessages();
    } else {
      _logout();
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

  void _getMessages() {}

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
            StreamBuilder(
              stream: _firestore.collection("messages").snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  List<Text> widgets = [];
                  final docs = snapshot.data.documents;

                  for (var doc in docs) {
                    final message = Message.fromJson(doc.data());
                    widgets.add(
                      Text(
                        '${message.text} from ${message.sender}',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    );
                  }

                  return Column(
                    children: widgets,
                  );
                } else {
                  return Center(
                    child: CircularProgressIndicator(
                      backgroundColor: Colors.lightBlueAccent,
                    ),
                  );
                }
              },
            ),
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
                      _firestore.collection("messages").add(
                          {"sender": _loggedInUser.email, "text": messageText});
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
