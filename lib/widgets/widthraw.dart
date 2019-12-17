import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:owomark/models/transaction_item.dart';
import 'package:owomark/models/widthrawItem.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../api_interface.dart';

class WidthrawScreen extends StatefulWidget {
  @override
  _WidthrawScreenState createState() => _WidthrawScreenState();
}

class _WidthrawScreenState extends State<WidthrawScreen> {
  ApiInterface apiInterface = new ApiInterface();

  //Category List
  List<WidthrawItem> trans = new List();

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: trans.length == 0
          ? Center(
              child: Text(
                "No widthrawal Found",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
              ),
            )
          : Container(
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
                  itemCount: trans.length,
                  itemBuilder: (BuildContext context, int index) {
                    final item = trans[index];

                    return GestureDetector(
                      child: Container(
                        // width: 300,
                        margin: EdgeInsets.only(top: 5.0, bottom: 5.0),
                        padding: EdgeInsets.symmetric(
                            horizontal: 10.0, vertical: 10.0),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border(
                                bottom: BorderSide(color: Colors.black12))),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                CircleAvatar(
                                  radius: 20.0,
                                  backgroundColor: Colors.green,
                                  child: Icon(
                                    Icons.attach_money,
                                    color: Colors.white,
                                    size: 25,
                                  ),
                                ),
                                SizedBox(
                                  width: 10.0,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      item.name,
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 15.0,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    SizedBox(
                                      height: 15.0,
                                    ),
                                    Container(
                                      width: MediaQuery.of(context).size.width *
                                          0.50,
                                      child: Text(
                                        'on ' + item.created,
                                        style: TextStyle(
                                          color: Colors.grey,
                                          fontSize: 15.0,
                                        ),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                            Column(
                              children: <Widget>[
                                Text(
                                        '- ' + item.amount + ' Rs.',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20.0,
                                        ),
                                      ),
                                SizedBox(
                                  height: 5.0,
                                ),
                               item.paid=="1" ? Text('Success',style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold,color: Colors.green),) : Text('Pending',style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold,color: Colors.red),)
                              ],
                            )
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
    getTransactions(context);
  }

  getTransactions(context) async {
    setState(() {});

    String user = '';

    final prefs = await SharedPreferences.getInstance();
     user = prefs.getString('user');
  

    Future<dynamic> response = apiInterface.getWidthrawal(user);

    response.then((action) async {
      print(action.toString());
      if (action != null) {
        Map data = jsonDecode(action.toString());
        if (data["status"] == "200") {
          List<dynamic> list = data['result'];
          for (int i = 0; i < list.length; i++) {
            WidthrawItem notificationItem = WidthrawItem.fromMap(list[i]);
            trans.add(notificationItem);
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
