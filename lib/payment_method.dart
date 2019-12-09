import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:owomark/cart_screen.dart';
import 'package:owomark/checkout_screen.dart';
import 'package:owomark/models/payment_item.dart';
import 'package:owomark/wallet_screen.dart';

import 'api_interface.dart';

class PaymentMethod extends StatefulWidget {
  final int amount;
  final double weight;

  PaymentMethod({Key key, this.amount, this.weight}) : super(key: key);

  @override
  _PaymentMethodState createState() => _PaymentMethodState();
}

class _PaymentMethodState extends State<PaymentMethod> {
  int cod;
  int wallet;
  int method;
  int ctotal = 0;
  int wtotal = 0;
  int balance = 0;

  ApiInterface apiInterface = new ApiInterface();

  //Category List
  List<PaymentItem> payment = new List();

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
                      builder: (_) => CartScreen(),
                    ),
                  )),
          title: Text(
            'Payment Method',
            style: TextStyle(color: Colors.black),
            //textAlign: TextAlign.center,
          ),
          elevation: 3.0,
        ),
        body: Container(
          padding: EdgeInsets.all(10),
          child: ListView(
            children: <Widget>[
              ListTile(
                title: Text(
                  'Cash On Delivery',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                ),
                onTap: () {},
                leading: CircleAvatar(
                  backgroundColor: Colors.green,
                  child: Icon(
                    Icons.person_pin,
                    color: Colors.white,
                  ),
                  radius: 25,
                ),
                trailing: RaisedButton(
                  child: new Text(
                    'Checkout',
                    style: new TextStyle(color: Colors.white, fontSize: 18),
                  ),
                  onPressed: () {
                    Fluttertoast.showToast(
                        msg: "Cash on Delivery",
                        toastLength: Toast.LENGTH_SHORT);
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => CheckoutScreen(
                                  amount: ctotal,
                                  method: 0,
                                  method_charge: cod,
                                )));
                  },
                  color: Colors.orange,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30)),
                ),
              ),
              ListTile(
                title: Text(
                  'you have to pay',
                  style: TextStyle(fontSize: 18),
                ),
                trailing: Text(
                  ctotal.toString() + ' Rs',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
              Divider(),
              ListTile(
                title: Text(
                  'Pay from wallet',
                  style: TextStyle(fontSize: 20),
                ),
                onTap: () {},
                leading: CircleAvatar(
                  backgroundColor: Colors.green,
                  child: Icon(
                    Icons.account_balance_wallet,
                    color: Colors.white,
                  ),
                  radius: 25,
                ),
                trailing: balance < wtotal
                    ? RaisedButton(
                        child: new Text(
                          'Add Money',
                          style:
                              new TextStyle(color: Colors.white, fontSize: 18),
                        ),
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => WalletScreen()));
                        },
                        color: Colors.green,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30)),
                      )
                    : RaisedButton(
                        child: new Text(
                          'Checkout',
                          style:
                              new TextStyle(color: Colors.white, fontSize: 18),
                        ),
                        onPressed: () {
                          Fluttertoast.showToast(
                              msg: "Pay from wallet",
                              toastLength: Toast.LENGTH_SHORT);
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => CheckoutScreen(
                                        amount: wtotal,
                                        method: 1,
                                        method_charge: wallet,
                                      )));
                        },
                        color: Colors.orange,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30)),
                      ),
              ),
              ListTile(
                title: Text(
                  'you have to pay',
                  style: TextStyle(fontSize: 18),
                ),
                trailing: Text(
                  wtotal.toString() + ' Rs',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ));
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getPayment(context);
  }

  getPayment(context) async {
    setState(() {});

    Future<dynamic> response = apiInterface.getPayment(
        '1', widget.weight.toString(), widget.amount.toString());

    response.then((action) async {
      print(action.toString());
      if (action != null) {
        Map data = jsonDecode(action.toString());
        if (data["status"] == "200") {
          List<dynamic> list = data['result'];
          for (int i = 0; i < list.length; i++) {
            PaymentItem notificationItem = PaymentItem.fromMap(list[i]);
            payment.add(notificationItem);
          }
          setState(() {
            for (int i = 0; i < payment.length; i++) {
              int getcod = int.parse(payment[i].cod);
              int getwall = int.parse(payment[i].wallet);

              cod = getcod;
              wallet = getwall;

              int wbalance = int.parse(payment[i].balance);
              balance = wbalance + balance;

              ctotal = widget.amount + cod;
              wtotal = widget.amount + wallet;
            }
          });
        } else {
          print('error');
        }
      }
    }, onError: (value) {
      print(value);
    });
  }
}
