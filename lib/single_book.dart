import 'dart:convert';

import 'package:flutter/material.dart';

import 'api_interface.dart';
import 'dashboard_screen.dart';
import 'models/book_item.dart';

class SingleBook extends StatefulWidget {
  final String project_id;

  SingleBook({Key key, this.project_id}) : super(key: key);

  @override
  _SingleBookState createState() => _SingleBookState();
}

class _SingleBookState extends State<SingleBook> {
  ApiInterface apiInterface = new ApiInterface();

  //Event List
  List<BookItem> books = new List();

  String projecturl = 'http://owomark.com/owomarkapp/images/book/';

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
          'Book Details',
          style: TextStyle(color: Colors.black),
          //textAlign: TextAlign.center,
        ),
        elevation: 3.0,
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: ListView.builder(
            itemCount: books.length,
            itemBuilder: (BuildContext context, int index) {
              final item = books[index];

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
                        'Book Title',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                      trailing: Icon(Icons.arrow_forward_ios),
                    ),
                    ListTile(
                      title: Text(item.title),
                    ),
                    Divider(),
                    ListTile(
                      title: Text(
                        'Book Author',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                      trailing: Icon(Icons.arrow_forward_ios),
                    ),
                    ListTile(
                      title: Text(item.auth),
                    ),
                    Divider(),
                    ListTile(
                      title: Text(
                        'Publication',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                      trailing: Icon(Icons.arrow_forward_ios),
                    ),
                    ListTile(
                      title: Text(item.pub),
                    ),
                    Divider(),
                    ListTile(
                      title: Text(
                        'Book MRP',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                      trailing: Icon(Icons.arrow_forward_ios),
                    ),
                    ListTile(
                      title: Text(item.mrp),
                    ),
                    Divider(),
                    ListTile(
                      title: Text(
                        'Discount',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                      trailing: Icon(Icons.arrow_forward_ios),
                    ),
                    ListTile(
                      title: Text(item.discount),
                    ),
                    Divider(),
                    ListTile(
                      title: Text(
                        'Buy Price',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                      trailing: Icon(Icons.arrow_forward_ios),
                    ),
                    ListTile(
                      title: Text(
                        item.buy_price + " Rs",
                        style: TextStyle(color: Colors.orange, fontSize: 22),
                      ),
                    ),
                    Divider(),
                    ListTile(
                      title: Text(
                        'Pickup Location',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                      trailing: Icon(Icons.arrow_forward_ios),
                    ),
                    ListTile(
                      title: Text(item.pickup),
                    ),
                    Divider(),
                    ListTile(
                      title: Text(
                        'Contact Seller',
                        style: TextStyle(fontSize: 18, color: Colors.blue),
                      ),
                    ),
                    Divider(),
                    ListTile(
                      title: Text(item.fname + " " + item.lname),
                      trailing: Container(
                        child: Icon(Icons.email),
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

    Future<dynamic> response = apiInterface.getSingleBook(widget.project_id);

    response.then((action) async {
      print(action.toString());
      if (action != null) {
        Map data = jsonDecode(action.toString());
        if (data["status"] == "200") {
          List<dynamic> list = data['result'];
          for (int i = 0; i < list.length; i++) {
            BookItem notificationItem = BookItem.fromMap(list[i]);
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
}
