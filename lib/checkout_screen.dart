import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:owomark/models/users_item.dart';
import 'package:owomark/payment_method.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sweetalert/sweetalert.dart';

import 'api_interface.dart';
import 'orders_screen.dart';

class CheckoutScreen extends StatefulWidget {
  final int amount;
  final int method;
  final int method_charge;

  CheckoutScreen({Key key, this.amount, this.method, this.method_charge})
      : super(key: key);

  @override
  _CheckoutScreenState createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  ApiInterface apiInterface = new ApiInterface();

  //Event List
  List<UsersItem> user = new List();

  TextFormField city;
  TextFormField date;
  TextFormField name;
  TextFormField email;
  TextFormField mobile;
  TextFormField address;

  int total;

  final _city = TextEditingController();
  final _name = TextEditingController();
  final _email = TextEditingController();
  final _date = TextEditingController();
  final _mobile = TextEditingController();
  final _address = TextEditingController();

  @override
  Widget build(BuildContext context) {
    name = TextFormField(
        enabled: false,
        keyboardType: TextInputType.text,
        controller: _name, // Use email input type for emails.
        decoration: new InputDecoration(
          hintText: 'Full Name',
          labelText: 'Enter Your Name',
          icon: new Icon(Icons.person),
        ));
    city = TextFormField(
        keyboardType: TextInputType.text,
        enabled: false,
        controller: _city, // Use email input type for emails.
        decoration: new InputDecoration(
          labelText: 'City',
          hintText: 'Your City',
          icon: new Icon(Icons.pin_drop),
        ));

    email = TextFormField(
        controller: _email,
        enabled: false,
        keyboardType: TextInputType.text, // Use email input type for emails.
        decoration: new InputDecoration(
          labelText: 'Email',
          hintText: 'Enter Your Email',
          icon: new Icon(Icons.email),
        ));

    mobile = TextFormField(
        controller: _mobile,
        enabled: false,
        keyboardType: TextInputType.text, // Use email input type for emails.
        decoration: new InputDecoration(
          labelText: 'Mobile',
          hintText: 'Enter Your Mobile',
          icon: new Icon(Icons.phone),
        ));

    address = TextFormField(
        controller: _address,
        maxLines: 2,
        keyboardType: TextInputType.text, // Use email input type for emails.
        decoration: new InputDecoration(
          labelText: 'Address',
          hintText: 'Enter Your Address',
          icon: new Icon(Icons.home),
        ));

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
                      builder: (_) => PaymentMethod(
                        amount: widget.amount,
                      ),
                    ),
                  )),
          title: Text(
            'Checkout',
            style: TextStyle(color: Colors.black),
            //textAlign: TextAlign.center,
          ),
          elevation: 3.0,
        ),
        body: Container(
            height: double.infinity,
            padding: EdgeInsets.all(10),
            child: Card(
              color: Colors.white,
              child: ListView(
                padding: EdgeInsets.all(5),
                children: <Widget>[
                  ListTile(
                    title: Text(
                      'Cost Details',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Divider(),
                  ListTile(
                    title: Text(
                      'Order Total',
                      style: TextStyle(fontSize: 18),
                    ),
                    trailing: Text(
                      widget.amount.toString() + ' Rs',
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                  Divider(),
                  ListTile(
                    title: Text(
                      'Method Charge',
                      style: TextStyle(fontSize: 18),
                    ),
                    trailing: Text(
                      widget.method_charge.toString() + ' Rs',
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                  Divider(),
                  ListTile(
                    title: Text(
                      'Total Fees',
                      style: TextStyle(fontSize: 18),
                    ),
                    trailing: Text(
                      total.toString() + ' Rs',
                      style: TextStyle(fontSize: 20, color: Colors.orange),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Divider(),
                  SizedBox(
                    height: 5,
                  ),
                  ListTile(
                    title: Column(
                      children: <Widget>[
                        CircleAvatar(
                          backgroundColor: Colors.green,
                          child: Icon(Icons.person_outline),
                          radius: 25,
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          'Buyer Profile',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  city,
                  SizedBox(
                    height: 5,
                  ),
                  name,
                  SizedBox(
                    height: 5,
                  ),
                  email,
                  SizedBox(
                    height: 5,
                  ),
                  mobile,
                  SizedBox(
                    height: 5,
                  ),
                  address,
                  SizedBox(
                    height: 10,
                  ),
                  RaisedButton(
                    child: new Text(
                      'Proceed To Checkout',
                      style: new TextStyle(color: Colors.white, fontSize: 18),
                    ),
                    onPressed: () {
                      if (_address.text == "") {
                        SweetAlert.show(
                          context,
                          title: 'Oops !',
                          subtitle: 'Please provide your address',
                          style: SweetAlertStyle.error,
                        );
                      } else {
                        makeOrder(context);
                      }
                    },
                    color: Colors.blueAccent,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(0)),
                  ),
                ],
              ),
            )));
    ;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getProfille(context);

    total = widget.amount + widget.method_charge;
  }

  getProfille(context) async {
    setState(() {});

     String users = '',city='';

    final prefs = await SharedPreferences.getInstance();
     users = prefs.getString('user');
      //city = prefs.getString('city');
  

    Future<dynamic> response = apiInterface.getProfile(users);

    response.then((action) async {
      print(action.toString());
      if (action != null) {
        Map data = jsonDecode(action.toString());
        if (data["status"] == "200") {
          List<dynamic> list = data['result'];
          for (int i = 0; i < list.length; i++) {
            UsersItem notificationItem = UsersItem.fromMap(list[i]);
            user.add(notificationItem);
          }
          setState(() {
            for (int i = 0; i < user.length; i++) {
              Fluttertoast.showToast(
                  msg: user[i].city, toastLength: Toast.LENGTH_SHORT);
              _city.text = user[i].city;
              _email.text = user[i].email;
              _name.text = user[i].fname + " " + user[i].lname;
              _mobile.text = user[i].mobile;
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

  makeOrder(context) async {
    setState(() {});

     String pincode = '',users='';

    final prefs = await SharedPreferences.getInstance();
     pincode = prefs.getString('pincode');
      users = prefs.getString('user');
  

    Future<dynamic> response = apiInterface.makeOrder(
          users,
        total.toString(),
        widget.method.toString(),
        _email.text,
        _name.text,
        _address.text,
        _mobile.text,
        pincode,
        widget.method_charge.toString());

    response.then((action) async {
      print(action.toString());
      if (action != null) {
        Map data = jsonDecode(action.toString());
        if (data["status"] == "200") {
          SweetAlert.show(context,
              title: 'Thank You !',
              subtitle: 'your order has been placed',
              style: SweetAlertStyle.success, onPress: (bool isConfirm) {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => OrderScreen(),
                ));

            return false;
          });

          /* List<dynamic> list = data['result'];
          for (int i = 0; i < list.length; i++) {
            UsersItem notificationItem = UsersItem.fromMap(list[i]);
            user.add(notificationItem);
          }
          setState(() {
            for (int i = 0; i < user.length; i++) {
              Fluttertoast.showToast(
                  msg: user[i].city, toastLength: Toast.LENGTH_SHORT);
              _city.text = user[i].city;
              _email.text = user[i].email;
              _name.text = user[i].fname + " " + user[i].lname;
              _mobile.text = user[i].mobile;
            }
          });

          */
        } else {
          print('error');
        }
      }
    }, onError: (value) {
      print(value);
    });
  }
}
