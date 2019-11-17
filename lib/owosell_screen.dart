import 'package:flutter/material.dart';
import 'package:owomark/models/transaction_model.dart';
import 'package:owomark/widgets/mybooks.dart';
import 'package:owomark/widgets/transaction.dart';

import 'dashboard_screen.dart';
import 'models/mybook_model.dart';

class OwosellScreen extends StatefulWidget {
  @override
  _OwosellScreenState createState() => _OwosellScreenState();
}

class _OwosellScreenState extends State<OwosellScreen> {

  int _currentTabIndex = 0;
  var controller1 = TextEditingController();
  var controller2 = TextEditingController();
  var controller3 = TextEditingController();
  var controller4 = TextEditingController();
  var controller5 = TextEditingController();
  var controller6 = TextEditingController();
  var controller7 = TextEditingController();
  var controller8 = TextEditingController();

  Widget _savebutton() {
    return RaisedButton(
        color: Colors.blue,
        padding: EdgeInsets.all(
          10.0,
        ),
        shape: RoundedRectangleBorder(
            borderRadius: new BorderRadius.circular(30.0),
            side: BorderSide(color: Colors.blue)),
        highlightColor: Colors.black,
        child: new Text(
          'Submit',
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
        onPressed: () {});
  }

  Widget _rechargeButton() {
    return RaisedButton(
        color: Colors.blue,
        padding: EdgeInsets.all(
          15.0,
        ),
        shape: RoundedRectangleBorder(
            borderRadius: new BorderRadius.circular(30.0),
            side: BorderSide(color: Colors.blue)),
        highlightColor: Colors.black,
        child: new Text(
          'Recharge',
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
        onPressed: () {});
  }

  Widget _nameField() {
    return new TextField(
      controller: this.controller1,
      decoration: new InputDecoration(
        hintText: "Book Title",
        labelText: "Title",
        labelStyle: new TextStyle(color: const Color(0xFF424242)),
        border: new OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
      onChanged: (text) => setState(() {}),
    );
  }

  Widget _pubField() {
    return new TextField(
      controller: this.controller2,
      decoration: new InputDecoration(
        hintText: "Book Publication",
        labelText: "Publicataion",
        labelStyle: new TextStyle(color: const Color(0xFF424242)),
        border: new OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
      onChanged: (text) => setState(() {}),
    );
  }

  Widget _mrpField() {
    return new TextField(
      controller: this.controller3,
      decoration: new InputDecoration(
        hintText: "MRP",
        labelText: "MRP Amount",
        labelStyle: new TextStyle(color: const Color(0xFF424242)),
        border: new OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
      onChanged: (text) => setState(() {}),
    );
  }

  Widget _authField() {
    return new TextField(
      controller: this.controller4,
      decoration: new InputDecoration(
        hintText: "Author",
        labelText: "Book Author",
        labelStyle: new TextStyle(color: const Color(0xFF424242)),
        border: new OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
      onChanged: (text) => setState(() {}),
    );
  }

  Widget _buypField() {
    return new TextField(
      controller: this.controller5,
      decoration: new InputDecoration(
        hintText: "Buy Price",
        labelText: "Book Buy Price",
        labelStyle: new TextStyle(color: const Color(0xFF424242)),
        border: new OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
      onChanged: (text) => setState(() {}),
    );
  }

  Widget _aboutField() {
    return new TextField(
      controller: this.controller6,
      decoration: new InputDecoration(
        hintText: "About",
        labelText: "Book About",
        labelStyle: new TextStyle(color: const Color(0xFF424242)),
        border: new OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
      onChanged: (text) => setState(() {}),
    );
  }

  Widget _pickField() {
    return new TextField(
      controller: this.controller7,
      decoration: new InputDecoration(
        hintText: "Pickup",
        labelText: "Book Pickup Location",
        labelStyle: new TextStyle(color: const Color(0xFF424242)),
        border: new OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
      onChanged: (text) => setState(() {}),
    );
  }

  Widget _coupontextField() {
    return new TextField(
      controller: this.controller8,
      decoration: new InputDecoration(
        hintText: "Type coupon code",
        labelText: "Coupon Code",
        labelStyle: new TextStyle(color: const Color(0xFF424242)),
        border: new OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
      onChanged: (text) => setState(() {}),
    );
  }

  @override
  Widget build(BuildContext context) {
    final _kTabPages = <Widget>[
        Container(
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

      ListView(
        padding: EdgeInsets.all(20.0),
        children: <Widget>[
          SizedBox(height: 20,),
          CircleAvatar(
            radius: 35,
            backgroundColor: Colors.blue,
            child: Icon(Icons.add,
              color: Colors.white, size: 30,),
          ),
          SizedBox(
            height: 20,
          ),

          Text('Add your Book ',
            style: TextStyle(
              fontSize: 16,
              fontFamily: 'maven_black',
              color: Colors.black87,
            ),),
          SizedBox(
            height: 10,
          ),

          _nameField(),
          SizedBox(
            height: 20,
          ),
          _pubField(),
          SizedBox(
            height: 20,
          ),
          _mrpField(),
          SizedBox(
            height: 20,
          ),
          _authField(),
          SizedBox(
            height: 20,
          ),
          _buypField(),
          SizedBox(
            height: 20,
          ),
          _pickField(),
          SizedBox(
            height: 20,
          ),
          _aboutField(),
          SizedBox(
            height: 20,
          ),
          _savebutton()
        ],
      ),
      Column(
        children: <Widget>[

          MyBooks(),
        ],
      )
    ];

    final _kBottomNavBarItems = <BottomNavigationBarItem>[

      BottomNavigationBarItem(
        icon: Icon(Icons.collections_bookmark),
        title: Text('Owoseller'),
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.add_circle_outline),
        title: Text('Add New Book'),
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.book),
        title: Text('Your Books',
        ),
      )
    ];

    assert (_kTabPages.length == _kBottomNavBarItems.length);

    final bottomNavbar = BottomNavigationBar(
      items: _kBottomNavBarItems, currentIndex: _currentTabIndex,
      type: BottomNavigationBarType.fixed,
      onTap: (int index) {
        setState(() {
          _currentTabIndex = index;
        });
      },);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
            icon: Icon(Icons.arrow_back),
            iconSize: 30.0,
            color: Colors.black,
            onPressed: () =>
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => DashboardScreen(),
                  ),
                )),
        title: Text(
          'Owosell',
          style: TextStyle(color: Colors.black),
          //textAlign: TextAlign.center,
        ),
        elevation: 3.0,
      ),
      body: _kTabPages[_currentTabIndex],
      bottomNavigationBar: bottomNavbar,
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
         title:  Text("Buy Price : 130 Rs",
         style: TextStyle(fontSize: 16),),
         trailing: Icon(Icons.card_giftcard),
       ),
        ListTile(
          title:  Text("Location",
            style: TextStyle(fontSize: 16),),
          trailing: Icon(Icons.location_on),
        ),
        Divider(),

        ListTile(
          title:  Text("View More",
            style: TextStyle(fontSize: 16,fontFamily: 'maven_black'),),
          trailing: Icon(Icons.arrow_forward_ios),
        ),
      ],
    ),
    aspectRatio: 1 / 1,
  );
}

