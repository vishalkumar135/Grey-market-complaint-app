import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gmcr_app/ComplaintList.dart';
import 'package:gmcr_app/chat/chat_screen.dart';
import 'package:gmcr_app/contect_us.dart';
import 'package:gmcr_app/user.dart';
import 'complainPage.dart';
import 'faq.dart';
import 'first_page.dart';
import 'package:gmcr_app/admin/adminchat.dart';

import 'help.dart';

final primaryColor = Colors.deepPurpleAccent[400];

class HomePage extends StatefulWidget {
  final User user;
  const HomePage({this.user, Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

class _HomePageState extends State<HomePage> {
  final green = Colors.green;
  final red = Colors.red;
  final cyan = Colors.cyan;
  final blue = Colors.blueAccent;

  String a = 'Complaint\nRegister';
  String b = 'ChatUs';
  String c = 'Complaint\nCheck';
  String d = 'ContactUs';

  final e = Icons.edit;
  final f = Icons.chat;
  final g = Icons.playlist_add_check;
  final h = Icons.contact_phone;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(elevation: 0,
        actions: <Widget>[
          IconButton(
            iconSize: 40,
            icon: Icon(
              Icons.help_outline,
              color: Colors.blue,
            ),
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => Help()));
            },
          ),
        ],
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(
            Icons.menu,
            color: Colors.black,
          ),
          onPressed: () => _scaffoldKey.currentState.openDrawer(),
        ),
      ),
      backgroundColor: Colors.white,
      key: _scaffoldKey,
      drawer: Drawer(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              DrawerHeader(
                  decoration: BoxDecoration(color: Colors.blue),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Container(
                        child: CircleAvatar(
                          backgroundColor: Colors.white,
                          child: Icon(
                            Icons.person,
                            color: Colors.blue,
                            size: 35,
                          ),
                        ),
                        width: 60,
                        height: 60,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        widget.user.name,
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        widget.user.email,
                        style: TextStyle(color: Colors.white, fontSize: 15),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                    ],
                  )),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(left: 5, right: 5,bottom: 10),
                    child: Container(
                        height: 50,
                        width: MediaQuery.of(context).size.width,
                        child: RaisedButton(
                          onPressed: () {
                            showDialog<void>(
                                context: (context),
                                builder: (BuildContext dialogContext) {
                                  return AlertDialog(
                                    title:  Text('About'),
                                    content: Text(
                                      'Our app helps the citizen to register their complaint about the international fraud call so that Government can take action on it',
                                      style: TextStyle(color: Colors.black),
                                    ),
                                  );
                                });
                          },
                          child: Text(
                            'About app',
                            style: TextStyle(fontSize: 20),
                          ),
                        )),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 5, right: 5,bottom: 10),
                    child: Container(
                        height: 50,
                        width: MediaQuery.of(context).size.width,
                        child: RaisedButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => FaQ()));
                          },
                          child: Text(
                            'FAQ',
                            style: TextStyle(fontSize: 20),
                          ),
                        )),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 5, right: 5),
                    child: Container(
                        height: 50,
                        width: MediaQuery.of(context).size.width,
                        child: RaisedButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Help()));
                          },
                          child: Text(
                            'How to Register',
                            style: TextStyle(fontSize: 20),
                          ),
                        )),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 5, right: 5, top: 10),
                    child: Container(
                        height: 50,
                        width: MediaQuery.of(context).size.width,
                        child: RaisedButton(
                          onPressed: () {
                            signOut(context);
                          },
                          child: Text(
                            'Log Out',
                            style: TextStyle(fontSize: 20),textAlign: TextAlign.start,
                          ),)),
                  ),
                ],
              ),
            ],
          )),
      body: Center(
          child: SafeArea(
            child: SingleChildScrollView(
              child: Container(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 20, right: 20,),
                        child: Container(
                          height: 170,
                          width: 250,
                          child: Image(image: AssetImage('images/logo1.jpg')),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(33),
                          ),
                        ),
                      ),
                      Text(
                        'Register Grey Market Complaints ',
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.black,),
                      ),
                  SizedBox(height: 30,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      getbutton(green, e, a, 1),
                      getbutton(red, f, b, 2)
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      getbutton(cyan, g, c, 3),
                      getbutton(blue, h, d, 4),
                    ],
                  ),
                ]),
          ),
        ),
      )),
    );
  }

  getbutton(color, icon, text, a) {
    return Container(
      height: 150,
      width: 150,
      child: RaisedButton(
        color: color,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        onPressed: () {
          geting(a);
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Icon(
              icon,
              size: 50,
              color: Colors.white,
            ),
            Text(
              text,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                  color: Colors.white),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  geting(int a) {
    String uid = widget.user.uid;
    String num = widget.user.number;
    String name = widget.user.name;
    String email = widget.user.email;
    final user = User(uid: uid, name: name, number: num, email: email);

    switch (a) {
      case 1:
        {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => ComplainPage(
                        user: user,
                      )));
        }
        break;
      case 2:
        {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => ChatScreen(
                        user: user,
                      )));
        }
        break;
      case 3:
        {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => ComplaintList(
                        user: user,
                      )));
        }
        break;
      case 4:
        {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => ContectUs()));
        }
        break;
      default:
    }
  }

  signOut(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => FirstPage()));
  }
}
