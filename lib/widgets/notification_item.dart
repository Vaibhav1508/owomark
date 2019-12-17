import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:owomark/api_interface.dart';
import 'package:owomark/models/NotificationItem.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NotificationItem extends StatefulWidget {
  @override
  _NotificationItemState createState() => _NotificationItemState();
}

class _NotificationItemState extends State<NotificationItem> {

  ApiInterface apiInterface = new ApiInterface();

  List<NotificationItems> notification = new List<NotificationItems>();

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: notification.length==0 ? Center(child: Text('No Notifications Yet...'),)  : Container(
          padding: EdgeInsets.symmetric(horizontal: 5.0, vertical: 0.0),
          margin: EdgeInsets.only(top: 0.0, bottom: 0.0, right: 0.0),
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
              itemCount: notification.length,
              itemBuilder: (BuildContext context, int index) {
                final item = notification[index];

                return GestureDetector(

                  child: Container(
                    // width: 300,
                    margin: EdgeInsets.only(top: 5.0, bottom: 5.0),
                    padding:
                    EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        border:
                        Border(bottom: BorderSide(color: Colors.black12))),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            CircleAvatar(
                              radius: 25,
                              backgroundColor: Colors.green,
                              child: Icon(Icons.notifications,color: Colors.white,),
                            ),
                            SizedBox(
                              width: 10.0,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  item.title,
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16.0,),
                                ),
                                SizedBox(
                                  height: 10.0,
                                ),
                                Container(

                                  child:
                                    Text(
                                      item.msg,
                                      style: TextStyle(
                                        fontSize: 14.0,
                                      ),
                                    ),

                                ),
                                SizedBox(height: 10,),
                                Container(

                                  child:
                                    Text(
                                      item.time,
                                      style: TextStyle(
                                        color: Colors.grey,
                                        fontSize: 14.0,
                                      ),
                                    ),

                                ),

                              ],
                            )
                          ],
                        ),

                      ],
                    ),
                  ),
                );
              },
            ),
          )),
    );
  }

  @override
  void initState() {
    super.initState();
    getNewsFeed(context);
  }

  getNewsFeed(context) async {
    setState(() {});

    String users = '';

    final prefs = await SharedPreferences.getInstance();
     users = prefs.getString('user');
  

    Future<dynamic> response = apiInterface.getNews(users);

    response.then((action) async {
      print(action.toString());
      if (action != null) {
        Map data = jsonDecode(action.toString());
        if (data["status"] == "200") {
          List<dynamic> list = data['result'];
          for (int i = 0; i < list.length; i++) {
            NotificationItems notificationItem = NotificationItems.fromMap(list[i]);
            notification.add(notificationItem);
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
