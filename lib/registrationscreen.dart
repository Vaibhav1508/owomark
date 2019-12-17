import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:owomark/api_interface.dart';
import 'package:owomark/otp_screen.dart';
import 'package:sweetalert/sweetalert.dart';

class RegistrationScreen extends StatefulWidget {
  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {

  var fname = TextEditingController();
  var lname = TextEditingController();
  var email = TextEditingController();
  var mobile = TextEditingController();
  var city = TextEditingController();
  var pincode = TextEditingController();
  var refer = TextEditingController();
  var password = TextEditingController();
  var course = TextEditingController();
  var sem = TextEditingController();


  ApiInterface apiInterface = new ApiInterface();
  //var lname = TextEditingController();
  
   
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new Container(
          padding: new EdgeInsets.all(20.0),
          child: new Form(
            child: new ListView(
              children: <Widget>[
                new Container(
                    padding: new EdgeInsets.all(20.0),
                    child: new Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        CircleAvatar(
                          backgroundImage:
                              AssetImage('assets/images/glass.jpg'),
                          radius: 50,
                        )
                      ],
                    )),
                new Padding(
                  padding: EdgeInsets.only(left: 0.0),
                  child: Text(
                    "Register",
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                  ),
                ),
                new Container(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: new TextFormField(
                      controller: fname,
                        keyboardType: TextInputType
                            .text, // Use email input type for emails.
                        decoration: new InputDecoration(
                          hintText: 'Your Name',
                          labelText: 'First Name',
                          icon: new Icon(Icons.person_outline),
                        ))),
                new Container(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: new TextFormField(
                      controller: lname,
                        keyboardType: TextInputType
                            .text, // Use email input type for emails.
                        decoration: new InputDecoration(
                          hintText: 'Your SurName',
                          labelText: 'Last Name',
                          icon: new Icon(Icons.person),
                        ))),
                new Container(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: new TextFormField(
                      controller: email,
                        keyboardType: TextInputType
                            .emailAddress, // Use email input type for emails.
                        decoration: new InputDecoration(
                            hintText: 'you@example.com',
                            labelText: 'E-mail Address',
                            icon: new Icon(Icons.email)))),
                new Container(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: new TextFormField(
                      controller: mobile,
                        keyboardType: TextInputType
                            .phone, // Use number input type for emails.
                        decoration: new InputDecoration(
                            hintText: 'Enter Mobile Number',
                            labelText: 'Mobile Number',
                            icon: new Icon(Icons.phone)))),
                new Container(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: new TextFormField(
                      controller: city,
                        keyboardType: TextInputType
                            .text, // Use number input type for emails.
                        decoration: new InputDecoration(
                            hintText: 'Enter City Name',
                            labelText: 'City',
                            icon: new Icon(Icons.location_city)))),
                new Container(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: new TextFormField(
                      controller: course,
                        keyboardType: TextInputType
                            .text, // Use number input type for emails.
                        decoration: new InputDecoration(
                            hintText: 'School / B.E / Diploma',
                            labelText: 'Education Course',
                            icon: new Icon(Icons.arrow_forward_ios)))),
                new Container(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: new TextFormField(
                      controller: sem,
                        keyboardType: TextInputType
                            .text, // Use number input type for emails.
                        decoration: new InputDecoration(
                            hintText: 'SEM / STD',
                            labelText: 'Your Semester ',
                            icon: new Icon(Icons.arrow_forward_ios)))),
                new Container(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: new TextFormField(
                      controller: pincode,
                        keyboardType: TextInputType
                            .phone, // Use number input type for emails.
                        decoration: new InputDecoration(
                            hintText: 'Enter Pin Code',
                            labelText: 'Pin Code',
                            icon: new Icon(Icons.location_on)))),
               new Container(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: new TextFormField(
                      controller: refer,
                        keyboardType: TextInputType
                            .text, // Use number input type for emails.
                        decoration: new InputDecoration(
                          
                            hintText: 'Enter Refer Code',
                            labelText: 'Refer Code',
                            icon: new Icon(Icons.card_giftcard)))),
               
                new Container(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: new TextFormField(
                    controller: password,
                      obscureText: true, // Use secure text for passwords.
                      decoration: new InputDecoration(
                          hintText: 'Password',
                          labelText: 'Enter your password',
                          icon: new Icon(Icons.lock))),
                ),
               
                new Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    new Container(
                      height: 50.0,
                      width: 210.0,
                      margin: const EdgeInsets.symmetric(
                          horizontal: 20.0, vertical: 40.0),
                      child: new RaisedButton(
                        child: new Text(
                          'Register',
                          style:
                              new TextStyle(color: Colors.white, fontSize: 18),
                        ),
                        onPressed: (){
                          if(email.text==""||fname.text==""||lname.text==""||mobile.text==""||
                          password.text==""||city.text==""||pincode.text==""||course==""||sem==""){
                            Fluttertoast.showToast(msg: 'Please enter details',toastLength: Toast.LENGTH_LONG);
                          }else{
                            sendOtps(context,email.text);
                          }
                        },
                        color: Colors.blueAccent,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30)),

                      ),
                    ),
                  ],
                ),
              ],
            ),
          )),
    );
  }

sendOtps(context,String email) async {
    setState(() {});

    Future<dynamic> response = apiInterface.sendOtp(email);

    response.then((action) async {
      //print(action.toString());
      if (action != null) {
        Map data = jsonDecode(action.toString());
        if (data["status"] == "200") {
          
          String code = data["result"];

          if(code==""){
            Fluttertoast.showToast(msg: 'Unable to Register Try Again Later');
          }else{
            Navigator.push(context, MaterialPageRoute(
            builder: (_)=>OtpScreen(city: city.text,fname: fname.text,lname: lname.text,sem: sem.text,course: course.text,
            email: email,mobile: mobile.text,pincode: pincode.text,refer: refer.text,password: password.text,code:code,)
          ));
          }
         
        } else {
          SweetAlert.show(context,title: 'Account Exist',subtitle: 'Email already exist',
          style: SweetAlertStyle.error);
        }
      }
    }, onError: (value) {
      print(value);
    });
  }

}
