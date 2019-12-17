import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:owomark/api_interface.dart';
import 'package:owomark/login_screen.dart';
import 'package:owomark/registrationscreen.dart';
import 'package:sweetalert/sweetalert.dart';

class OtpScreen extends StatefulWidget {

  final String fname;
  final String lname;
  final String email;
  final String mobile;
  final String city;
  final String course;
  final String sem;
  final String code;
  final String pincode;
  final String refer;
  final String password;


  OtpScreen({Key key, this.fname, this.lname,this.email,this.mobile,this.city,this.pincode,
  this.refer,this.password,this.code,this.sem,this.course}) : super(key: key);

  @override
  _OtpScreenState createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {

  ApiInterface apiInterface = new ApiInterface();

  var codec = TextEditingController();
  @override
  Widget build(BuildContext context) {
    MediaQueryData media = MediaQuery.of(context);

    final Size screenSize = media.size;
    return new Scaffold(
      body: new Container(
          padding: new EdgeInsets.all(20.0),
          child: new Form(
            child: new ListView(
              children: <Widget>[
                Container(
                    padding: new EdgeInsets.all(20.0),
                    child: new Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        CircleAvatar(
                          backgroundImage:
                              AssetImage('assets/images/glass.jpg'),
                          radius: 50,
                        ),
                      ],
                    )),
                new Padding(
                  padding: EdgeInsets.only(left: 0.0),
                  child: Text(
                    "Verification",
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                  ),
                ),
                new Container(
                  padding: const EdgeInsets.only(top: 5.0),
                  child: ListTile(title: Text('Otp has been sent to your'),),
                ),
                new Container(
                    padding: const EdgeInsets.only(top: 5.0),
                    child: new TextFormField(
                      controller: codec,
                      keyboardType: TextInputType
                          .number, // Use email input type for emails.
                      decoration: new InputDecoration(
                          hintText: 'Otp code',
                          labelText: 'Otp Code',
                          icon: new Icon(Icons.email)),
                    )),
               
                new Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    new Container(
                      height: 50.0,
                      width: 150.0,
                      margin: const EdgeInsets.symmetric(
                          horizontal: 30.0, vertical: 20.0),
                      child: new RaisedButton(
                        child: new Text(
                          'Verify',
                          style:
                              new TextStyle(color: Colors.white, fontSize: 18),
                        ),
                        onPressed: () {
                          if(codec.text==widget.code){
                            registerUsers(context);
                          }else{

                            Fluttertoast.showToast(msg: 'Failed to verify, Try Again',toastLength: Toast.LENGTH_LONG);
                          }
                        },
                        color: Colors.blueAccent,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30)),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 15,
                ),
                ListTile(
                  title: Text(
                    'Back To Register',
                  ),
                  trailing: Icon(Icons.arrow_forward_ios),
                  onTap: () => Navigator.push(context,
                      MaterialPageRoute(builder: (_) => RegistrationScreen())),
                ),
              ],
            ),
          )),
    );
  }

  registerUsers(context) async {
    setState(() {});

    Future<dynamic> response = apiInterface.registerUser(widget.fname,widget.lname,widget.email,
    widget.city,widget.pincode,widget.password,widget.mobile,widget.refer,widget.course,widget.sem);

    response.then((action) async {
      //print(action.toString());
      if (action != null) {
        Map data = jsonDecode(action.toString());
        if (data["status"] == "200") {

         Fluttertoast.showToast(msg: 'User Registered Successfully',toastLength: Toast.LENGTH_LONG);
         Navigator.push(context, MaterialPageRoute(builder: (_)=>LoginScreen()));

         
        } else {
          print('error');
        }
      }
    }, onError: (value) {
      print(value);
    });
  }
}
