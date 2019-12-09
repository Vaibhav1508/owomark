import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:owomark/api_interface.dart';
import 'package:owomark/dashboard_screen.dart';
import 'package:owomark/models/message_item.dart';

import 'chat_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  ApiInterface apiInterface = new ApiInterface();

  List<MessageItem> chat = new List();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
            icon: Icon(Icons.arrow_back),
            iconSize: 30.0,
            color: Colors.black,
            onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => DashboardScreen(),
                  ),
                )),
        title: Text(
          'Messages',
          style: TextStyle(color: Colors.black),
          //textAlign: TextAlign.center,
        ),
        elevation: 3.0,
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.search),
              iconSize: 30.0,
              color: Colors.grey,
              onPressed: () {}),
        ],
      ),
      body: Column(
        children: <Widget>[
          //CategorySelector(),
          Expanded(
            child: chat.length == 0
                ? Center(
                    child: Text(
                      "No Messages Yet",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
                    ),
                  )
                : Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(30.0),
                            topRight: Radius.circular(30.0))),
                    child: Column(
                      children: <Widget>[
                        Expanded(
                          child: Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 5.0, vertical: 0.0),
                              margin: EdgeInsets.only(
                                  top: 0.0, bottom: 0.0, right: 0.0),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(30.0),
                                      topRight: Radius.circular(30.0))),
                              child: ClipRRect(
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(30.0),
                                    topRight: Radius.circular(30.0)),
                                child: ListView.builder(
                                  itemCount: chat.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    final item = chat[index];

                                    return GestureDetector(
                                      onTap: () => Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (_) => ChatScreen(
                                            user: item.sender,
                                          ),
                                        ),
                                      ),
                                      child: Container(
                                        // width: 300,
                                        margin: EdgeInsets.only(
                                            top: 5.0, bottom: 5.0),
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 10.0, vertical: 10.0),
                                        decoration: BoxDecoration(
                                            color: item.status == "1"
                                                ? Colors.white
                                                : Colors.white,
                                            border: Border(
                                                bottom: BorderSide(
                                                    color: Colors.black12))),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            Row(
                                              children: <Widget>[
                                                CircleAvatar(
                                                  radius: 30.0,
                                                  backgroundColor: Colors.green,
                                                  child: Icon(
                                                    Icons.person_pin,
                                                    size: 35,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 10.0,
                                                ),
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: <Widget>[
                                                    Text(
                                                      'Customer ' + item.sender,
                                                      style: TextStyle(
                                                          color: Colors.black,
                                                          fontSize: 15.0,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                    SizedBox(
                                                      height: 5.0,
                                                    ),
                                                    Container(
                                                      width:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width *
                                                              0.39,
                                                      child: Text(
                                                        item.msg,
                                                        style: TextStyle(
                                                            color:
                                                                Colors.blueGrey,
                                                            fontSize: 15.0,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w600),
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                      ),
                                                    ),
                                                  ],
                                                )
                                              ],
                                            ),
                                            Column(
                                              children: <Widget>[
                                                Text(
                                                  item.time,
                                                  style: TextStyle(
                                                    color: Colors.grey,
                                                    fontSize: 15.0,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 5.0,
                                                ),
                                                item.status == "0"
                                                    ? Container(
                                                        width: 40.0,
                                                        height: 20.0,
                                                        decoration:
                                                            BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      30.0),
                                                          color: Colors.black,
                                                        ),
                                                        alignment:
                                                            Alignment.center,
                                                        child: Text(
                                                          'NEW',
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.white,
                                                              fontSize: 12.0,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        ),
                                                      )
                                                    : Text(''),
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              )),
                        )
                      ],
                    ),
                  ),
          ),
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    getEvents(context);
  }

  getEvents(context) async {
    setState(() {});

    Future<dynamic> response = apiInterface.getRecentChats('1');

    response.then((action) async {
      print(action.toString());
      if (action != null) {
        Map data = jsonDecode(action.toString());
        if (data["status"] == "200") {
          List<dynamic> list = data['result'];
          for (int i = 0; i < list.length; i++) {
            MessageItem notificationItem = MessageItem.fromMap(list[i]);
            chat.add(notificationItem);
          }
          setState(() {});
        } else {
          print('error');
        }
      }
    }, onError: (value) {
      print(value);
    });
  }
}
