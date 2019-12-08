import 'package:flutter/material.dart';
import 'package:owomark/inst_category.dart';
import 'package:owomark/models/category_item.dart';

import 'api_interface.dart';
import 'dashboard_screen.dart';

class TypeCategory extends StatefulWidget {
  final String panel_id;

  TypeCategory({Key key, this.panel_id}) : super(key: key);

  @override
  _TypeCategoryState createState() => _TypeCategoryState();
}

class _TypeCategoryState extends State<TypeCategory> {
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
          'Institute Type',
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
                  child: ListView(
                    children: <Widget>[
                      Container(
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
                                      Icons.play_circle_outline,
                                      color: Colors.white,
                                    )),
                                SizedBox(
                                  width: 10.0,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    GestureDetector(
                                      child: Text(
                                        'Play Institute',
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 20.0,
                                        ),
                                      ),
                                      onTap: () => Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (_) => InstCategory(
                                                    panel_id: '1',
                                                  ))),
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
                      Container(
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
                                    backgroundColor: Colors.orange,
                                    child: Icon(
                                      Icons.school,
                                      color: Colors.white,
                                    )),
                                SizedBox(
                                  width: 10.0,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    GestureDetector(
                                      child: Text(
                                        'Education Institute',
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 20.0,
                                        ),
                                      ),
                                      onTap: () => Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (_) => InstCategory(
                                                    panel_id: '0',
                                                  ))),
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
                    ],
                  ),
                )),
          )
        ],
      ),
    );
  }
}
