import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:owomark/single_event.dart';

import 'api_interface.dart';
import 'dashboard_screen.dart';
import 'models/event_item.dart';
import 'news_feed.dart';

class EventScreen extends StatefulWidget {
  @override
  _EventScreenState createState() => _EventScreenState();
}

class _EventScreenState extends State<EventScreen> {
  ApiInterface apiInterface = new ApiInterface();

  //Event List
  List<EventItem> events = new List();

  String eventurl = 'http://owomark.com/owomarkapp/images/events/';

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
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.search),
              iconSize: 30.0,
              color: Colors.grey,
              onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => NewsFeed(),
                    ),
                  )),
        ],
        title: Text(
          'Events',
          style: TextStyle(color: Colors.black),
          //textAlign: TextAlign.center,
        ),
        elevation: 3.0,
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
        height: double.infinity,
        child: ListView.builder(
            itemCount: events.length,
            itemBuilder: (BuildContext context, int index) {
              final item = events[index];

              return GestureDetector(
                child: makeBestCategory(
                    image: eventurl + item.imageUrl,
                    title: item.name,
                    location: item.location,
                    timing: item.time),
                onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) => SingleEvent(
                              event_id: item.id,
                            ))),
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

    Future<dynamic> response = apiInterface.getEvents('1');

    response.then((action) async {
      print(action.toString());
      if (action != null) {
        Map data = jsonDecode(action.toString());
        if (data["status"] == "200") {
          List<dynamic> list = data['result'];
          for (int i = 0; i < list.length; i++) {
            EventItem notificationItem = EventItem.fromMap(list[i]);
            events.add(notificationItem);
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

Widget makeBestCategory(
    {String image, String title, String location, String timing}) {
  return AspectRatio(
    child: Column(
      children: <Widget>[
        Container(
          height: 150,
          margin: EdgeInsets.only(right: 0),
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
            timing,
            style: TextStyle(fontSize: 16),
          ),
          trailing: Icon(Icons.access_time),
        ),
        ListTile(
          title: Text(
            location,
            style: TextStyle(fontSize: 16),
          ),
          trailing: Icon(Icons.location_on),
        ),
        Divider(),
        ListTile(
          title: Text(
            "View More",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          trailing: Icon(
            Icons.arrow_forward_ios,
            color: Colors.black,
          ),
        ),
      ],
    ),
    aspectRatio: 1 / 1,
  );
}
