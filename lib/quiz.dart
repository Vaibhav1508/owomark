import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:owomark/Quiz1.dart';
import 'package:owomark/single_book.dart';
import 'package:sweetalert/sweetalert.dart';

import 'api_interface.dart';
import 'dashboard_screen.dart';
import 'models/quiz_item.dart';

class QuizScreen extends StatefulWidget {
  @override
  _QuizScreenState createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  int _currentTabIndex = 0;

  ApiInterface apiInterface = new ApiInterface();

  //Category List
  List<QuizItem> books = new List();

  String status = '';

  String base64Image;

  File tmpfile;

  String errormsg = 'error uploading image';

  String producturl = 'http://owomark.com/owomarkapp/images/quiz/';

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
          'Quiz',
          style: TextStyle(color: Colors.black),
          //textAlign: TextAlign.center,
        ),
        elevation: 3.0,
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
        height: double.infinity,
        child: ListView.builder(
            itemCount: books.length,
            itemBuilder: (BuildContext context, int index) {
              final item = books[index];
              return GestureDetector(
               
                child: makeBestCategory(
                    context: context,
                    image: producturl + item.imageUrl,
                    title: item.name,
                    price: item.q_time,
                    pickup: item.min,
                    id: item.id),
              );
            }),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    getBooks(context);
  }

  getBooks(context) async {
    setState(() {});

    Future<dynamic> response = apiInterface.getQuiz('1');

    response.then((action) async {
      print(action.toString());
      if (action != null) {
        Map data = jsonDecode(action.toString());
        if (data["status"] == "200") {
          List<dynamic> list = data['result'];
          for (int i = 0; i < list.length; i++) {
            QuizItem notificationItem = QuizItem.fromMap(list[i]);
            books.add(notificationItem);
          }
          setState(() {});
        } else {
          print('error');
        }
      }
    }, onError: (value) {
      print(value);
    });
  }

  setStatus(String message) {
    setState(() {
      status = message;
    });
  }
}

Widget makeBestCategory(
    {context, String image, String title, String price, String pickup,String id}) {
  return AspectRatio(
    child: Column(
      children: <Widget>[
        Container(
          height: 150,
          margin: EdgeInsets.only(right: 20),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              image: DecorationImage(
                  image: NetworkImage(image), fit: BoxFit.cover)),
          child: Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                gradient: LinearGradient(begin: Alignment.bottomRight, colors: [
                  Colors.black.withOpacity(.8),
                  Colors.black.withOpacity(.2),
                ])),
            child: Align(
              alignment: Alignment.bottomLeft,
              child: Text(
                title,
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 18),
              ),
            ),
          ),
        ),
        ListTile(
          title: Text(
            price,
            style: TextStyle(fontSize: 16),
          ),
          trailing: Icon(Icons.timer),
        ),
        ListTile(
          title: Text(
            "Minimum Score : " + pickup,
            style: TextStyle(fontSize: 16),
          ),
          trailing: Icon(Icons.score),
        ),
        Divider(),
        ListTile(
         title: Text(
            "Notify Me",
            style: TextStyle(fontSize: 18, fontFamily: 'maven_black'),
          ),

          onTap: (){
             SweetAlert.show(context,
              title: 'Saved !',
              subtitle: 'We will notify you when quiz get available',
              style: SweetAlertStyle.success,);
          },
          trailing: Icon(Icons.arrow_forward_ios),
        ),
      ],
    ),
    aspectRatio: 1 / 1,
  );
}
