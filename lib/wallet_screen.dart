import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:owomark/widgets/transaction.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:sweetalert/sweetalert.dart';

import 'api_interface.dart';
import 'dashboard_screen.dart';

class WalletScreen extends StatefulWidget {
  @override
  _WalletScreenState createState() => _WalletScreenState();
}

class _WalletScreenState extends State<WalletScreen> {
  ApiInterface apiInterface = new ApiInterface();
  Razorpay _razorpay;
  int _currentTabIndex = 0;
  var couponcode = TextEditingController();
  var amount = TextEditingController();

  Widget _savebutton() {
    return RaisedButton(
        color: Colors.green,
        padding: EdgeInsets.all(
          15.0,
        ),
        shape: RoundedRectangleBorder(
            borderRadius: new BorderRadius.circular(30.0),
            side: BorderSide(color: Colors.green)),
        highlightColor: Colors.black,
        child: new Text(
          'Add Money',
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
        onPressed: () {});
  }

  Widget _rechargeButton() {
    return RaisedButton(
        color: Colors.green,
        padding: EdgeInsets.all(
          15.0,
        ),
        shape: RoundedRectangleBorder(
            borderRadius: new BorderRadius.circular(30.0),
            side: BorderSide(color: Colors.green)),
        highlightColor: Colors.black,
        child: new Text(
          'Recharge',
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
        onPressed: () {
          if (couponcode.text != "") {
            couponRecharge(context);
          } else {
            Fluttertoast.showToast(
                msg: "Please enter coupon code",
                toastLength: Toast.LENGTH_SHORT);
          }
        });
  }

  Widget _citytextField() {
    return new TextField(
      controller: this.amount,
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
      controller: this.couponcode,
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

  /*

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _razorpay.clear();
  }
  void openCheckout() async{
    var options = {"key":"","amount":amount,"name":"Owomark","description":"Test Payment","prefill":{"contact":"","email":""},
      "external":["paytm"]
  };
    try{
      _razorpay.open(options);
    }catch(e){
      debugPrint(e);
    }
*/
  @override
  Widget build(BuildContext context) {
    final _kTabPages = <Widget>[
      ListView(
        padding: EdgeInsets.all(20.0),
        children: <Widget>[
          SizedBox(
            height: 20,
          ),
          CircleAvatar(
            radius: 35,
            backgroundColor: Colors.green,
            child: Icon(
              Icons.card_giftcard,
              color: Colors.white,
              size: 30,
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Text(
            'Recharge your wallet with Coupon ',
            style: TextStyle(
              fontSize: 16,
              color: Colors.black87,
            ),
          ),
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
          SizedBox(
            height: 20,
          ),
          CircleAvatar(
            radius: 35,
            backgroundColor: Colors.green,
            child: Icon(
              Icons.account_balance_wallet,
              color: Colors.white,
              size: 30,
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Text(
            'Available Balance ',
            style: TextStyle(
              fontSize: 16,
              color: Colors.black87,
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            'Rs. 200 ',
            style: TextStyle(
                fontSize: 18,
                // color: ,
                fontWeight: FontWeight.bold),
          ),
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

    final _kBottomNavBarItems = <BottomNavigationBarItem>[
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
        title: Text(
          'Transaction',
        ),
      )
    ];

    assert(_kTabPages.length == _kBottomNavBarItems.length);

    final bottomNavbar = BottomNavigationBar(
      items: _kBottomNavBarItems,
      currentIndex: _currentTabIndex,
      type: BottomNavigationBarType.fixed,
      onTap: (int index) {
        setState(() {
          _currentTabIndex = index;
        });
      },
    );

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

  couponRecharge(context) async {
    setState(() {});

    Future<dynamic> response =
        apiInterface.couponRecharge('1', couponcode.text);

    response.then((action) async {
      print(action.toString());
      if (action != null) {
        Map data = jsonDecode(action.toString());
        if (data["status"] == "200") {
          SweetAlert.show(
            context,
            title: 'Money Added !',
            subtitle: 'Your recharge has been successfull',
            style: SweetAlertStyle.success,
          );
          couponcode.text = "";
        } else {
          SweetAlert.show(
            context,
            title: 'Oops !',
            subtitle: 'Invalid coupon code',
            style: SweetAlertStyle.error,
          );
        }
      }
    }, onError: (value) {
      print(value);
    });
  }
}

void _handlePaymentSuccess(PaymentSuccessResponse response) {
  Fluttertoast.showToast(msg: "success" + response.paymentId);
}

void _handlePaymentError(PaymentFailureResponse response) {
  Fluttertoast.showToast(
      msg: "error" + response.code.toString() + response.message);
}

void _handleExternalWallet(ExternalWalletResponse response) {
  Fluttertoast.showToast(msg: "external wallet" + response.walletName);
}
