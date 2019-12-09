import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:owomark/cart_screen.dart';
import 'package:owomark/competitions.dart';
import 'package:owomark/create_profile.dart';
import 'package:owomark/event_screen.dart';
import 'package:owomark/home_screen.dart';
import 'package:owomark/models/category_item.dart';
import 'package:owomark/models/slider_item.dart';
import 'package:owomark/news_feed.dart';
import 'package:owomark/notification_screen.dart';
import 'package:owomark/products_screen.dart';
import 'package:owomark/projects.dart';
import 'package:owomark/quiz.dart';
import 'package:owomark/single_event.dart';
import 'package:owomark/single_institute.dart';
import 'package:owomark/single_pg.dart';
import 'package:owomark/single_product.dart';
import 'package:owomark/single_project.dart';
import 'package:owomark/ticket_screen.dart';
import 'package:owomark/type_category.dart';
import 'package:owomark/wallet_screen.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:sweetalert/sweetalert.dart';

import 'api_interface.dart';
import 'category_screen.dart';
import 'models/PgItem.dart';
import 'models/book_item.dart';
import 'models/competition_item.drt.dart';
import 'models/event_item.dart';
import 'models/institute_item.dart';
import 'models/project_item.dart';
import 'orders_screen.dart';
import 'owo_category.dart';

class DashboardScreen extends StatefulWidget {
  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final GlobalKey<ScaffoldState> _scafflodKey = new GlobalKey<ScaffoldState>();

  ApiInterface apiInterface = new ApiInterface();

  //Category List
  List<CategoryItem> notifications = new List();

  //Book List
  List<BookItem> books = new List();

  //Slider images

  List<SliderItem> images = new List();

  //Best deal List
  List<BookItem> deals = new List();

  //Event List
  List<EventItem> events = new List();

  //Competition List
  List<CompetitionItem> competitions = new List();

  //Projects List
  List<ProjectItem> projects = new List();

  //Pgs List
  List<PgItem> pgs = new List();

  //Institute List
  List<InstituteItem> institutes = new List();

  ProgressDialog pr;

