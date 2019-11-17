import 'package:flutter/material.dart';
import 'package:owomark/widgets/order_item.dart';
import 'package:owomark/widgets/transaction.dart';

import 'dashboard_screen.dart';

class WalletScreen extends StatefulWidget {
  @override
  _WalletScreenState createState() => _WalletScreenState();
}

class _WalletScreenState extends State<WalletScreen> {

  int _currentTabIndex = 0;
  var controller6 = TextEditingController();


  Widget _savebutton() {
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
          'Add Money',
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

  Widget _citytextField() {
    return new TextField(
      controller: this.controller6,
      decoration: new InputDecoration(
        hintText: "Amount to be added",
        labelText: "Amount",
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
      controller: this.controller6,
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
      ListView(
        padding: EdgeInsets.all(20.0),
        children: <Widget>[
          SizedBox(height: 20,),
          CircleAvatar(
            radius: 35,
            backgroundColor: Colors.blue,
            child: Icon(Icons.card_giftcard,
              color: Colors.white,size: 30,),
          ),
          SizedBox(
            height: 20,
          ),

          Text('Recharge your wallet with Coupon ',
            style: TextStyle(
              fontSize: 16,
              color: Colors.black87,
                fontFamily: 'maven_black'
            ),),


          SizedBox(
            height: 20,
          ),

          _coupontextField(),
          SizedBox(
            height: 20,
          ),
          _rechargeButton()
        ],
      ),
      ListView(
        padding: EdgeInsets.all(20.0),
        children: <Widget>[
          SizedBox(height: 20,),
          CircleAvatar(
            radius: 35,
            backgroundColor: Colors.blue,
            child: Icon(Icons.account_balance_wallet,
            color: Colors.white,size: 30,),
          ),
          SizedBox(
            height: 20,
          ),

          Text('Available Balance ',
          style: TextStyle(
            fontSize: 16,
            color: Colors.black87,
          ),),
          SizedBox(
            height: 10,
          ),
          Text('Rs. 200 ',
            style: TextStyle(
                fontSize: 18,
               // color: ,
                fontWeight: FontWeight.bold
            ),),


          SizedBox(
            height: 20,
          ),

          _citytextField(),
          SizedBox(
            height: 20,
          ),
          _savebutton()
        ],
      ),
      Column(
        children: <Widget>[

          Transaction(),
        ],
      )
    ];

    final _kBottomNavBarItems = <BottomNavigationBarItem> [

      BottomNavigationBarItem(
        icon: Icon(Icons.card_giftcard),
        title: Text('Recharge Coupon'),
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.add_circle_outline),
        title: Text('Add Money'),
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.receipt),
        title: Text('Transaction',
        ),
      )
    ];

    assert (_kTabPages.length == _kBottomNavBarItems.length);

    final bottomNavbar = BottomNavigationBar(items: _kBottomNavBarItems,currentIndex: _currentTabIndex,
      type: BottomNavigationBarType.fixed,
    onTap: (int index){
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
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => DashboardScreen(),
              ),
            )),
        title: Text(
          'Your Wallet',
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
