import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:owomark/models/institute_item.dart';
import 'package:rating_bar/rating_bar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sweetalert/sweetalert.dart';

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
                                  /* backgroundColor: Colors.green,
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
                                Container(
                                    width: MediaQuery.of(context).size.width *
                                        0.40,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Text(
                                          item.name,
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 18.0,
                                              fontWeight: FontWeight.bold),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        SizedBox(
                                          height: 7.0,
                                        ),
                                        Container(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.30,
                                            child: Column(
                                              children: <Widget>[
                                                Text(
                                                  item.location,
                                                  style: TextStyle(
                                                    fontSize: 18.0,
                                                  ),
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                                SizedBox(height: 5,),
                                                
                                                RatingBar.readOnly(
                      //onRatingChanged: (rating) => setState(()=>rating = rating),
                      filledIcon: Icons.star,
                      initialRating: double.parse(item.rate),
                      emptyIcon: Icons.star_border,
                      halfFilledIcon: Icons.star_half,
                      isHalfAllowed: false,
                      filledColor: Colors.orange,
                      emptyColor: Colors.orangeAccent,
                      halfFilledColor: Colors.orangeAccent,
                      size: 20,
                    ) 
                                              ],
                                            )),
                                      ],
                                    ))
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
                                        institutes.clear();
                                        removeInstitute(context, item.id);
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
    getInstitutes(context);
  }

  getInstitutes(context) async {
    setState(() {});

     String user = '';

    final prefs = await SharedPreferences.getInstance();
     user = prefs.getString('user');

    Future<dynamic> response = apiInterface.getInstituteByUser(user);

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

  //remove book

  removeInstitute(context, String id) async {
    setState(() {});

    Future<dynamic> response = apiInterface.removeInstitute(id);

    response.then((action) async {
      print(action.toString());
      if (action != null) {
        Map data = jsonDecode(action.toString());
        if (data["status"] == "200") {
          getInstitutes(context);
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
