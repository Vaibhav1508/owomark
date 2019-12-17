import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:owomark/dashboard_screen.dart';
import 'package:owomark/models/news_item.dart';
import 'package:owomark/my_news.dart';
import 'package:owomark/upload_news.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'api_interface.dart';

class NewsFeed extends StatefulWidget {
  final String comp_id;

  NewsFeed({Key key, this.comp_id}) : super(key: key);

  @override
  _NewsFeedState createState() => _NewsFeedState();
}

class _NewsFeedState extends State<NewsFeed> {
  ApiInterface apiInterface = new ApiInterface();

  //Event List
  List<NewsItem> news = new List();

  String projecturl = 'http://owomark.com/owomarkapp/images/newsfeed/';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            'News Feed',
            style: TextStyle(color: Colors.black),
            //textAlign: TextAlign.center,
          ),
          elevation: 3.0,
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.add_a_photo),
              iconSize: 30.0,
              color: Colors.grey,
              onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (_) => UploadNews(
                            comp_id: widget.comp_id,
                          ))),
            ),
            IconButton(
              icon: Icon(Icons.collections_bookmark),
              iconSize: 30.0,
              color: Colors.grey,
              onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (_) => MyNews(
                            
                          ))),
            )
          ],
        ),
        backgroundColor: Colors.white,
        body: news.length == 0
            ? Center(
                child: Text(
                  "No Data Found",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
                ),
              )
            : ListView.builder(
                padding: EdgeInsets.all(10),
                itemCount: news.length,
                itemBuilder: (BuildContext context, int index) {
                  final item = news[index];

                  return makeFeed(
                      username: item.fname + " " + item.lname,
                      feedImage: projecturl + item.imageUrl,
                      feedText: "feed text is here",
                      feedTime: item.time,
                      userImage: 'assets/images/glass.jpg',
                      status: item.liked == "1" ? true : false,
                      likes: item.likes,
                      id: item.id);
                }));
  }

  Widget makeFeed(
      {username, userImage, feedTime, feedText, feedImage, status, likes, id}) {
    return Container(
      margin: EdgeInsets.only(bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Row(
                children: <Widget>[
                  Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          image: AssetImage(userImage),
                          fit: BoxFit.cover,
                        )),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        username,
                        style: TextStyle(
                            color: Colors.grey[900],
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1),
                      ),
                      SizedBox(
                        height: 3,
                      ),
                      Text(
                        feedTime,
                        style: TextStyle(fontSize: 15, color: Colors.grey),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            height: 200,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                image: DecorationImage(
                  image: NetworkImage(feedImage),
                  fit: BoxFit.cover,
                )),
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  makeLike(),
                  SizedBox(
                    width: 5,
                  ),
                  Text(
                    likes,
                    style: TextStyle(fontSize: 15, color: Colors.grey[800]),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            children: <Widget>[
              makeLikeButton(status, id),
            ],
          )
        ],
      ),
    );
  }

  Widget makeLike() {
    return Container(
      width: 25,
      height: 25,
      decoration: BoxDecoration(
        color: Colors.green,
        shape: BoxShape.circle,
        border: Border.all(color: Colors.white),
      ),
      child: Center(
        child: Icon(Icons.thumb_up, size: 12, color: Colors.white),
      ),
    );
  }

  Widget makeLikeButton(isActive, id) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey[200]),
        borderRadius: BorderRadius.circular(50),
      ),
      child: Center(
          child: GestureDetector(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(
              Icons.thumb_up,
              color: isActive ? Colors.green : Colors.grey,
            ),
            SizedBox(
              width: 5,
            ),
            Text(
              isActive ? "Liked" : "Like",
              style: TextStyle(color: isActive ? Colors.green : Colors.grey),
            ),
          ],
        ),
        onTap: () {
          if (isActive) {
          } else {
            news.clear();
            likePost(context, id);
          }
        },
      )),
    );
  }

  @override
  void initState() {
    super.initState();
    getNewsFeed(context);
  }

  getNewsFeed(context) async {
    setState(() {});

    String users = '';

    final prefs = await SharedPreferences.getInstance();
     users = prefs.getString('user');
  

    Future<dynamic> response = apiInterface.getNewsFeed(users, widget.comp_id);

    response.then((action) async {
      print(action.toString());
      if (action != null) {
        Map data = jsonDecode(action.toString());
        if (data["status"] == "200") {
          List<dynamic> list = data['result'];
          for (int i = 0; i < list.length; i++) {
            NewsItem notificationItem = NewsItem.fromMap(list[i]);
            news.add(notificationItem);
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

  likePost(context, String id) async {
    setState(() {});

    String users = '';

    final prefs = await SharedPreferences.getInstance();
     users = prefs.getString('user');
  

    Future<dynamic> response = apiInterface.likePost(users, id);

    response.then((action) async {
      print(action.toString());
      if (action != null) {
        Map data = jsonDecode(action.toString());
        if (data["status"] == "200") {
          getNewsFeed(context);
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
