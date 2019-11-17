import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:owomark/create_profile.dart';
import 'package:owomark/models/appcategory_model.dart';
import 'package:owomark/models/category_item.dart';
import 'package:owomark/subcategory.dart';
import 'package:owomark/subcategory.dart' as prefix0;


import 'api_interface.dart';
import 'chat_screen.dart';
import 'dashboard_screen.dart';

import 'package:owomark/widgets/subcategory_item.dart';

import 'models/subcategory_model.dart';

class Category extends StatefulWidget {

  final String panel_id;

  Category({Key key,this.panel_id}) : super(key: key);

  @override
  _CategoryState createState() => _CategoryState();
}

class _CategoryState extends State<Category> {

  ApiInterface apiInterface = new ApiInterface();

  //Category List
  List<CategoryItem> categoris = new List();

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
          'Category',
          style: TextStyle(color: Colors.black),
          //textAlign: TextAlign.center,
        ),
        elevation: 3.0,
      ),
      body: Column(
        children: <Widget>[
          //CategorySelector(),
      Expanded(
      child: Container(
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
            itemCount: categoris.length,
            itemBuilder: (BuildContext context, int index) {

              final item = categoris[index];

              return GestureDetector(
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => SubCategorys(cat_id : item.id,panel_id : widget.panel_id),
                  ),
                ),
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
                              radius: 20.0,
                              backgroundColor: Colors.blue,
                              child: Icon(Icons.arrow_forward_ios,
                                color: Colors.white,)
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
                                  fontSize: 14.0,
                                ),
                              ),
                              SizedBox(
                                height: 5.0,
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
    )
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    getCategory(context);
  }

  getCategory(context) async {
    setState(() {});

    Future<dynamic> response = apiInterface.getCategory(widget.panel_id);

    response.then((action) async {

       //print(action.toString());
      if (action != null) {
        Map data = jsonDecode(action.toString());
        if (data["status"] == "200") {
          List<dynamic> list = data['result'];
          for (int i = 0; i < list.length; i++) {
            CategoryItem notificationItem = CategoryItem.fromMap(list[i]);
            categoris.add(notificationItem);
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
