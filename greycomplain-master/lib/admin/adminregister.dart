import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gmcr_app/admin/authPage.dart';
import 'package:gmcr_app/admin/dashboard.dart';
import 'package:gmcr_app/user.dart';

import '../first_page.dart';

final primaryColor = Colors.deepPurpleAccent[400];

class Adminregister extends StatefulWidget {
  final Admin user;
  const Adminregister({this.user , Key key}) : super(key : key);

  @override
  _AdminregisterState createState() => _AdminregisterState();
}

class _AdminregisterState extends State<Adminregister> {
  String phoneCodeSent, verificationID;
  final _formKey = GlobalKey<FormState>();
  final _name = TextEditingController();
  final _number = TextEditingController();
  final _email = TextEditingController();
  bool circuler = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      body: circuler ? Container(
        child: Center(
          child: CircularProgressIndicator(),
        ),
      ) : SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 40,
              ),
              Container(
                width: MediaQuery
                    .of(context)
                    .size
                    .width,
                height: 75,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      IconButton(
                        color: Colors.lightBlueAccent,
                        iconSize: 40,
                        icon: Icon(Icons.arrow_back),
                        onPressed: () => signOut(context),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 5),
                        child: CircleAvatar(
                          backgroundColor: Colors.lightBlueAccent,
                          radius: 35,
                          child: Icon(
                            Icons.person,
                            size: 35,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              Padding(
                padding:
                const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                child: Column(children: <Widget>[
                  Center(
                    child: Container(

                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(
                          Radius.circular(5),
                        ),
                        color: Colors.white,
                      ),
                      width: MediaQuery.of(context).size.width,
                      height: 60,
                      child: Row(
                        children: <Widget>[
                          SizedBox(
                            width: 10,
                          ),
                          Icon(
                            Icons.email,
                            color: Colors.grey,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            widget.user.email,
                            style:
                            TextStyle(fontSize: 20,),
                            textAlign: TextAlign.center,
                          )
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    keyboardType: TextInputType.text,
                    style: TextStyle(
                      fontSize: 20,
                    ),
                    decoration: InputDecoration(
                        prefixIcon: Icon(Icons.person),
                        filled: true,
                        fillColor: Colors.white,
                        labelText: 'Full Name',
                        errorStyle: TextStyle(
                            fontSize: 20,
                            color: Colors.red,
                            fontWeight: FontWeight.bold)),
                    validator: (value) {
                      if (!value.isNotEmpty) {
                        return 'Enter Your Name ';
                      } else {
                        return null;
                      }
                    },
                    controller: _name,
                  ),
                  SizedBox(height: 20),
                  TextFormField(
                    maxLength: 10,
                    keyboardType: TextInputType.phone,
                    style: TextStyle(
                      fontSize: 20,
                    ),
                    decoration: InputDecoration(
                        prefixIcon: Icon(Icons.phone),
                        prefixText: '+91 ',
                        filled: true,
                        fillColor: Colors.white,
                        labelText: 'Mobile Number',
                        errorStyle: TextStyle(
                            fontSize: 20,
                            color: Colors.red,
                            fontWeight: FontWeight.bold)),
                    validator: (value) {
                      if (value.length != 10) {
                        return 'Enter Valid Mobile Number';
                      } else {
                        return null;
                      }
                    },
                    controller: _number,
                  ),
                  SizedBox(
                    height: 20,
                  ),

                  SizedBox(
                    height: 30,
                  ),
                  Container(
                    width: MediaQuery
                        .of(context)
                        .size
                        .width,
                    child: RaisedButton(
                      focusElevation: 10,
                      elevation: 10,
                      splashColor: Colors.lightBlueAccent,
                      padding:
                      EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5.0)),
                      child: Text(
                        'Submit',
                        style: TextStyle(fontSize: 20, color: Colors.white),
                      ),
                      color: Colors.lightBlueAccent,
                      onPressed: () {
                        setState(() {
                          if (_formKey.currentState.validate()) {
                            setState(() {
                              circuler = true;
                            });
                            String uid = widget.user.uid;
                            String num = _number.text;
                            String name = _name.text;
                            String email = widget.user.email;
                            final user = AdminUser(
                                uid: uid,
                                name: name,
                                number: num,
                                email: email);

                            Firestore.instance
                                .collection("Admin")
                                .document(widget.user.uid)
                                .setData({
                              'uid': widget.user.uid,
                              'Name': _name.text,
                              'email': widget.user.email,
                              'Number': _number.text,
                            }).then((value) => {
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          Deshboard(
                                            user: user,
                                          ))),
                            });
                          }
                        });
                      },
                    ),
                  ),
                ]),
              ),
            ],
          ),
        ),
      ),
    );
  }
  signOut(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => FirstPage()));
  }

}