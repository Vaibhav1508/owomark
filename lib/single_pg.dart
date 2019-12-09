import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:owomark/event_pament.dart';
import 'package:owomark/models/PgItem.dart';
import 'package:progress_dialog/progress_dialog.dart';

import 'api_interface.dart';
import 'dashboard_screen.dart';

class SinglePg extends StatefulWidget {
  final String event_id;

  SinglePg({Key key, this.event_id}) : super(key: key);

  @override
  _SinglePgState createState() => _SinglePgState();
}

class _SinglePgState extends State<SinglePg> {
  GlobalKey<ScaffoldState> key = new GlobalKey();

  ProgressDialog pr;

  int amount;

  String event;

  ApiInterface apiInterface = new ApiInterface();

  //Event List
  List<PgItem> events = new List();

  String eventurl = 'http://owomark.com/owomarkapp/images/pg/';

  @override
  Widget build(BuildContext context) {
    pr = new ProgressDialog(context,
        type: ProgressDialogType.Normal, isDismissible: true, showLogs: true);

    pr.style(
        message: 'Please Wait...',
        borderRadius: 10.0,
        backgroundColor: Colors.white,
        progressWidget: CircularProgressIndicator(),
        elevation: 10.0,
        insetAnimCurve: Curves.easeInOut,
        progress: 0.0,
        maxProgress: 100.0,
        progressTextStyle: TextStyle(
            color: Colors.black, fontSize: 13.0, fontWeight: FontWeight.w400),
        messageTextStyle: TextStyle(
            color: Colors.black, fontSize: 19.0, fontWeight: FontWeight.w600));

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
          'Pg Details',
          style: TextStyle(color: Colors.black),
          //textAlign: TextAlign.center,
        ),
        elevation: 3.0,
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: ListView.builder(
            itemCount: events.length,
            itemBuilder: (BuildContext context, int index) {
              final item = events[index];

              return SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    Image.network(
                      eventurl + item.imageUrl,
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
                    ListTile(
                      title: Text(
                        'Description',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                      trailing: Icon(Icons.note),
                    ),
                    ListTile(
                      title: Text(item.desc),
                    ),
                    Divider(),
                    ListTile(
                      title: Text(
                        'Location',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                      trailing: Icon(Icons.add_location),
                    ),
                    ListTile(
                      title: Text(item.location),
                    ),
                    Divider(),
                    ListTile(
                      title: Text(
                        'Address',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                      trailing: Icon(Icons.location_on),
                    ),
                    ListTile(
                      title: Text(item.address),
                    ),
                    Divider(),
                    ListTile(
                      title: Text(
                        'Rent Amount ',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                      trailing: Icon(Icons.arrow_forward_ios),
                    ),
                    ListTile(
                      title: Text(
                        item.price + ' Rs',
                        style: TextStyle(color: Colors.orange, fontSize: 22),
                      ),
                    ),
                    Divider(),
                    RaisedButton(
                        color: Colors.green,
                        padding: EdgeInsets.all(
                          10.0,
                        ),
                        shape: RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(5.0),
                            side: BorderSide(color: Colors.green)),
                        highlightColor: Colors.black,
                        child: new Text(
                          'Contact Owner',
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                        onPressed: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => EventPayment(
                                      amount: amount,
                                      event: event,
                                    ))))
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

    Future<dynamic> response = apiInterface.getPgByIds(widget.event_id);

    response.then((action) async {
      print(action.toString());
      if (action != null) {
        Map data = jsonDecode(action.toString());
        if (data["status"] == "200") {
          List<dynamic> list = data['result'];
          for (int i = 0; i < list.length; i++) {
            PgItem notificationItem = PgItem.fromMap(list[i]);

            events.add(notificationItem);

            setState(() {
              amount = int.parse(events[i].price);
              event = events[i].id;
            });
          }
        } else {
          print('error');
        }
      }
    }, onError: (value) {
      print(value);
    });
  }
}
