import 'package:flutter/material.dart';
import 'package:owomark/welcome.dart';

import 'models/data.dart';

Book book = books.elementAt(0);

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Owomark',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          fontFamily: 'MavenProMedium',
          primaryColor: Colors.blueAccent,
          accentColor: Color(0xFFFE9EB),
          hintColor: Colors.blueAccent),
      home: WelcomePage(),
    );
  }
}
