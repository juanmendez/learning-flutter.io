import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:learning_flutter/model/message.dart';

import '../constants.dart';

final firestore = FirebaseFirestore.instance;
User loggedInUser;

class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final _auth = FirebaseAuth.instance;
  final messageTextController = TextEditingController();
  String messageText;

  @override
  void initState() {
    super.initState();
    _loadUser();
  }

  void _loadUser() {
    final user = _auth.currentUser;

    if (user != null) {
      loggedInUser = user;
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
          children: <Widget>[
            Expanded(child: MessagesStream()),
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
                      controller: messageTextController,
                    ),
                  ),
                  FlatButton(
                    onPressed: () {
                      firestore.collection("messages").add(
                        Message(sender: loggedInUser.email, text: messageText, dateTime: DateTime.now()).toJson()
                      );

                      messageTextController.clear();
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

class MessagesStream extends StatelessWidget {
  final _firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: _firestore.collection("messages").orderBy('dateTime', descending: true).snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<Widget> widgets = [];

          for (var doc in snapshot.data.documents) {
            var message = Message.fromJson(doc.data());
            widgets.add(MessageBubble(message: message, isCurrentUser: message.sender == loggedInUser.email));
          }

          return ListView(
            children: widgets.reversed.toList(),
            reverse: true,
          );
        } else {
          return Center(
            child: CircularProgressIndicator(
              backgroundColor: Colors.lightBlueAccent,
            ),
          );
        }
      },
    );
  }
}

class MessageBubble extends StatelessWidget {
  const MessageBubble({@required this.message, @required this.isCurrentUser});

  final Message message;
  final bool isCurrentUser;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: isCurrentUser ? CrossAxisAlignment.start : CrossAxisAlignment.end,
        children: [
          Text(
            message.sender,
            style: TextStyle(fontSize: 12, color: Colors.white54),
          ),
          SizedBox(height: 12),
          Material(
            color: isCurrentUser ? Colors.white70 : Colors.lightBlueAccent,
            borderRadius: BorderRadius.only(
              topLeft: isCurrentUser ? Radius.circular(0) : Radius.circular(30),
              topRight: isCurrentUser ? Radius.circular(30) : Radius.circular(0),
              bottomLeft: Radius.circular(30.0),
              bottomRight: Radius.circular(30.0),
            ),
            elevation: 5.0,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              child: Text(
                message.text ?? '?',
                style: TextStyle(fontSize: 15.0),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
