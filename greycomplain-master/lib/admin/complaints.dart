import 'package:flutter/material.dart';
import '../user.dart';
import 'adminchat.dart';

class Complaints extends StatefulWidget {
  final ID user;
  const Complaints({this.user ,Key key}) : super(key : key);
  @override
  _ComplaintsState createState() => _ComplaintsState();
}

class _ComplaintsState extends State<Complaints> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("id ${widget.user.id}"),
        actions: <Widget>[
          IconButton(
            iconSize: 40,
            icon: Icon(
              Icons.email,
              color: Colors.white,
            ),
            onPressed: () {
              String uid = widget.user.uid;
              String id = widget.user.id;
              final user = ID(uid: uid,id: id);
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => AdminChatScreen(
                        user: user,
                      )));
            },
          ),
        ],
      ),
    );
  }
}
