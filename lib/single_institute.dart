import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:owomark/reviews.dart';
import 'package:rating_bar/rating_bar.dart';
import 'package:owomark/chat_screen.dart';
import 'package:owomark/models/institute_item.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'api_interface.dart';
import 'dashboard_screen.dart';

class SingleInstitute extends StatefulWidget {
  final String project_id;

  SingleInstitute({Key key, this.project_id}) : super(key: key);

  @override
  _SingleInstituteState createState() => _SingleInstituteState();
}

class _SingleInstituteState extends State<SingleInstitute> {
  ApiInterface apiInterface = new ApiInterface();

  //Event List
  List<InstituteItem> institute = new List();

  String insturl = 'http://owomark.com/owomarkapp/images/classes/';

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
          'Institute Details',
          style: TextStyle(color: Colors.black),
          //textAlign: TextAlign.center,
        ),
        elevation: 3.0,
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: ListView.builder(
            itemCount: institute.length,
            itemBuilder: (BuildContext context, int index) {
              final item = institute[index];

              return SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    Image.network(
                      insturl + item.imageUrl,
                      height: 200,
                      width: MediaQuery.of(context).size.width * 5,
                    ),
                    ListTile(
                      title: Text(
                        'Title',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                      trailing: Icon(Icons.arrow_forward_ios),
                    ),
                    ListTile(
                      title: Text(item.name),
                    ),
                    Divider(),
                   item.rated == "1" ?  RatingBar.readOnly(
                      //onRatingChanged: (rating) => setState(()=>rating = rating),
                      filledIcon: Icons.star,
                      initialRating: double.parse(item.rate),
                      emptyIcon: Icons.star_border,
                      halfFilledIcon: Icons.star_half,
                      isHalfAllowed: false,
                      filledColor: Colors.orange,
                      emptyColor: Colors.orangeAccent,
                      halfFilledColor: Colors.orangeAccent,
                      size: 35,
                    ) : RatingBar(
                      onRatingChanged: (rating){
                        institute.clear();
                        starRating(context,item.id,rating);
                      },
                      filledIcon: Icons.star,
                      //initialRating: double.parse(item.rate),
                      emptyIcon: Icons.star_border,
                      halfFilledIcon: Icons.star_half,
                      isHalfAllowed: false,
                      filledColor: Colors.orange,
                      emptyColor: Colors.orangeAccent,
                      halfFilledColor: Colors.orangeAccent,
                      size: 35,
                    ),
                    SizedBox(height: 5.0,),
                    
                    Divider(),

                    ListTile(
                      onTap:()=> Navigator.push(context, MaterialPageRoute(
                        builder: (_)=>Reviews(inst_id: item.id)
                      )),
                      title: Text(
                        'View Reviews',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                      trailing: Icon(Icons.star_border),
                    ),
                    Divider(),
                    ListTile(
                      title: Text(
                        'Location',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                      trailing: Icon(Icons.location_on),
                    ),
                    ListTile(
                      title: Text(item.location),
                    ),
                    Divider(),
                    ListTile(
                      title: Text(
                        'Contact',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                      trailing: Icon(Icons.phone),
                      onTap: () {},
                    ),
                    ListTile(
                      title: Text(item.contact),
                    ),
                    Divider(),
                    ListTile(
                      title: Text(
                        'Address',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                      trailing: Icon(Icons.location_city),
                    ),
                    ListTile(
                      title: Text(item.address),
                    ),
                    Divider(),
                    ListTile(
                      title: Text(
                        'Email',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                      trailing: Icon(Icons.email),
                    ),
                    ListTile(
                      title: Text(item.email),
                    ),
                    Divider(),
                    ListTile(
                      title: Text(
                        'Tutor',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                      trailing: Icon(Icons.person_pin),
                    ),
                    ListTile(
                      title: Text(
                        item.tutor,
                        style: TextStyle(color: Colors.orange, fontSize: 22),
                      ),
                    ),
                    Divider(),
                    ListTile(
                      title: Text(
                        'Tutor Experience',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                      trailing: Icon(Icons.timelapse),
                    ),
                    ListTile(
                      title: Text(item.exp),
                    ),
                    Divider(),
                    ListTile(
                      title: Text(
                        'Tutor Education',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                      trailing: Icon(Icons.book),
                    ),
                    ListTile(
                      title: Text(item.education),
                    ),
                    Divider(),
                    ListTile(
                      title: Text(
                        'Contact Owner',
                        style: TextStyle(fontSize: 18, color: Colors.green),
                      ),
                    ),
                    Divider(),
                    
                     ListTile(
                      onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => ChatScreen(
                                    user: item.user,
                                  ))),
                      title: Text('Customer ' + item.user),
                      trailing: Container(
                        child: Icon(Icons.email),
                      ),
                      leading: CircleAvatar(
                        backgroundColor: Colors.green,
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

   starRating(context, String id,double rating) async {
    setState(() {});
     String users = '';

    final prefs = await SharedPreferences.getInstance();
     users = prefs.getString('user');
  

    Future<dynamic> response = apiInterface.starRating(id,users,rating);

    response.then((action) async {
      print(action.toString());
      if (action != null) {
        Map data = jsonDecode(action.toString());
        if (data["status"] == "200") {
          Fluttertoast.showToast(msg: 'Rated Successfully');

          getEvents(context);
          setState(() {});
        } else {
          print('error');
        }
      }
    }, onError: (value) {
      print(value);
    });
  }

  getEvents(context) async {
    setState(() {});

    String user = '';

    final prefs = await SharedPreferences.getInstance();
     user = prefs.getString('user');

    Future<dynamic> response = apiInterface.getInstituteById(user,widget.project_id);

    response.then((action) async {
      print(action.toString());
      if (action != null) {
        Map data = jsonDecode(action.toString());
        if (data["status"] == "200") {
          List<dynamic> list = data['result'];
          for (int i = 0; i < list.length; i++) {
            InstituteItem notificationItem = InstituteItem.fromMap(list[i]);
            institute.add(notificationItem);
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
