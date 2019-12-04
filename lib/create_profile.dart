import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'api_interface.dart';
import 'dashboard_screen.dart';
import 'models/users_item.dart';

class CreateProfile extends StatefulWidget {
  @override
  _CreateProfileState createState() => _CreateProfileState();
}

class _CreateProfileState extends State<CreateProfile> {
  ApiInterface apiInterface = new ApiInterface();

  //Event List
  List<UsersItem> user = new List();

  var fname = TextEditingController();
  var mobile = TextEditingController();
  var pincode = TextEditingController();
  var city = TextEditingController();

  var lname = TextEditingController();
  var email = TextEditingController();

  Widget _firstnametextField() {
    return new TextField(
      controller: this.fname,
      decoration: new InputDecoration(
        hintText: "Enter Value",
        labelText: "First Name",
        labelStyle: new TextStyle(color: const Color(0xFF424242)),
        border: new OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
      onChanged: (text) => setState(() {}),
    );
  }

  Widget _lastnametextField() {
    return new TextField(
      controller: this.lname,
      decoration: new InputDecoration(
        hintText: "Enter Value",
        labelText: "Last Name",
        labelStyle: new TextStyle(color: const Color(0xFF424242)),
        border: new OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
      onChanged: (text) => setState(() {}),
    );
  }

  Widget _emailtextField() {
    return new TextField(
      controller: this.email,
      enabled: false,
      decoration: new InputDecoration(
        hintText: "Enter E-Mail",
        labelText: "Email",
        labelStyle: new TextStyle(color: const Color(0xFF424242)),
        border: new OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
      onChanged: (text) => setState(() {}),
    );
  }

  Widget _mobiletextField() {
    return new TextField(
      controller: this.mobile,
      enabled: false,
      decoration: new InputDecoration(
        hintText: "Enter Value",
        labelText: "Mobile Number",
        labelStyle: new TextStyle(color: const Color(0xFF424242)),
        border: new OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
      onChanged: (text) => setState(() {}),
    );
  }

  Widget _pincodetextField() {
    return new TextField(
      controller: this.pincode,
      decoration: new InputDecoration(
        hintText: "Enter Value",
        labelText: "Pin Code",
        labelStyle: new TextStyle(color: const Color(0xFF424242)),
        border: new OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
      onChanged: (text) => setState(() {}),
    );
  }

  Widget _savebutton() {
    return RaisedButton(
        color: Colors.blue,
        padding: EdgeInsets.all(
          15.0,
        ),
        shape: RoundedRectangleBorder(
            borderRadius: new BorderRadius.circular(30.0),
            side: BorderSide(color: Colors.blue)),
        highlightColor: Colors.black,
        child: new Text(
          'Save Changes',
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
        onPressed: () {});
  }

  Widget _citytextField() {
    return new TextField(
      controller: this.city,
      decoration: new InputDecoration(
        hintText: "Enter Value",
        labelText: "City",
        labelStyle: new TextStyle(color: const Color(0xFF424242)),
        border: new OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
      onChanged: (text) => setState(() {}),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
          'Profile',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
        elevation: 4.0,
      ),
      backgroundColor: Colors.white,
      body: ListView(
        padding: EdgeInsets.all(10.0),
        children: <Widget>[
          CircleAvatar(
            radius: 40.0,
            backgroundColor: Colors.blue,
            child: Icon(
              Icons.person,
              size: 45,
              color: Colors.white,
            ),
          ),
          SizedBox(
            height: 20,
          ),
          _firstnametextField(),
          SizedBox(
            height: 20,
          ),
          _lastnametextField(),
          SizedBox(
            height: 20,
          ),
          _emailtextField(),
          SizedBox(
            height: 20,
          ),
          _mobiletextField(),
          SizedBox(
            height: 20,
          ),
          _pincodetextField(),
          SizedBox(
            height: 20,
          ),
          _citytextField(),
          SizedBox(
            height: 20,
          ),
          _savebutton(),
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    getProfille(context);
  }

  getProfille(context) async {
    setState(() {});

    Future<dynamic> response = apiInterface.getProfile('1');

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
              city.text = user[i].city;
              email.text = user[i].email;
              fname.text = user[i].fname;
              lname.text = user[i].lname;
              mobile.text = user[i].mobile;
              pincode.text = user[i].pincode;
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
