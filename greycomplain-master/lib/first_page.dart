import 'package:flutter/material.dart';
import 'package:gmcr_app/admin/login_page.dart';
import 'package:gmcr_app/notifying.dart';
import 'package:gmcr_app/help.dart';
import 'package:gmcr_app/phone_auth.dart';

class FirstPage extends StatefulWidget {
  @override
  _FirstPageState createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: SafeArea(
          child: Scaffold(
            backgroundColor: Colors.white,
            body: SingleChildScrollView(
              child: Padding(
                padding:
                const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
                child: Builder(
                  builder: (context) =>
                      Column(children: <Widget>[
                        Align(
                          alignment: Alignment.topRight,
                          child: IconButton(
                            iconSize: 40,
                            icon: Icon(
                              Icons.notification_important,
                              color: Colors.black54,
                            ),
                            onPressed: () {
                              Navigator.push(context, MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      Notify()));
                            },
                          ),
                        ),
                        Center(
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  left: 20, right: 20, top: 20, bottom: 20),
                              child: Container(
                                height: 200,
                                width: 200,
                                child: Image(
                                    image: AssetImage('images/logo1.jpg')),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(33),
                                ),
                              ),
                            )),
                        Text(
                          'Department of Telecommunication',
                          style: TextStyle(
                              fontSize: 20,
                              color: Colors.black,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 20,),
                        Text(
                          'Gray Market Complaints Register',
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.black,
                          ),
                        ),
                        SizedBox(
                          height: 70,
                        ),
                        Container(
                            width: MediaQuery
                                .of(context)
                                .size
                                .width,
                            child: RaisedButton.icon(
                              elevation: 10,
                              splashColor: Colors.lightBlueAccent,
                              padding: EdgeInsets.symmetric(
                                  vertical: 15, horizontal: 10),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(50.0)),
                              color: Colors.lightBlueAccent,
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (BuildContext context) =>
                                            SignUp()));
                              },
                              icon: Icon(
                                Icons.person,
                                color: Colors.white,
                              ),
                              label: Text(
                                '    Register / Login ',
                                style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                            )),
                        SizedBox(
                          height: 30,
                        ),
                        Container(
                            width: MediaQuery
                                .of(context)
                                .size
                                .width,
                            child: FlatButton(
                              splashColor: Colors.grey,
                              padding: EdgeInsets.symmetric(
                                  vertical: 15, horizontal: 10),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(50.0)),
                              color: Colors.white,
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => LoginPage()));
                              },
                              child: Text(
                                ' Admin ',
                                style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.grey,
                                    fontWeight: FontWeight.bold),
                              ),
                            )),
                      ]),
                ),
              ),
            ),
          ),
        ));
  }
}
