import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:owomark/models/institute_item.dart';
import 'package:owomark/single_institute.dart';
import 'package:rating_bar/rating_bar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sweetalert/sweetalert.dart';
import 'api_interface.dart';
import 'models/review_item.dart';
class Reviews extends StatefulWidget {

   final String inst_id;

  Reviews({Key key, this.inst_id}) : super(key: key);

  @override
  _ReviewsState createState() => _ReviewsState();
}

class _ReviewsState extends State<Reviews> {
  ApiInterface apiInterface = new ApiInterface();

  //Category List
  List<ReviewItem> institutes = new List();

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
                    builder: (_) => SingleInstitute(project_id: widget.inst_id,),
                  ),
                )),
        title: Text(
          'Institute Reviews',
          style: TextStyle(color: Colors.black),
          //textAlign: TextAlign.center,
        ),
        elevation: 3.0,
      ),
      body:
   institutes.length == 0
          ? Center(
              child: Text(
                "No Reviews Yet, Lets Add One",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
              ),
            )
          : Container(
              padding: EdgeInsets.symmetric(horizontal: 5.0, vertical: 0.0),
              margin: EdgeInsets.only(top: 0.0, bottom: 0.0, right: 0.0),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30.0),
                      topRight: Radius.circular(30.0))),
              child: ClipRRect(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30.0),
                    topRight: Radius.circular(30.0)),
                child: ListView.builder(
                  itemCount: institutes.length,
                  itemBuilder: (BuildContext context, int index) {
                    final item = institutes[index];
                    return GestureDetector(
                      child: Container(
                        // width: 300,
                        margin: EdgeInsets.only(top: 5.0, bottom: 5.0),
                        padding: EdgeInsets.symmetric(
                            horizontal: 10.0, vertical: 10.0),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border(
                                bottom: BorderSide(color: Colors.black12))),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                CircleAvatar(
                                  radius: 30.0,
                                 backgroundColor: Colors.green,
                              child: Icon(
                                Icons.person,
                                color: Colors.white,
                                size: 25,

                              ),
                                ),
                                SizedBox(
                                  width: 10.0,
                                ),
                                Container(
                                    width: MediaQuery.of(context).size.width *
                                        0.40,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Text(
                                          'Customer '+item.user,
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 18.0,
                                              fontWeight: FontWeight.bold),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        SizedBox(
                                          height: 7.0,
                                        ),
                                         
                                                RatingBar.readOnly(
                      //onRatingChanged: (rating) => setState(()=>rating = rating),
                      filledIcon: Icons.star,
                      initialRating: double.parse(item.rate),
                      emptyIcon: Icons.star_border,
                      halfFilledIcon: Icons.star_half,
                      isHalfAllowed: false,
                      filledColor: Colors.orange,
                      emptyColor: Colors.orangeAccent,
                      halfFilledColor: Colors.orangeAccent,
                      size: 28,
                    ) 
                                        
                                      ],
                                    ))
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              )),
    
    );
  }

  @override
  void initState() {
    super.initState();
    getInstitutes(context);
  }

  getInstitutes(context) async {
    setState(() {});

     
    Future<dynamic> response = apiInterface.getReview(widget.inst_id);

    response.then((action) async {
      print(action.toString());
      if (action != null) {
        Map data = jsonDecode(action.toString());
        if (data["status"] == "200") {
          List<dynamic> list = data['result'];
          for (int i = 0; i < list.length; i++) {
            ReviewItem notificationItem = ReviewItem.fromMap(list[i]);
            institutes.add(notificationItem);
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