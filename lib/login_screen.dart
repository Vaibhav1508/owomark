import 'package:flutter/material.dart';
import 'package:owomark/registrationscreen.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
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
                        onPressed: () {},
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
}
