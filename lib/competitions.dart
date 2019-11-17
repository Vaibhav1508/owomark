import 'package:flutter/material.dart';

import 'dashboard_screen.dart';
import 'news_feed.dart';

class Competitions extends StatefulWidget {
  @override
  _CompetitionsState createState() => _CompetitionsState();
}

class _CompetitionsState extends State<Competitions> {
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
          'Competitions',
          style: TextStyle(color: Colors.black),
          //textAlign: TextAlign.center,
        ),
        elevation: 3.0,
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 10,vertical: 20),
        height: double.infinity,

        child: ListView(

          scrollDirection: Axis.vertical,
          children: <Widget>[
            makeBestCategory(
                image: 'assets/images/clothes.jpg', title: 'Clothes'),
            makeBestCategory(
                image: 'assets/images/glass.jpg', title: 'Glass'),
            makeBestCategory(
                image: 'assets/images/clothes.jpg', title: 'Clothes'),
            makeBestCategory(
                image: 'assets/images/glass.jpg', title: 'Glass'),
          ],
        ),
      ),

    );
  }
}


Widget makeBestCategory({String image, String title}) {
  return AspectRatio(
    child: Column(


      children: <Widget>[

        Container(

          height: 150,
          margin: EdgeInsets.only(right: 20),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              image:
              DecorationImage(image: AssetImage(image), fit: BoxFit.cover)),
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
          title:  Text("24/10/2019 at 08:00 PM",
            style: TextStyle(fontSize: 16),),
          trailing: Icon(Icons.access_time),
        ),
        ListTile(
          title:  Text("Amount",
            style: TextStyle(fontSize: 16),),
          trailing: Icon(Icons.card_giftcard),
        ),
        Divider(),

        ListTile(
          title:  Text("View More",
            style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),),
          trailing: Icon(Icons.arrow_forward_ios,color: Colors.black,),
        ),
      ],
    ),
    aspectRatio: 1 / 1,
  );
}
