import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:owomark/models/order_item.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../api_interface.dart';
import '../chat_screen.dart';

class OrderItem extends StatefulWidget {
  @override
  _OrderItemState createState() => _OrderItemState();
}

class _OrderItemState extends State<OrderItem> {
  List<OrderItems> orders = new List();

  ApiInterface apiInterface = new ApiInterface();

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: orders.length==0 ? Center(child: Text('No Orderes Yet...'),) :Container(
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
              itemCount: orders.length,
              itemBuilder: (BuildContext context, int index) {
                final item = orders[index];

                return GestureDetector(
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => ChatScreen(),
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
                              backgroundColor: Colors.green,
                              child: Icon(
                                Icons.shopping_basket,
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
                                  width:
                                      MediaQuery.of(context).size.width * 0.50,
                                  child: Text(
                                    'Placed On ' + item.time,
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
                            item.status == "1"
                                ? Container(
                                    width: 70.0,
                                    height: 30.0,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(30.0),
                                      color: Colors.green,
                                    ),
                                    alignment: Alignment.center,
                                    child: Text(
                                      'Delivered',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 12.0,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  )
                                : Container(
                                    width: 70.0,
                                    height: 30.0,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(30.0),
                                      color: Colors.orange,
                                    ),
                                    alignment: Alignment.center,
                                    child: Text(
                                      'Shipped',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 12.0,
                                          fontWeight: FontWeight.bold),
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
    getOrders(context);
  }

  getOrders(context) async {
    setState(() {});

    String users = '';

    final prefs = await SharedPreferences.getInstance();
     users = prefs.getString('user');
  

    Future<dynamic> response = apiInterface.getOrder(users);

    response.then((action) async {
      print(action.toString());
      if (action != null) {
        Map data = jsonDecode(action.toString());
        if (data["status"] == "200") {
          List<dynamic> list = data['result'];
          for (int i = 0; i < list.length; i++) {
            OrderItems notificationItem = OrderItems.fromMap(list[i]);
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
