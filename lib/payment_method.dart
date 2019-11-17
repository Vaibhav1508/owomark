import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:owomark/checkout_screen.dart';

import 'dashboard_screen.dart';

class PaymentMethod extends StatefulWidget {

  final int amount;

  PaymentMethod({Key key, this.amount}) : super(key: key);

  @override
  _PaymentMethodState createState() => _PaymentMethodState();
}

class _PaymentMethodState extends State<PaymentMethod> {
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
                onTap: (){

                },
                leading: CircleAvatar(
                  backgroundColor: Colors.blue,
                  child: Icon(
                    Icons.person_pin,
                    color: Colors.white,
                  ),
                  radius: 25,

                ),
                trailing: RaisedButton(
                  child: new Text(
                    'Checkout',
                    style:
                    new TextStyle(color: Colors.white, fontSize: 18),
                  ),
                  onPressed: () {
                    Fluttertoast.showToast(msg: "Cash on Delivery",toastLength: Toast.LENGTH_SHORT);
                    Navigator.push(context,MaterialPageRoute(
                        builder: (_)=>CheckoutScreen(amount: widget.amount,method: 0,)
                    ));
                  },
                  color: Colors.orange,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30)),
                ),
              ),
              ListTile(
                title: Text(
                  'no need of wallet balance',
                  style: TextStyle(fontSize: 18),
                ),
              ),
              Divider(),
              ListTile(
                title: Text(
                  'Pay from wallet',
                  style: TextStyle(fontSize: 20),
                ),
                onTap: (){
                },
                leading: CircleAvatar(
                  backgroundColor: Colors.blue,
                  child: Icon(
                    Icons.account_balance_wallet,
                    color: Colors.white,
                  ),
                  radius: 25,
                ),
                trailing: RaisedButton(
                  child: new Text(
                    'Checkout',
                    style:
                    new TextStyle(color: Colors.white, fontSize: 18),
                  ),
                  onPressed: () {
                    Fluttertoast.showToast(msg: "Pay from wallet",toastLength: Toast.LENGTH_SHORT);
                    Navigator.push(context,MaterialPageRoute(
                      builder: (_)=>CheckoutScreen(amount: widget.amount,method:1,)
                    ));
                  },
                  color: Colors.orange,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30)),
                ),
              ),
              ListTile(
                title: Text(
                  'your wallet balance',
                  style: TextStyle(fontSize: 18),
                ),
              ),

            ],
          ),
        ));
  }
}