  String categoryurl = 'http://owomark.com/owomarkapp/images/icon/';
  String producturl = 'http://owomark.com/owomarkapp/images/product/';
  String eventurl = 'http://owomark.com/owomarkapp/images/events/';
  String compurl = 'http://owomark.com/owomarkapp/images/competition/';
  String projurl = 'http://owomark.com/owomarkapp/images/projects/';
  String pgurl = 'http://owomark.com/owomarkapp/images/pg/';
  String insturl = 'http://owomark.com/owomarkapp/images/classes/';
  String sliderurl = 'http://owomark.com/owomarkapp/images/offer/';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: new Drawer(
          child: ListView(
            children: <Widget>[
              UserAccountsDrawerHeader(
                accountName: Text(
                  'Welcome, Vaibhav Mehta',
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
                accountEmail: Text(
                  'vaibhav.18@gmail.com',
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
                currentAccountPicture: CircleAvatar(
                  backgroundColor: Colors.white,
                  child: Text(
                    'V',
                    style: TextStyle(
                        color: Colors.green,
                        fontSize: 28,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              ListTile(
                title: Text(
                  'Institutes',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                trailing: Icon(Icons.collections_bookmark),
                onTap: () => Navigator.push(
                    context, MaterialPageRoute(builder: (_) => TypeCategory())),
              ),
              ListTile(
                title: Text(
                  'Wallet',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                trailing: Icon(Icons.account_balance_wallet),
                onTap: () => Navigator.push(
                    context, MaterialPageRoute(builder: (_) => WalletScreen())),
              ),
              ListTile(
                title: Text(
                  'Owoquiz',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                trailing: Icon(Icons.note),
                onTap: () => Navigator.push(
                    context, MaterialPageRoute(builder: (_) => QuizScreen())),
              ),
              Divider(),
              ListTile(
                title: Text(
                  'Owosell',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                trailing: Icon(Icons.compare_arrows),
                onTap: () => Navigator.push(
                    context, MaterialPageRoute(builder: (_) => OwoCategory())),
              ),
              ListTile(
                title: Text(
                  'Profile',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                trailing: Icon(Icons.person),
                onTap: () => Navigator.push(context,
                    MaterialPageRoute(builder: (_) => CreateProfile())),
              ),
              ListTile(
                title: Text(
                  'Messages',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                onTap: () => Navigator.push(
                    context, MaterialPageRoute(builder: (_) => HomeScreen())),
                trailing: Icon(Icons.email),
              ),
              ListTile(
                title: Text(
                  'Shopping cart',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                trailing: Icon(Icons.shopping_cart),
                onTap: () => Navigator.push(
                    context, MaterialPageRoute(builder: (_) => CartScreen())),
              ),
              Divider(),
              ListTile(
                title: Text(
                  'Your Orders',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                trailing: Icon(Icons.shopping_basket),
                onTap: () => Navigator.push(
                    context, MaterialPageRoute(builder: (_) => OrderScreen())),
              ),
              ListTile(
                title: Text(
                  'Your Tickets',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                trailing: Icon(Icons.card_giftcard),
                onTap: () => Navigator.push(
                    context, MaterialPageRoute(builder: (_) => TicketScreen())),
              ),
              Divider(),
              ListTile(
                title: Text(
                  'Notification',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                trailing: Icon(Icons.notifications),
                onTap: () => Navigator.push(context,
                    MaterialPageRoute(builder: (_) => NotificationScreen())),
              ),
              ListTile(
                title: Text(
                  'Logout',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                trailing: Icon(Icons.arrow_forward),
              ),
            ],
          ),
        ),
        backgroundColor: Colors.white,
        key: _scafflodKey,
        appBar: AppBar(
          backgroundColor: Colors.white,
          leading: IconButton(
              icon: Icon(Icons.menu),
              iconSize: 30.0,
              color: Colors.black,
              onPressed: () => _scafflodKey.currentState.openDrawer()),
          title: Text(
            'Owomark',
            style: TextStyle(
              color: Colors.black,
            ),
            textAlign: TextAlign.center,
            //textAlign: TextAlign.center,
          ),
          elevation: 4.0,
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.search),
              iconSize: 30.0,
              color: Colors.grey,
              onPressed: () {
                SweetAlert.show(context,
                    title: 'Thank You !',
                    subtitle: 'your order has been placed',
                    style: SweetAlertStyle.success, onPress: (bool isConfirm) {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => OrderScreen(),
                      ));

                  return false;
                });
              },
            ),
            IconButton(
                icon: Icon(Icons.shopping_cart),
                iconSize: 30.0,
                color: Colors.grey,
                onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => CartScreen(),
                      ),
                    )),
          ],
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.all(10.0),
          child: Column(
            children: <Widget>[
              images.length == 0 ? Text('') : buildSlider(),
              notifications.length == 0
                  ? Center(
                      child: Text(
                        "No Data Found",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w400),
                      ),
                    )
                  : Container(
                      height: 115,
                      child: ListView.builder(
                        itemCount: notifications.length,
                        scrollDirection: Axis.horizontal,
                        padding: EdgeInsets.only(left: 10.0),
                        itemBuilder: (BuildContext context, int index) {
                          final item = notifications[index];
                          return GestureDetector(
                            onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => Category(panel_id: item.id),
                              ),
                            ),
                            child: Padding(
                              padding: EdgeInsets.all(10.0),
                              child: Column(
                                children: <Widget>[
                                  CircleAvatar(
                                    radius: 35.0,
                                    backgroundImage: NetworkImage(
                                        categoryurl + item.imageUrl),
                                  ),
                                  SizedBox(
                                    height: 6.0,
                                  ),
                                  Text(
                                    item.name,
                                    style: TextStyle(
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    "Books",
                    style: TextStyle(
                        fontSize: 18,
                        color: Colors.black,
                        fontWeight: FontWeight.bold),
                  ),
                  GestureDetector(
                    child: Text("All"),
                    onTap: () => Navigator.push(context,
                        MaterialPageRoute(builder: (_) => ProductsScreen())),
                  )
                ],
              ),
              SizedBox(
                height: 20,
              ),
              books.length == 0
                  ? Center(
                      child: Text(
                        "No Data Found",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w400),
                      ),
                    )
                  : Container(
                      height: 100,
                      child: ListView.builder(
                        itemCount: books.length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (BuildContext context, int index) {
                          final item = books[index];

                          return GestureDetector(
                            child: makeCategory(
                                image: producturl + item.imageUrl,
                                title: item.amount),
                            onTap: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => SingleProduct(
                                          product_id: item.id,
                                        ))),
                          );
                        },
                      ),
                    ),
              SizedBox(
                height: 20,
              ),
              images.length == 0 ? Text('') : buildSlider2(),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    "Best Deals",
                    style: TextStyle(
                        fontSize: 18,
                        color: Colors.black,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              deals.length == 0
                  ? Center(
                      child: Text(
                        "No Data Found",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w400),
                      ),
                    )
                  : Container(
                      height: 100,
                      child: ListView.builder(
                        itemCount: deals.length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (BuildContext context, int index) {
                          final item = deals[index];

                          return GestureDetector(
                            child: makeBestCategory(
                                image: producturl + item.imageUrl,
                                title: item.discount),
                            onTap: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => SingleProduct(
                                          product_id: item.id,
                                        ))),
                          );
                        },
                      ),
                    ),
              SizedBox(
                height: 40,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    "Institutes",
                    style: TextStyle(
                        fontSize: 18,
                        color: Colors.black,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              institutes.length == 0
                  ? Center(
                      child: Text(
                        "No Data Found",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w400),
                      ),
                    )
                  : Container(
                      height: 130,
                      child: ListView.builder(
                        itemCount: institutes.length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (BuildContext context, int index) {
                          final item = institutes[index];

                          return GestureDetector(
                            child: makeInstitute(
                                image: insturl + item.imageUrl,
                                title: item.name),
                            onTap: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => SingleInstitute(
                                          project_id: item.id,
                                        ))),
                          );
                        },
                      ),
                    ),
              SizedBox(
                height: 40,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    "Events",
                    style: TextStyle(
                        fontSize: 18,
                        color: Colors.black,
                        fontWeight: FontWeight.bold),
                  ),
                  GestureDetector(
                    child: Text("All"),
                    onTap: () => Navigator.push(context,
                        MaterialPageRoute(builder: (_) => EventScreen())),
                  )
                ],
              ),
              SizedBox(
                height: 20,
              ),
              events.length == 0
                  ? Center(
                      child: Text(
                        "No Data Found",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w400),
                      ),
                    )
                  : Container(
                      height: 130,
                      child: ListView.builder(
                        itemCount: events.length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (BuildContext context, int index) {
                          final item = events[index];

                          return GestureDetector(
                            child: makeActivity(
                                image: eventurl + item.imageUrl,
                                title: item.name),
                            onTap: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => SingleEvent(
                                          event_id: item.id,
                                        ))),
                          );
                        },
                      )),
              SizedBox(
                height: 40,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    "Competitions",
                    style: TextStyle(
                        fontSize: 18,
                        color: Colors.black,
                        fontWeight: FontWeight.bold),
                  ),
                  GestureDetector(
                    child: Text("All"),
                    onTap: () => Navigator.push(context,
                        MaterialPageRoute(builder: (_) => Competitions())),
                  )
                ],
              ),
              SizedBox(
                height: 20,
              ),
              competitions.length == 0
                  ? Center(
                      child: Text(
                        "No Competition Found",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w400),
                      ),
                    )
                  : Container(
                      height: 130,
                      child: ListView.builder(
                        itemCount: competitions.length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (BuildContext context, int index) {
                          final item = competitions[index];

                          return GestureDetector(
                              onTap: () => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (_) => NewsFeed(
                                            comp_id: item.id,
                                          ))),
                              child: makepg(
                                  image: compurl + item.imageUrl,
                                  title: item.name));
                        },
                      ),
                    ),
              SizedBox(
                height: 40,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    "Projects",
                    style: TextStyle(
                        fontSize: 18,
                        color: Colors.black,
                        fontWeight: FontWeight.bold),
                  ),
                  GestureDetector(
                    child: Text("All"),
                    onTap: () => Navigator.push(
                        context, MaterialPageRoute(builder: (_) => Projects())),
                  )
                ],
              ),
              SizedBox(
                height: 20,
              ),
              projects.length == 0
                  ? Center(
                      child: Text(
                        "No Data Found",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w400),
                      ),
                    )
                  : Container(
                      height: 130,
                      child: ListView.builder(
                        itemCount: projects.length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (BuildContext context, int index) {
                          final item = projects[index];

                          return GestureDetector(
                            child: makeActivity(
                                image: projurl + item.imageUrl,
                                title: item.name),
                            onTap: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => SingleProject(
                                          project_id: item.id,
                                        ))),
                          );
                        },
                      )),
              SizedBox(
                height: 40,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    "Near By Pg",
                    style: TextStyle(
                        fontSize: 18,
                        color: Colors.black,
                        fontWeight: FontWeight.bold),
                  ),
                  GestureDetector(
                    child: Text("All"),
                    onTap: () => Navigator.push(
                        context, MaterialPageRoute(builder: (_) => Projects())),
                  )
                ],
              ),
              SizedBox(
                height: 20,
              ),
              pgs.length == 0
                  ? Center(
                      child: Text(
                        "No Data Found",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w400),
                      ),
                    )
                  : Container(
                      height: 130,
                      child: ListView.builder(
                        itemCount: pgs.length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (BuildContext context, int index) {
                          final item = pgs[index];

                          return GestureDetector(
                            child: makeActivity(
                                image: pgurl + item.imageUrl, title: item.name),
                            onTap: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => SinglePg(
                                          event_id: item.id,
                                        ))),
                          );
                        },
                      )),
            ],
          ),
        ));
  }

  @override
  void initState() {
    super.initState();
    getSlider(context);
    getNotifications(context);
    getDashboardBooks(context);
    getDashboardEvents(context);
    getCompetitions(context);
    getBestDeals(context);
    getProjects(context);
    getInstitutes(context);
    getPg(context);
  }

  getNotifications(context) async {
    setState(() {});

    Future<dynamic> response = apiInterface.getNotification('1');

    response.then((action) async {
      // print(action.toString());
      if (action != null) {
        Map data = jsonDecode(action.toString());
        if (data["status"] == "200") {
          List<dynamic> list = data['result'];
          for (int i = 0; i < list.length; i++) {
            CategoryItem notificationItem = CategoryItem.fromMap(list[i]);
            notifications.add(notificationItem);
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

  //BEst Dels Api

  getBestDeals(context) async {
    setState(() {});

    Future<dynamic> response = apiInterface.getDeals('1');

    response.then((action) async {
      // print(action.toString());
      if (action != null) {
        Map data = jsonDecode(action.toString());
        if (data["status"] == "200") {
          List<dynamic> list = data['result'];
          for (int i = 0; i < list.length; i++) {
            BookItem notificationItem = BookItem.fromMap(list[i]);
            deals.add(notificationItem);
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

  //BEst Dels Api

  getSlider(context) async {
    setState(() {});

    Future<dynamic> response = apiInterface.getSlider('1');

    response.then((action) async {
      // print(action.toString());
      if (action != null) {
        Map data = jsonDecode(action.toString());
        if (data["status"] == "200") {
          List<dynamic> list = data['result'];
          for (int i = 0; i < list.length; i++) {
            SliderItem notificationItem = SliderItem.fromMap(list[i]);
            images.add(notificationItem);
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

  //Projects Api

  getProjects(context) async {
    setState(() {});

    Future<dynamic> response = apiInterface.getProjects('1');

    response.then((action) async {
      // print(action.toString());
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

  //Competitions Api

  getCompetitions(context) async {
    setState(() {});

    Future<dynamic> response = apiInterface.getCompetition('1');

    response.then((action) async {
      //print(action.toString());
      if (action != null) {
        Map data = jsonDecode(action.toString());
        if (data["status"] == "200") {
          List<dynamic> list = data['result'];
          for (int i = 0; i < list.length; i++) {
            CompetitionItem notificationItem = CompetitionItem.fromMap(list[i]);
            competitions.add(notificationItem);
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

  //Books Api

  getDashboardBooks(context) async {
    setState(() {});

    Future<dynamic> response = apiInterface.getDashboardBooks('1');

    response.then((action) async {
      // print(action.toString());
      if (action != null) {
        Map data = jsonDecode(action.toString());
        if (data["status"] == "200") {
          List<dynamic> list = data['result'];
          for (int i = 0; i < list.length; i++) {
            BookItem bookItem = BookItem.fromMap(list[i]);
            books.add(bookItem);
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

  //Events API

  getDashboardEvents(context) async {
    setState(() {});

    Future<dynamic> response = apiInterface.getDashboardEvents('1');

    response.then((action) async {
      //print(action.toString());
      if (action != null) {
        Map data = jsonDecode(action.toString());
        if (data["status"] == "200") {
          List<dynamic> list = data['result'];
          for (int i = 0; i < list.length; i++) {
            EventItem eventItem = EventItem.fromMap(list[i]);
            events.add(eventItem);
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

  //Events API

  getPg(context) async {
    setState(() {});

    Future<dynamic> response = apiInterface.getPgs('ahmedabad');

    response.then((action) async {
      print(action.toString());

      if (action != null) {
        Map data = jsonDecode(action.toString());
        if (data["status"] == "200") {
          List<dynamic> list = data['result'];
          for (int i = 0; i < list.length; i++) {
            PgItem eventItem = PgItem.fromMap(list[i]);
            pgs.add(eventItem);
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

  getInstitutes(context) async {
    setState(() {});

    Future<dynamic> response = apiInterface.getInstitutes('1');

    response.then((action) async {
      print(action.toString());
      if (action != null) {
        Map data = jsonDecode(action.toString());
        if (data["status"] == "200") {
          List<dynamic> list = data['result'];
          for (int i = 0; i < list.length; i++) {
            InstituteItem eventItem = InstituteItem.fromMap(list[i]);
            institutes.add(eventItem);
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

  Widget makeCategory({String image, String title}) {
    return AspectRatio(
      child: Container(
        margin: EdgeInsets.only(right: 5),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(0),
            image:
                DecorationImage(image: NetworkImage(image), fit: BoxFit.cover)),
        child: Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(0),
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
                    fontSize: 16),
              ),
            )),
      ),
      aspectRatio: 2 / 2.5,
    );
  }

  Widget makeProject({String image, String title}) {
    return AspectRatio(
      child: Container(
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
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16),
              ),
            )),
      ),
      aspectRatio: 5 / 2.5,
    );
  }

  Widget makeBestCategory({String image, String title}) {
    return AspectRatio(
      child: Container(
        margin: EdgeInsets.only(right: 5),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(0),
            image:
                DecorationImage(image: NetworkImage(image), fit: BoxFit.cover)),
        child: Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(0),
                gradient: LinearGradient(begin: Alignment.bottomRight, colors: [
                  Colors.black.withOpacity(.8),
                  Colors.black.withOpacity(.2),
                ])),
            child: Align(
              alignment: Alignment.bottomLeft,
              child: Text(
                title + " % Off",
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16),
              ),
            )),
      ),
      aspectRatio: 2 / 2.5,
    );
  }

  Widget makeInstitute({String image, String title}) {
    return AspectRatio(
      child: Container(
        margin: EdgeInsets.only(right: 20),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            image:
                DecorationImage(image: NetworkImage(image), fit: BoxFit.cover)),
        child: Container(
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              gradient: LinearGradient(begin: Alignment.bottomRight, colors: [
                Colors.black.withOpacity(.8),
                Colors.black.withOpacity(.2),
              ])),
          child: Row(
            children: <Widget>[
              Align(
                alignment: Alignment.bottomLeft,
                child: Text(
                  title,
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16),
                ),
              ),
              SizedBox(
                height: 5,
              ),
            ],
          ),
        ),
      ),
      aspectRatio: 5 / 2.5,
    );
  }

  Widget makeActivity({String image, String title}) {
    return AspectRatio(
      child: Container(
        margin: EdgeInsets.only(right: 20),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            image:
                DecorationImage(image: NetworkImage(image), fit: BoxFit.cover)),
        child: Container(
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              gradient: LinearGradient(begin: Alignment.bottomRight, colors: [
                Colors.black.withOpacity(.8),
                Colors.black.withOpacity(.2),
              ])),
          child: Row(
            children: <Widget>[
              Align(
                alignment: Alignment.bottomLeft,
                child: Text(
                  title,
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16),
                ),
              ),
              SizedBox(
                height: 5,
              ),
            ],
          ),
        ),
      ),
      aspectRatio: 5 / 2.5,
    );
  }

  Widget makepg({String image, String title}) {
    return AspectRatio(
      child: Container(
        margin: EdgeInsets.only(right: 20),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            image:
                DecorationImage(image: NetworkImage(image), fit: BoxFit.cover)),
        child: Container(
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              gradient: LinearGradient(begin: Alignment.bottomRight, colors: [
                Colors.black.withOpacity(.8),
                Colors.black.withOpacity(.2),
              ])),
          child: Row(
            children: <Widget>[
              Align(
                alignment: Alignment.bottomLeft,
                child: Text(
                  title,
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16),
                ),
              ),
              SizedBox(
                height: 5,
              ),
            ],
          ),
        ),
      ),
      aspectRatio: 4 / 2,
    );
  }

  Widget buildSlider() {
    return Container(
      height: 140,
      child: Swiper(
        itemCount: images.length,
        viewportFraction: 1.0,
        scale: 1.0,
        pagination: SwiperPagination(),
        autoplay: true,
        itemBuilder: (BuildContext context, int index) {
          return ClipRRect(
            borderRadius: BorderRadius.circular(5.0),
            child: Image.network(
              sliderurl + images[index].imageUrl,
              fit: BoxFit.cover,
            ),
          );
        },
      ),
    );
  }

  Widget buildSlider2() {
    return GestureDetector(
      child: Container(
        height: 150,
        child: Swiper(
          itemCount: images.length,
          viewportFraction: 0.8,
          scale: 0.9,
          pagination: SwiperPagination(),
          autoplay: true,
          itemBuilder: (BuildContext context, int index) {
            return ClipRRect(
              borderRadius: BorderRadius.circular(5.0),
              child: Image.network(
                sliderurl + images[index].imageUrl,
                fit: BoxFit.cover,
              ),
            );
          },
        ),
      ),
      onTap: () => Navigator.push(
          context, MaterialPageRoute(builder: (_) => Category(panel_id: '1'))),
    );
  }
}
