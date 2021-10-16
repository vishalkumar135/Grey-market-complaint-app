import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gmcr_app/admin/adminchat.dart';
import 'package:gmcr_app/admin/chat_list.dart';
import 'package:gmcr_app/admin/complaints.dart';
import 'package:gmcr_app/user.dart';

import '../faq.dart';
import '../first_page.dart';
import '../help.dart';

class Deshboard extends StatefulWidget {
  final AdminUser user;
  const Deshboard({this.user, Key key}) : super(key: key);
  @override
  _DeshboardState createState() => _DeshboardState();
}

final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

class _DeshboardState extends State<Deshboard> {
  ScrollController scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text(
            'Complaints Deshboard',
            style: TextStyle(fontSize: 20, color: Colors.black),
          ),
          backgroundColor: Colors.white,
          leading: IconButton(
            icon: Icon(
              Icons.menu,
              color: Colors.black,
            ),
            onPressed: () => _scaffoldKey.currentState.openDrawer(),
          ),
        ),
        backgroundColor: Colors.blueGrey,
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
                      height: 15,
                    ),
                    Text(
                      widget.user.number,
                      style: TextStyle(color: Colors.white, fontSize: 25),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                  ],
                )),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(left: 5, right: 5, bottom: 10),
                  child: Container(
                      height: 50,
                      width: MediaQuery.of(context).size.width,
                      child: RaisedButton(
                        onPressed: () {
                          showDialog<void>(
                              context: (context),
                              builder: (BuildContext dialogContext) {
                                return AlertDialog(
                                  title: Text('About app'),
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
                  padding: const EdgeInsets.only(left: 5, right: 5, bottom: 10),
                  child: Container(
                      height: 50,
                      width: MediaQuery.of(context).size.width,
                      child: RaisedButton(
                        onPressed: () {
                          geting(2);
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
                          geting(3);
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
                          style: TextStyle(fontSize: 20),
                          textAlign: TextAlign.start,
                        ),
                      )),
                ),
              ],
            ),
          ],
        )),
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              StreamBuilder<QuerySnapshot>(
                  stream: Firestore.instance
                      .collection('Complaints List')
                      .orderBy('date', descending: true)
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return Stack(
                        children: <Widget>[
                          ListView.builder(
                              scrollDirection: Axis.vertical,
                              shrinkWrap: true,
                              controller: scrollController,
                              itemCount: snapshot.data.documents.length,
                              itemBuilder: (context, index) {
                                final id =
                                    snapshot.data.documents[index].data['id'];
                                final name =
                                    snapshot.data.documents[index].data['date'];
                                final uid =
                                    snapshot.data.documents[index].data['uid'];
                                return GestureDetector(
                                  onTap: () {
                                    final user = ID(id: id , uid: uid);
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                Complaints(user: user,)));
                                  },
                                  child: Card(
                                    elevation: 5,
                                    child: ListTile(
                                      leading: Icon(
                                        Icons.edit_attributes,
                                        color: Colors.green,
                                        size: 50,
                                      ),
                                      title: Text('Complaint Id : $id'),
                                      subtitle: Text('Date : $name'),
                                    ),
                                  ),
                                );
                              }),
                        ],
                      );
                    } else {
                      return Container(
                        child: Center(
                          child: Text(
                            "You Don't Have Any Complaints",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      );
                    }
                  }),
            ],
          ),
        ),
      ),
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
    final user = AdminUser(uid: uid, name: name, number: num, email: email);

    switch (a) {
//      case 1:
//        {
//          Navigator.push(
//              context,
//              MaterialPageRoute(
//                  builder: (context) => MessageList()));
//        }
//        break;
      case 2:
        {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => FaQ()));
        }
        break;
      case 3:
        {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => Help()));
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
