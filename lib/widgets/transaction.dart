import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:owomark/models/order_model.dart';
import 'package:owomark/models/transaction_item.dart';
import 'package:owomark/models/transaction_model.dart';

import '../api_interface.dart';
import '../chat_screen.dart';

class Transaction extends StatefulWidget {
  @override
  _TransactionState createState() => _TransactionState();
}

class _TransactionState extends State<Transaction> {

  ApiInterface apiInterface = new ApiInterface();

  //Category List
  List<TransactionItem> trans = new List();


  @override
  Widget build(BuildContext context) {
    return Expanded(
      child:  trans.length == 0
          ? Center(
        child: Text(
          "No Transaction Found",
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
        ),
      ):Container(
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
                final TransactionItem item = trans[index];

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
                              radius: 20.0,
                              backgroundColor: Colors.blue,
                              child: Icon(
                                Icons.check_circle,
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
                                    'on '+item.created,
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
                            item.paid == "0" ? Text(
                              '+ ' + item.amount + ' Rs.',
                              style: TextStyle(
                                color: Colors.green,
                                fontWeight: FontWeight.bold,
                                fontSize: 16.0,
                              ),
                            ):
                            Text(
                              '- ' + item.amount + ' Rs.',
                              style: TextStyle(
                                color:Colors.red,
                                fontWeight: FontWeight.bold,
                                fontSize: 16.0,
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
    );
  }

  @override
  void initState() {
    super.initState();
    getTransactions(context);
  }

  getTransactions(context) async {
    setState(() {});

    Future<dynamic> response = apiInterface.getTransactions('1');

    response.then((action) async {

       print(action.toString());
      if (action != null) {
        Map data = jsonDecode(action.toString());
        if (data["status"] == "200") {
          List<dynamic> list = data['result'];
          for (int i = 0; i < list.length; i++) {
            TransactionItem notificationItem = TransactionItem.fromMap(list[i]);
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
