import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:owomark/api_interface.dart';
import 'package:owomark/dashboard_screen.dart';
import 'package:owomark/registrationscreen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {


  ApiInterface apiInterface = new ApiInterface();

   var email = TextEditingController();
  var password = TextEditingController();
 
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
                    "Login",
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                  ),
                ),
                new Container(
                    padding: const EdgeInsets.only(top: 5.0),
                    child: new TextFormField(
                      controller: email,
                      keyboardType: TextInputType
                          .emailAddress, // Use email input type for emails.
                      decoration: new InputDecoration(
                          hintText: 'you@example.com',
                          labelText: 'E-mail Address',
                          icon: new Icon(Icons.email)),
                    )),
                new Container(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: new TextFormField(
                    controller: password,
                    obscureText: true, // Use secure text for passwords.
                    decoration: new InputDecoration(
                        hintText: 'Password',
                        labelText: 'Enter your password',
                        icon: new Icon(Icons.lock)),
                  ),
                ),
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
                          'Login',
                          style:
                              new TextStyle(color: Colors.white, fontSize: 18),
                        ),
                        onPressed: () {
                          if(email.text==""||password.text==""){
                            Fluttertoast.showToast(msg: 'Please provide details',toastLength: Toast.LENGTH_SHORT);
                          }else{
                            login(context, email.text, password.text);
                            email.text="";
                            password.text="";
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
                    'Not a Member ? Register',
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

   login(context,String email,String password) async {
    setState(() {});

    Future<dynamic> response = apiInterface.checkLogin(email,password);

    response.then((action) async {
      //print(action.toString());
      if (action != null) {
        Map data = jsonDecode(action.toString());
        if (data["status"] == "200") {

         Fluttertoast.showToast(msg: 'User Login Successfully',toastLength: Toast.LENGTH_LONG);
        // Navigator.push(context, MaterialPageRoute(builder: (_)=>LoginScreen()));

        List<dynamic> list = data['result'];
          for (int i = 0; i < list.length; i++) {
           
            //SharedPreferences.setMockInitialValues({});
            
            final prefs = await SharedPreferences.getInstance();

            prefs.setString("user",list[i]['id']);
            prefs.setString("email",list[i]['email']);
            prefs.setString("name",list[i]['f_name']+''+list[i]['l_name']);
            prefs.setString("city",list[i]['city']);
            prefs.setString("balance",list[i]['owo_wallet']);
            prefs.setString("pincode",list[i]['pincode']);

          }

          Navigator.push(context, MaterialPageRoute(builder: (_)=>DashboardScreen()));
        
         
        } else {

         Fluttertoast.showToast(msg: 'Invalid email or password',toastLength: Toast.LENGTH_LONG);
          print('error');
        }
      }
    }, onError: (value) {
      print(value);
    });
  }
}
