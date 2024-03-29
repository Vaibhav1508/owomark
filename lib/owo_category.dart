import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:owomark/models/category_item.dart';
import 'package:owomark/owo_subcategory.dart';

import 'api_interface.dart';
import 'dashboard_screen.dart';

class OwoCategory extends StatefulWidget {
  final String panel_id;

  OwoCategory({Key key, this.panel_id}) : super(key: key);

  @override
  _OwoCategoryState createState() => _OwoCategoryState();
}

class _OwoCategoryState extends State<OwoCategory> {
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
          'Owosell Category',
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
                            builder: (_) => OwoSubCategory(
                                cat_id: item.id, panel_id: widget.panel_id),
                          ),
                        ),
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
                                      backgroundColor: Colors.orange,
                                      child: Icon(
                                        Icons.adjust,
                                        color: Colors.white,
                                      )),
                                  SizedBox(
                                    width: 10.0,
                                  ),
                                  Container(
                                    width: MediaQuery.of(context).size.width *
                                        0.70,
                                    child: Text(
                                      item.name,
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 14.0,
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                    ),
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

    Future<dynamic> response = apiInterface.getOwoCategory('1');

    response.then((action) async {
      print(action.toString());
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
