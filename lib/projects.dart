import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:owomark/single_project.dart';

import 'api_interface.dart';
import 'dashboard_screen.dart';
import 'models/project_item.dart';

class Projects extends StatefulWidget {
  @override
  _ProjectsState createState() => _ProjectsState();
}

class _ProjectsState extends State<Projects> {
  ApiInterface apiInterface = new ApiInterface();

  //Event List
  List<ProjectItem> projects = new List();

  String projecturl = 'http://owomark.com/owomarkapp/images/projects/';

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
          'Projects',
          style: TextStyle(color: Colors.black),
          //textAlign: TextAlign.center,
        ),
        elevation: 3.0,
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        height: double.infinity,
        child: GridView.count(
            crossAxisCount: 2,
            scrollDirection: Axis.vertical,
            children: List.generate(projects.length, (index) {
              final item = projects[index];
              return GestureDetector(
                child: makeBestCategory(
                    image: projecturl + item.imageUrl,
                    title: item.name,
                    price: item.price),
                onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) => SingleProject(
                              project_id: item.id,
                            ))),
              );
            })),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    getProjects(context);
  }

  getProjects(context) async {
    setState(() {});

    Future<dynamic> response = apiInterface.getAllProjects('1');

    response.then((action) async {
      print(action.toString());
      if (action != null) {
        Map data = jsonDecode(action.toString());
        if (data["status"] == "200") {
          List<dynamic> list = data['result'];
          for (int i = 0; i < list.length; i++) {
            ProjectItem notificationItem = ProjectItem.fromMap(list[i]);
            projects.add(notificationItem);
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
}

Widget makeBestCategory({String image, String title, String price}) {
  return Column(
    children: <Widget>[
      Container(
        height: 100,
        margin: EdgeInsets.only(right: 5),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            image:
                DecorationImage(image: NetworkImage(image), fit: BoxFit.cover)),
        child: Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                gradient: LinearGradient(begin: Alignment.bottomRight, colors: [
                  Colors.black.withOpacity(.8),
                  Colors.black.withOpacity(.2),
                ])),
            child: Align(
              alignment: Alignment.bottomLeft,
              child: Text(
                title,
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
            )),
      ),
      ListTile(
        title: Text(
          price + ' Rs',
          style: TextStyle(
              fontSize: 18,
              //color: Colors.green,
              fontWeight: FontWeight.bold),
        ),
        trailing: Icon(
          Icons.arrow_forward_ios,
        ),
      ),
    ],
  );
}
