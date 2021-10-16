import 'package:flutter/material.dart';
import 'package:gmcr_app/phone_auth.dart';

import 'help.dart';

class Notify extends StatefulWidget {
  @override
  _NotifyState createState() => _NotifyState();
}

class _NotifyState extends State<Notify> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: SafeArea(
          child: Scaffold(
            backgroundColor: Colors.blueGrey,
            body: SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 20),
                child: Container(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  child: Card(
                    child: Column(
                      children: <Widget>[
                        SizedBox(
                          height: 30,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(
                                'About app ',
                                style: TextStyle(
                                  fontSize: 25,
                                ),
                              ),
                              IconButton(
                                  color: Colors.blue,
                                  icon: Icon(
                                    Icons.help_outline,
                                    size: 25,
                                  ),
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => Help()));
                                  })
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Text(
                            'It is under the control of Department of DOT',
                            style: TextStyle(color: Colors.black, fontSize: 15),
                          ),
                        ),
                        Center(
                            child: Padding(
                          padding: const EdgeInsets.only(
                              left: 20, right: 20, top: 20, bottom: 20),
                          child: Container(
                            height: 200,
                            width: 200,
                            child: Image(image: AssetImage('images/logo1.jpg')),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(33),
                            ),
                          ),
                        )),
                        SizedBox(
                          height: 10,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Text(
                            'This app helps the citizen to register their grey market complaints about the international fraud call so that government can take action on it.\nFor complaint first register with mobile number.',
                            style: TextStyle(color: Colors.black, fontSize: 17),
                          ),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        IconButton(iconSize: 50,
                          icon: Icon(
                            Icons.close,
                          ),
                          onPressed: () => Navigator.pop(context),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ));
  }
}
