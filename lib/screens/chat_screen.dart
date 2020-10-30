import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flash_chat/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

final _auth = FirebaseAuth.instance;
final _firestore = FirebaseFirestore.instance;
User loggedInUser;
bool isUser = true;

class ChatScreen extends StatefulWidget {
  static String id = '/chat';

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final messageTextController = TextEditingController();
  bool isLoading = false;
  String messageText;
  Color messageBoxColor;
  CrossAxisAlignment alignment;

  @override
  void initState() {
    super.initState();
    getUserDetails();
  }
//  void getMessages() async{
//    final messagesFromServer = await _firestore.collection('messages').get();
//    for(var message in messagesFromServer.docs){
//      print(message.data);
//    }
//  }

//  void messagesStream() async {
//    await for (var messageStream
//        in _firestore.collection('messages').snapshots()) {
//      for (var messageInfo in messageStream.docs) {
//        print(messageInfo.data);
//      }
//    }
//  }

  void getUserDetails() async {
    try {
      final newUser = await _auth.currentUser;
      if (newUser != null) {
        loggedInUser = newUser;
        print(loggedInUser.email);
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: null,
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.cancel),
              onPressed: () {
                _auth.signOut();
                Navigator.pop(context);
              }),
        ],
        title: Text('⚡️Chat'),
        backgroundColor: Colors.lightBlueAccent,
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            StreamBuilder<QuerySnapshot>(
              stream: _firestore.collection('messages').snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Center(
                    child: CircularProgressIndicator(
                      backgroundColor: Colors.lightBlueAccent,
                    ),
                  );
                }
                final messages = snapshot.data.docs.reversed;
                // Because in list view we have set reverse equals to true, so reversing list will make the most recent message appear at bottom.
                List<MessageBubble> messageWidgets = [];
                for (var messageServer in messages) {
                  final messageText = messageServer.data()['text'];
                  final messageSender = messageServer.data()['sender'];
                  final currentUser = loggedInUser.email;

                  if (currentUser == messageSender) {
                    isUser = true;
                  } else {
                    isUser = false;
                  }

                  final completeMessage = MessageBubble(
                      text: messageText,
                      sender: messageSender,
                      isCurrentUser: isUser);
                  messageWidgets.add(completeMessage);
                }
                return Expanded(
                  child: ListView(
                      reverse: true, // So that no message gets under the keyboard.
                      padding: EdgeInsets.symmetric(
                          horizontal: 10.0, vertical: 20.0),
                      children: messageWidgets),
                );
              },
            ),
            Container(
              decoration: kMessageContainerDecoration,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      controller: messageTextController,
                      onChanged: (value) {
                        messageText = value;
                      },
                      decoration: kMessageTextFieldDecoration,
                    ),
                  ),
                  FlatButton(
                    onPressed: () {
                      messageTextController.clear();
                      _firestore.collection('messages').add(
                          {'text': messageText, 'sender': loggedInUser.email});
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

class MessageBubble extends StatelessWidget {
  final String text;
  final String sender;
  final bool isCurrentUser;

  MessageBubble({
    this.text,
    this.sender,
    this.isCurrentUser,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment:
            isCurrentUser ? CrossAxisAlignment.start : CrossAxisAlignment.end,
        children: <Widget>[
          Text(
            sender,
            style: TextStyle(color: Colors.black54),
          ),
          SizedBox(
            height: 3.0,
          ),
          Material(
            color: isCurrentUser ? Colors.green[700] : Colors.lightBlueAccent,
            borderRadius: isCurrentUser
                ? BorderRadius.only(
                    topRight: Radius.circular(15.0),
                    bottomLeft: Radius.circular(15.0),
                    bottomRight: Radius.circular(15.0),
                  )
                : BorderRadius.only(
                    topLeft: Radius.circular(15.0),
                    bottomLeft: Radius.circular(15.0),
                    bottomRight: Radius.circular(15.0),
                  ),
            elevation: 4.0,
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
              child: Text(
                text,
                style: kMessageStyle,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
