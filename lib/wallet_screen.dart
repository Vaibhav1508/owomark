import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:owomark/widgets/transaction.dart';
import 'package:owomark/widgets/widthraw.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sweetalert/sweetalert.dart';

import 'api_interface.dart';
import 'dashboard_screen.dart';
import 'models/users_item.dart';

class WalletScreen extends StatefulWidget {
  @override
  _WalletScreenState createState() => _WalletScreenState();
}

class _WalletScreenState extends State<WalletScreen> {

   String balance="0";

   List<UsersItem> user = new List<UsersItem>();
                
  ApiInterface apiInterface = new ApiInterface();
  Razorpay _razorpay;
  int _currentTabIndex = 0;
  var couponcode = TextEditingController();
  var amount = TextEditingController();
  var wamount = TextEditingController();
  var phone = TextEditingController();

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
        onPressed: () {
          openCheckout();
        });
  }

   Widget widthraw() {
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
          'Widthraw',
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
        onPressed: () {
          if(wamount.text!=""||phone.text!=""){
            if(int.parse(wamount.text)<200){
          Fluttertoast.showToast(msg: "minimum amount to widthraw is 200 Rs",toastLength: Toast.LENGTH_SHORT);

            }else{
              widthrawMoney(context, phone.text, wamount.text);
              phone.text = "";
              wamount.text = "";
            }
          }else{
          Fluttertoast.showToast(msg: "Please provide details",toastLength: Toast.LENGTH_SHORT);
          }
        });
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


    Widget _amountTextField() {
    return new TextField(
      controller: this.wamount,
      decoration: new InputDecoration(
        hintText: "Amount to be widthrawn",
        labelText: "Amount",
        labelStyle: new TextStyle(color: const Color(0xFF424242)),
        border: new OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
      onChanged: (text) => setState(() {}),
    );
  }

   Widget _numberTextField() {
    return new TextField(
      controller: this.phone,
      decoration: new InputDecoration(
        hintText: "Your PhonePe / Paytm Number",
        labelText: "PhonePe / Paytm Number",
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


  

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setBalance();
    getProfille(context);

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
    int amt = int.parse(amount.text)*100;
    var options = {"key":"rzp_test_fgKuaSO7wxrqCK","amount":amt,"name":"Owomark","description":"Test Payment","prefill":{"contact":"","email":""},
      "external":{
        'wallet':['paytm']
      }
  };
    try{
      _razorpay.open(options);
    }catch(e){
      debugPrint(e);
    }
  }


  setBalance()async{
final prefs = await SharedPreferences.getInstance();
     balance = prefs.getString('balance');
  }
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
            'Rs. '+ balance,
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
          _savebutton(),
           SizedBox(
            height: 20,
          ),
          ListTile(
            title: Text('Widthraw Money',style: TextStyle(fontSize: 20,),),
            trailing: Icon(Icons.arrow_forward_ios),
          ),
            SizedBox(
            height: 20,
          ),

          _amountTextField(),
            SizedBox(
            height: 20,
          ),
          _numberTextField(),
            SizedBox(
            height: 20,
          ),
          widthraw()
          
        ],
        
      ),
      Column(
        children: <Widget>[
          Transaction(),
        ],

      ),
      Column(
        children: <Widget>[
          WidthrawScreen(),
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
        
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.attach_money),
        title: Text(
          'Widthrawal',
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

    String user = '';

    final prefs = await SharedPreferences.getInstance();
     user = prefs.getString('user');
  

    Future<dynamic> response =
        apiInterface.couponRecharge(user,couponcode.text);

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
          amount.text = "";
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

   getProfille(context) async {
    setState(() {});

     String users = '';

    final prefs = await SharedPreferences.getInstance();
     users = prefs.getString('user');
  

    Future<dynamic> response = apiInterface.getProfile(users);

    response.then((action) async {
      print(action.toString());
      if (action != null) {
        Map data = jsonDecode(action.toString());
        if (data["status"] == "200") {
          List<dynamic> list = data['result'];
          for (int i = 0; i < list.length; i++) {
            UsersItem notificationItem = UsersItem.fromMap(list[i]);
            user.add(notificationItem);
          }
          setState(() {
            for (int i = 0; i < user.length; i++) {
              balance = user[i].balance;
            }
          });
        } else {
          print('error');
        }
      }
    }, onError: (value) {
      print(value);
    });
  }


   addMoney(context,String amounts) async {
    setState(() {});

    String user = '';

    final prefs = await SharedPreferences.getInstance();
     user = prefs.getString('user');
  

    Future<dynamic> response =
        apiInterface.addMoney(user,amounts);

    response.then((action) async {
      print(action.toString());
      if (action != null) {
        Map data = jsonDecode(action.toString());
        if (data["status"] == "200") {
          SweetAlert.show(
            context,
            title: 'Money Added !',
            subtitle: 'Money has been added to your wallet',
            style: SweetAlertStyle.success,
          );
          amount.text = "";
          getProfille(context);
        } else {
          SweetAlert.show(
            context,
            title: 'Oops !',
            subtitle: 'Try again later',
            style: SweetAlertStyle.error,
          );
        }
      }
    }, onError: (value) {
      print(value);
    });
  }

  widthrawMoney(context,String phone,String amount) async {
    setState(() {});

     String user = '';

    final prefs = await SharedPreferences.getInstance();
     user = prefs.getString('user');


    Future<dynamic> response =
        apiInterface.addWidthrawal(user,phone,amount);

    response.then((action) async {
      print(action.toString());
      if (action != null) {
        Map data = jsonDecode(action.toString());
        if (data["status"] == "200") {
          SweetAlert.show(
            context,
            title: 'Requested !',
            subtitle: 'Widthrawal requested successfully...',
            style: SweetAlertStyle.success,
          );
         getProfille(context);
        } else {
          SweetAlert.show(
            context,
            title: 'Oops !',
            subtitle: 'Insufficiant balance',
            style: SweetAlertStyle.error,
          );
        }
      }
    }, onError: (value) {
      print(value);
    });
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {

  addMoney(context,amount.text);
  
  
  Fluttertoast.showToast(msg: "Payment successfull");
  
}

}





void _handlePaymentError(PaymentFailureResponse response) {
  Fluttertoast.showToast(
      msg: "error" + response.code.toString() + response.message);
      BuildContext context;
            SweetAlert.show(
                  context,
            title: 'Oops !',
            subtitle: 'Payment Failed',
            style: SweetAlertStyle.error,
          );
}

void _handleExternalWallet(ExternalWalletResponse response) {
  Fluttertoast.showToast(msg: "external wallet" + response.walletName);
}
