import 'dart:convert';

import 'package:flutter/material.dart';

import 'api_interface.dart';
import 'dashboard_screen.dart';
import 'models/project_item.dart';

class SingleProject extends StatefulWidget {
  final String project_id;

  SingleProject({Key key, this.project_id}) : super(key: key);

  @override
  _SingleProjectState createState() => _SingleProjectState();
}

class _SingleProjectState extends State<SingleProject> {
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
          'Project Details',
          style: TextStyle(color: Colors.black),
          //textAlign: TextAlign.center,
        ),
        elevation: 3.0,
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: ListView.builder(
            itemCount: projects.length,
            itemBuilder: (BuildContext context, int index) {
              final item = projects[index];

              return SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    Image.network(
                      projecturl + item.imageUrl,
                      height: 200,
                      width: MediaQuery.of(context).size.width * 5,
                    ),
                    ListTile(
                      title: Text(
                        'Project Title',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                      trailing: Icon(Icons.arrow_forward_ios),
                    ),
                    ListTile(
                      title: Text(item.name),
                    ),
                    Divider(),
                    ListTile(
                      title: Text(
                        'Project Description',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                      trailing: Icon(Icons.arrow_forward_ios),
                    ),
                    ListTile(
                      title: Text(item.desc),
                    ),
                    Divider(),
                    ListTile(
                      title: Text(
                        'Project Price',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                      trailing: Icon(Icons.arrow_forward_ios),
                    ),
                    ListTile(
                      title: Text(
                        item.price + " Rs",
                        style: TextStyle(color: Colors.orange, fontSize: 22),
                      ),
                    ),
                    Divider(),
                    ListTile(
                      title: Text('Additional Details 1'),
                    ),
                    Divider(),
                    ListTile(
                      title: Text('Additional Details 2'),
                    ),
                    Divider(),
                    ListTile(
                      title: Text(item.fname + " " + item.lname),
                      trailing: Column(
                        children: <Widget>[
                          Text(
                            'Message',
                            style: TextStyle(fontSize: 16, color: Colors.blue),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Icon(Icons.email)
                        ],
                      ),
                      leading: CircleAvatar(
                        backgroundColor: Colors.blue,
                        child: Icon(
                          Icons.person_outline,
                          color: Colors.white,
                        ),
                        radius: 25,
                      ),
                    )
                  ],
                ),
              );
            }),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    getEvents(context);
  }

  getEvents(context) async {
    setState(() {});

    Future<dynamic> response = apiInterface.getSingleProject(widget.project_id);

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
