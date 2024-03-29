import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:owomark/models/project_item.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sweetalert/sweetalert.dart';

import 'api_interface.dart';

class MyProject extends StatefulWidget {
  @override
  _MyProjectState createState() => _MyProjectState();
}

class _MyProjectState extends State<MyProject> {
  ApiInterface apiInterface = new ApiInterface();
  String producturl = 'http://owomark.com/owomarkapp/images/project/';

  //Category List
  List<ProjectItem> books = new List();
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: books.length == 0 ? Center(child: Text('No Projects Yet...',style: TextStyle(fontSize: 16),),) :Container(
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
              itemCount: books.length,
              itemBuilder: (BuildContext context, int index) {
                final item = books[index];

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
                            Image.network(
                              producturl + item.imageUrl,
                              height: 50,
                              width: 50,
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
                                      fontSize: 17.0,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(
                                  height: 15.0,
                                ),
                                Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.50,
                                  child: Text(
                                    'Rent : ' + item.price,
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 18.0,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                        Row(
                          children: <Widget>[
                            IconButton(
                              icon: Icon(
                                Icons.restore_from_trash,
                                color: Colors.red,
                              ),
                              onPressed: () {
                                SweetAlert.show(context,
                                    title: "Are you sure ?",
                                    subtitle: "Your book will be deleted",
                                    style: SweetAlertStyle.confirm,
                                    showCancelButton: true,
                                    onPress: (bool isConfirm) {
                                  if (isConfirm) {
                                    books.clear();
                                    removeBooks(context, item.id);
                                    SweetAlert.show(context,
                                        style: SweetAlertStyle.success,
                                        title: "Deleted");
                                    return false;
                                  }
                                });
                              },
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
    getBooks(context);
  }

  getBooks(context) async {
    setState(() {});

    String users = '';

    final prefs = await SharedPreferences.getInstance();
     users = prefs.getString('user');
  

    Future<dynamic> response = apiInterface.getMyProjects(users);

    response.then((action) async {
      print(action.toString());
      if (action != null) {
        Map data = jsonDecode(action.toString());
        if (data["status"] == "200") {
          List<dynamic> list = data['result'];
          for (int i = 0; i < list.length; i++) {
            ProjectItem notificationItem = ProjectItem.fromMap(list[i]);
            books.add(notificationItem);
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

  //remove book

  removeBooks(context, String id) async {
    setState(() {});

    Future<dynamic> response = apiInterface.removeMyProject(id);

    response.then((action) async {
      print(action.toString());
      if (action != null) {
        Map data = jsonDecode(action.toString());
        if (data["status"] == "200") {
          getBooks(context);
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
