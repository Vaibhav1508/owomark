import 'package:flutter/material.dart';

import 'dashboard_screen.dart';

class CreateProfile extends StatefulWidget {
  @override
  _CreateProfileState createState() => _CreateProfileState();
}

class _CreateProfileState extends State<CreateProfile> {
  var controller1 = TextEditingController();
  var controller4 = TextEditingController();
  var controller5 = TextEditingController();
  var controller6 = TextEditingController();

  var controller2 = TextEditingController();
  var controller3 = TextEditingController();

  Widget _firstnametextField() {
    return new TextField(
      controller: this.controller1,
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
      controller: this.controller2,
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
      controller: this.controller3,
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
      controller: this.controller4,
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
      controller: this.controller5,
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
      controller: this.controller6,
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
}
