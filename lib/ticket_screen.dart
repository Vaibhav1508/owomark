import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'api_interface.dart';
import 'dashboard_screen.dart';
import 'models/ticket_item.dart';

class TicketScreen extends StatefulWidget {
  @override
  _TicketScreenState createState() => _TicketScreenState();
}

class _TicketScreenState extends State<TicketScreen> {
  List<TicketItem> orders = new List();

  ApiInterface apiInterface = new ApiInterface();

  String producturl = 'http://owomark.com/owomarkapp/images/events/';

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
          'Your Tickets',
          style: TextStyle(color: Colors.black),
          //textAlign: TextAlign.center,
        ),
        elevation: 3.0,
      ),
      body: Column(
        children: <Widget>[
          //CategorySelector(),
          Expanded(
            child: orders.length==0 ? Center(child: Text('No Tickets Yet...'),) : Container(
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
                        margin:
                            EdgeInsets.only(top: 0.0, bottom: 0.0, right: 0.0),
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
                            itemCount: orders.length,
                            itemBuilder: (BuildContext context, int index) {
                              final item = orders[index];

                              return GestureDetector(
                                onTap: () {
                                  showDialog<void>(
                                    context: context,
                                    barrierDismissible:
                                        true, // false = user must tap button, true = tap outside dialog
                                    builder: (BuildContext dialogContext) {
                                      return AlertDialog(
                                        title:
                                            Text('TicketID : ' + item.ticket),
                                        content: Text('Event : ' +
                                            item.name +
                                            '\nLocation : ' +
                                            item.location +
                                            '\nTime : ' +
                                            item.timing),
                                        actions: <Widget>[
                                          RaisedButton(
                                            child: Text(
                                              'Ok',
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ),
                                            onPressed: () {
                                              Navigator.of(dialogContext)
                                                  .pop(); // Dismiss alert dialog
                                            },
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                },
                                child: Container(
                                  // width: 300,
                                  margin:
                                      EdgeInsets.only(top: 5.0, bottom: 5.0),

                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      border: Border(
                                          bottom: BorderSide(
                                              color: Colors.black12))),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Row(
                                        children: <Widget>[
                                          Image.network(
                                            producturl + item.imageUrl,
                                            height: 70,
                                            width: 70,
                                          ),
                                          SizedBox(
                                            width: 10.0,
                                          ),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: <Widget>[
                                              Text(
                                                item.name,
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 15.0,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              SizedBox(
                                                height: 15.0,
                                              ),
                                              Container(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.50,
                                                child: Text(
                                                  'On ' + item.timing,
                                                  style: TextStyle(
                                                    color: Colors.grey,
                                                    fontSize: 15.0,
                                                  ),
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                      Column(
                                        children: <Widget>[
                                          Text(
                                            '- ' + item.price + ' Rs.',
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 18.0,
                                            ),
                                          ),
                                          SizedBox(
                                            height: 5.0,
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

    getTickets(context);
  }

  getTickets(context) async {
    setState(() {});

     String user = '';

    final prefs = await SharedPreferences.getInstance();
     user = prefs.getString('user');


    Future<dynamic> response = apiInterface.getTickets(user);

    response.then((action) async {
      print(action.toString());
      if (action != null) {
        Map data = jsonDecode(action.toString());
        if (data["status"] == "200") {
          List<dynamic> list = data['result'];
          for (int i = 0; i < list.length; i++) {
            TicketItem notificationItem = TicketItem.fromMap(list[i]);
            orders.add(notificationItem);
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
