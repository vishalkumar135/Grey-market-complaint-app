//import 'package:cloud_firestore/cloud_firestore.dart';
//import 'package:flutter/material.dart';
//import 'package:gmcr_app/admin/adminchat.dart';
//
//import '../user.dart';
//
//class MessageList extends StatefulWidget {
//
//  @override
//  _MessageListState createState() => _MessageListState();
//}
//
//class _MessageListState extends State<MessageList> {
//  ScrollController scrollController = ScrollController();
//
//  @override
//  Widget build(BuildContext context) {
//    return Scaffold(
//      backgroundColor: Colors.white54,
//      appBar: AppBar(
//        backgroundColor: Colors.amber,
//        title: Text('Massage List'),
//        leading: IconButton(
//            icon: Icon(Icons.arrow_back),
//            onPressed: () {
//              Navigator.pop(context);
//            }),
//      ),
//      body: SingleChildScrollView(
//        child: Column(
//          children: <Widget>[
//            StreamBuilder<QuerySnapshot>(
//                stream: Firestore.instance
//                    .collection('Admin message')
//                    .orderBy('date',descending: true)
//                    .snapshots(),
//                builder: (context, snapshot) {
//                  if (snapshot.hasData) {
//                    return Stack(
//                      children: <Widget>[
//                        ListView.builder(
//                            scrollDirection: Axis.vertical,
//                            shrinkWrap: true,
//                            controller: scrollController,
//                            itemCount: snapshot.data.documents.length,
//                            itemBuilder: (context, index) {
//                              final uid = snapshot.data.documents[index].data['uid'];
////                              final name = snapshot.data.documents[index].data['date'];
//                              return GestureDetector(
//                                onTap: (){
//                                  print(uid);
//                                  final user = ID(uid: uid,);
//                                  Navigator.push(context, MaterialPageRoute(builder: (context)=>AdminChatScreen(user: user,)));
//                                },
//                                child: Card(
//                                  elevation: 5,
//                                  child: ListTile(
//                                    leading: Icon(
//                                      Icons.people,
//                                      color: Colors.blue,
//                                      size: 50,
//                                    ),
//                                    title: Text("uid"),
////                                  subtitle: Text('Date : $name'),
//                                  ),
//                                ),
//                              );
//                            }),
//                      ],
//                    );
//                  } else {
//                    return
//                      Container(
//                        child: Center(
//                          child: Text("You Don't Have Any Massages",
//                            style: TextStyle(color: Colors.white),
//                          ),
//                        ),
//                      );
//                  }
//                }),
//          ],
//        ),
//      ),
//    );
//  }
//}
//
