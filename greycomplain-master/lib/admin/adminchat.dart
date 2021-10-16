import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gmcr_app/register_page.dart';
import '../user.dart';

class AdminChatScreen extends StatefulWidget {
  final ID user;
  const AdminChatScreen({this.user, Key key}) : super(key: key);
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<AdminChatScreen> {
  var user = FirebaseAuth.instance.currentUser();

  final messageText = TextEditingController();
  ScrollController scrollController = ScrollController();

  Future<void> add(message) async {
    Firestore.instance
        .collection('Admin message')
        .document(widget.user.uid)
        .collection('admin message')
        .add({
      'uid' : widget.user.uid,
      'sender': 'admin',
      'messages': message,
      'date': DateTime.now().toIso8601String().toString(),
    }).then((value) {
      Firestore.instance
          .collection('users')
          .document(widget.user.uid)
          .collection('user message')
          .add({
        'uid' : widget.user.uid,
        'sender': 'admin',
        'messages': message,
        'date': DateTime.now().toIso8601String().toString(),
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Admin Chat Box'),
      ),
      backgroundColor: Colors.blue,
      body: SafeArea(
        child: Container(
            child: Stack(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(bottom: 70),
              child: StreamBuilder<QuerySnapshot>(
                  stream: Firestore.instance
                      .collection('Admin message')
                      .document(widget.user.uid)
                      .collection('admin message')
                      .orderBy('date', descending: true)
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) return Container();
                    return ListView.builder(
                        reverse: true,
                        controller: scrollController,
                        itemCount: snapshot.data.documents.length,
                        itemBuilder: (context, index) {
                          return MessageTile(
                            messages:
                                snapshot.data.documents[index].data['messages'],
                            byMe:
                                snapshot.data.documents[index].data['sender'] ==
                                    'admin',
                          );
                        });
                  }),
            ),
            Container(
              alignment: Alignment.bottomCenter,
              width: MediaQuery.of(context).size.width,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 7, vertical: 10),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: TextField(
                        style: TextStyle(fontSize: 15),
                        controller: messageText,
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            filled: true,
                            fillColor: Colors.white,
                            enabledBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(50)),
                              borderSide: BorderSide(
                                  color: Colors.white,
                                  width: 0,
                                  style: BorderStyle.none),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(50)),
                              borderSide: BorderSide(
                                  color: Colors.white,
                                  width: 0,
                                  style: BorderStyle.none),
                            ),
                            hintText: 'Type Your Message....',
                            hintStyle: TextStyle(fontSize: 15)),
                      ),
                    ),
                    SizedBox(
                      width: 7,
                    ),
                    CircleAvatar(
                      backgroundColor: primaryColor,
                      radius: 30,
                      child: IconButton(
                          icon: Icon(
                            Icons.send,
                            color: Colors.white,
                            size: 30,
                          ),
                          onPressed: () {
                            if (messageText.text.isNotEmpty) {
                              add(messageText.text);
                              messageText.clear();
                            }
                          }),
                    )
                  ],
                ),
              ),
            )
          ],
        )),
      ),
    );
  }
}

// ignore: must_be_immutable
class MessageTile extends StatelessWidget {
  String messages;
  bool byMe;
  MessageTile({@required this.messages, @required this.byMe});

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.only(
            top: 8, bottom: 8, left: byMe ? 0 : 10, right: byMe ? 10 : 0),
        alignment: byMe ? Alignment.centerRight : Alignment.centerLeft,
        child: Container(
          margin: byMe ? EdgeInsets.only(left: 50) : EdgeInsets.only(right: 50),
          padding: EdgeInsets.only(top: 10, bottom: 10, left: 10, right: 10),
          decoration: BoxDecoration(
            borderRadius: byMe
                ? BorderRadius.only(
                    topLeft: Radius.circular(25),
                    topRight: Radius.circular(25),
                    bottomLeft: Radius.circular(25))
                : BorderRadius.only(
                    topLeft: Radius.circular(25),
                    topRight: Radius.circular(25),
                    bottomRight: Radius.circular(25)),
            color: byMe ? primaryColor : Colors.cyan,
          ),
          child: getmessage(messages),
        ));
  }

  getmessage(message) {
    return Text(messages,
        textAlign: TextAlign.start,
        style: TextStyle(fontSize: 16, color: Colors.white));
  }
}
