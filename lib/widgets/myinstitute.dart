import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:owomark/models/institute_item.dart';

import '../api_interface.dart';

class MyInstitute extends StatefulWidget {
  @override
  _MyInstituteState createState() => _MyInstituteState();
}

class _MyInstituteState extends State<MyInstitute> {
  ApiInterface apiInterface = new ApiInterface();

  //Category List
  List<InstituteItem> institutes = new List();

  String insturl = 'http://owomark.com/owomarkapp/images/classes/';

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: institutes.length == 0
          ? Center(
              child: Text(
                "No Institute Yet, Lets Add One",
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
                  itemCount: institutes.length,
                  itemBuilder: (BuildContext context, int index) {
                    final item = institutes[index];
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
                                  radius: 30.0,
                                  /* backgroundColor: Colors.blue,
                              child: Icon(
                                Icons.book,
                                color: Colors.white,
                                size: 25,

                              ),*/
                                  backgroundImage:
                                      NetworkImage(insturl + item.imageUrl),
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
                                          fontSize: 18.0,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    SizedBox(
                                      height: 15.0,
                                    ),
                                    Container(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.30,
                                        child: Column(
                                          children: <Widget>[
                                            Text(
                                              item.location,
                                              style: TextStyle(
                                                fontSize: 18.0,
                                              ),
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                            Text(
                                              "Active",
                                              style: TextStyle(
                                                color: Colors.green,
                                                fontSize: 18.0,
                                              ),
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ],
                                        )),
                                  ],
                                )
                              ],
                            ),
                            Row(
                              children: <Widget>[
                                Text(item.rate),
                                IconButton(
                                  icon: Icon(
                                    Icons.star,
                                    color: Colors.orange,
                                  ),
                                ),
                                IconButton(
                                  icon: Icon(
                                    Icons.restore_from_trash,
                                    color: Colors.red,
                                  ),
                                ),
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
    getInstitutes(context);
  }

  getInstitutes(context) async {
    setState(() {});

    Future<dynamic> response = apiInterface.getInstituteByUser('17');

    response.then((action) async {
      print(action.toString());
      if (action != null) {
        Map data = jsonDecode(action.toString());
        if (data["status"] == "200") {
          List<dynamic> list = data['result'];
          for (int i = 0; i < list.length; i++) {
            InstituteItem notificationItem = InstituteItem.fromMap(list[i]);
            institutes.add(notificationItem);
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
