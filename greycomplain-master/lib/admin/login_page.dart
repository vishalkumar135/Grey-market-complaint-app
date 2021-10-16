import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gmcr_app/admin/authPage.dart';

import '../user.dart';
import 'adminregister.dart';
import 'dashboard.dart';

final primaryColor = Colors.deepPurpleAccent[400];

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();

  final _email = TextEditingController();

  final _password = TextEditingController();

  bool _showPassword = false;
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
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: 50,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: 75,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        IconButton(
                          color: Colors.lightBlueAccent,
                          iconSize: 40,
                          icon: Icon(Icons.arrow_back),
                          onPressed: () => Navigator.pop(context),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 15),
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
                  SizedBox(
                    height: 50,
                  ),
                  Column(
                    children: <Widget>[
                      TextFormField(
                        keyboardType: TextInputType.emailAddress,
                        style: TextStyle(
                          fontSize: 20,
                        ),
                        decoration: InputDecoration(
                            prefixIcon: Icon(Icons.email),
                            filled: true,
                            fillColor: Colors.white,
                            labelText: 'Email Address',
                            errorStyle:
                                TextStyle(fontSize: 20, color: Colors.red)),
                        validator: (email) {
                          if (!EmailValidator.validate(email)) {
                            return 'Enter Valid Email Address';
                          } else {
                            return null;
                          }
                        },
                        controller: _email,
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
                            suffixIcon: GestureDetector(
                              child: Icon(
                                _showPassword
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                              ),
                              onTap: () {
                                setState(() {
                                  _showPassword = !_showPassword;
                                });
                              },
                            ),
                            prefixIcon: Icon(Icons.lock),
                            filled: true,
                            fillColor: Colors.white,
                            labelText: 'Password',
                            errorStyle:
                                TextStyle(fontSize: 20, color: Colors.red)),
                        obscureText: !_showPassword,
                        validator: (value) {
                          if (value.length <= 6) {
                            return 'Enter Valid Password ';
                          } else {
                            return null;
                          }
                        },
                        controller: _password,
                      ),
                      SizedBox(
                        height: 50,
                      ),
                      Container(
                          width: MediaQuery.of(context).size.width,
                          child: RaisedButton(
                              focusElevation: 10,
                              elevation: 10,
                              splashColor: Colors.lightBlueAccent,
                              padding: EdgeInsets.symmetric(
                                  vertical: 15, horizontal: 10),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5.0)),
                              child: Text(
                                'LOGIN',
                                style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                              color: Colors.lightBlueAccent,
                              onPressed: () {
                                if (_formKey.currentState.validate()) {
                                  setState(() {
                                    circuler = true;
                                  });
                                  signIn(_email.text , _password.text, context);
                                }
                              })),
                    ],
                  )
                ],
              ),
            )),
      ),
    );
  }

  signIn(_email, _password, BuildContext context) async {
    String email = _email.toString();
    String password = _password.toString();
    try {
      FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password)
          .then((currentadmin) {
        if (currentadmin != null) {
          Firestore.instance
              .collection("Admin")
              .document(currentadmin.user.uid)
              .setData({
            "role": "Admin",
          }).then((value) {
            if (currentadmin.user.uid != null) {
              Firestore.instance
                  .collection('Admin')
                  .document(currentadmin.user.uid)
                  .snapshots()
                  .listen((event) {
                try {
                  final adminemail = currentadmin.user.email;
                  final adminuid = currentadmin.user.uid;
                  String number = event.data['number'];
                  if (number != null) {
                    String name = event.data['Name'];
                    final userdetail = AdminUser(
                        uid: adminuid,
                        name: name,
                        number: number,
                        email: adminemail);
                    print(" ye v chal rha hai");
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Deshboard(
                              user: userdetail,
                            )));
                  } else {
                    final adminemail = currentadmin.user.email;
                    final adminuid = currentadmin.user.uid;
                    final user = Admin(email: adminemail, uid: adminuid);
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Adminregister(
                              user: user,
                            )));
                  }
                } catch (e) {
                  final adminemail = currentadmin.user.email;
                  final adminuid = currentadmin.user.uid;
                  final user = Admin(email: adminemail, uid: adminuid);
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => Adminregister(
                            user: user,
                          )));
                }
              });
            }
          });
        }
      }).catchError((onError) {
        handleError(onError, context);
      });
    } catch (e) {
      print("object");
    }
  }
  handleError(error, context) {
    setState(() {
      circuler = false;
    });
    switch (error.code) {
      case 'ERROR_TOO_MANY_REQUESTS':
        {
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  content: Text('To many attempts try again later!!!'),
                );
              });
        }
        break;
      case 'ERROR_EMAIL_ALREADY_IN_USE':
        {
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  content: Text('Email id already exist!!!'),
                );
              });
        }
        break;
      case 'ERROR_USER_NOT_FOUND':
        {
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  content: Text('User not found!!!'),
                );
              });
        }
        break;
      case 'ERROR_WRONG_PASSWORD':
        {
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  content: Text('Wrong password!!!'),
                );
              });
        }
        break;
      default:
    }
  }

}
