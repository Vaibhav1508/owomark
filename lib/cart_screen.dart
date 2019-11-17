import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:owomark/models/cart_items.dart';
import 'package:owomark/payment_method.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'api_interface.dart';
import 'dashboard_screen.dart';
import 'package:progress_dialog/progress_dialog.dart';

class CartScreen extends StatefulWidget {
  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {

  int total=0;
  int mtotal;


  ApiInterface apiInterface = new ApiInterface();

  //Category List
  List<CartItems> cartitem = new List();

  ProgressDialog pr;



  String producturl = 'http://owomark.com/owomarkapp/images/product/';

  @override
  Widget build(BuildContext context) {

    pr = new ProgressDialog(context,type: ProgressDialogType.Normal,isDismissible: true,showLogs: true);

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
            color: Colors.black,
            fontSize: 13.0,
            fontWeight: FontWeight.w400
        ),
        messageTextStyle: TextStyle(
            color: Colors.black,
            fontSize: 19.0,
            fontWeight: FontWeight.w600
        )
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
          'Shopping Cart',
          style: TextStyle(color: Colors.black),
          //textAlign: TextAlign.center,
        ),
        elevation: 3.0,
      ),
      body: Column(
        children: <Widget>[
          //CategorySelector(),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30.0),
                      topRight: Radius.circular(30.0))),
              child: Column(
                children: <Widget>[
              Expanded(
              child: Container(
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
            itemCount: cartitem.length,
            itemBuilder: (BuildContext context, int index) {
              final item = cartitem[index];

              int price = int.parse(item.price);
              int qty = int.parse(item.qty);

              //total = total+(price*qty);

              return GestureDetector(

                child: Container(
                  // width: 300,
                  margin: EdgeInsets.only(top: 5.0, bottom: 5.0),
                  padding:
                  EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
                  decoration: BoxDecoration(
                      color:  Colors.white,
                      border:
                      Border(bottom: BorderSide(color: Colors.black12))),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Image.network(producturl+item.imageUrl,height: 80,width: 80,),
                          SizedBox(
                            width: 10.0,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                item.name,
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 15.0,
                                    fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                height: 15.0,
                              ),
                              Column(

                                children: <Widget>[
                                  Text(
                                    item.price + ' Rs.',
                                    style: TextStyle(
                                      color: Colors.black87,
                                      fontSize: 16.0,
                                    ),
                                  ),
                                  SizedBox(height: 7,),
                                  Text(
                                    item.qty+' Item',
                                    style: TextStyle(
                                      color: Colors.orange,
                                      fontSize: 20.0,
                                    ),
                                  ),

                                ],
                              ),
                            ],
                          )
                        ],
                      ),
                      Column(
                        children: <Widget>[

                          IconButton(
                            icon: Icon(Icons.restore_from_trash,
                              color: Colors.red,),
                          ),

                          IconButton(
                            icon: Icon(Icons.add_box,color: Colors.green,),
                            onPressed: (){
                              cartitem.clear();
                              total = 0;
                              incrementItem(context,item.id,item.qty);

                            },
                          ),

                          IconButton(
                            icon: Icon(Icons.indeterminate_check_box,color: Colors.blue,
                            ),
                            onPressed: (){
                              if(item.qty=="1"){
                                Fluttertoast.showToast(msg: "item can not be reduced...");
                              }else{
                                cartitem.clear();
                                total = 0;
                                decrementItem(context,item.id,item.qty);
                              }

                            },
                          )

                        ],
                      )
                    ],
                  ),
                ),
              );
            },
          ),
        )),
    ),

                  ListTile(
                    title: Text('Total (Price with GST)',
                      ),
                    trailing: Text(total.toString()+' Rs',style: TextStyle(
                      fontSize: 20,
                      color: Colors.black87,
                      fontWeight: FontWeight.bold
                    )),
                  ),
      RaisedButton(

          color: Colors.blue,
          padding: EdgeInsets.all(
            10.0,
          ),
          shape: RoundedRectangleBorder(
              borderRadius: new BorderRadius.circular(5.0),
              side: BorderSide(color: Colors.blue)),
          highlightColor: Colors.black,
          child: new Text(
            'Checkout',
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: ()=> Navigator.push(context,MaterialPageRoute(
            builder: (_)=>PaymentMethod(amount: total,)
          ))),
                  SizedBox(height: 10,)
                 ],
              ),
            ),
          ),
        ],
      ),
    );
  }


  @override
  void initState() {
    super.initState();
    getCart(context);
    total = 0;
  }

  getCart(context) async {
    setState(() {});

    Future<dynamic> response = apiInterface.getCart('168');

    response.then((action) async {

      print(action.toString());
      if (action != null) {
        Map data = jsonDecode(action.toString());
        if (data["status"] == "200") {
          List<dynamic> list = data['result'];
          for (int i = 0; i < list.length; i++) {
            CartItems notificationItem = CartItems.fromMap(list[i]);
            cartitem.add(notificationItem);
          }
          setState(() {
            for(int i=0;i<cartitem.length;i++){
              int qty = int.parse(cartitem[i].qty);
              int price = int.parse(cartitem[i].price);
              mtotal = qty*price;
              total = total+mtotal;
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

  incrementItem(context,String id,String qty) async {
    setState(() {});

    Future<dynamic> response = apiInterface.incrementItem(id,qty);

    response.then((action) async {
      if(pr.isShowing()){
        pr.hide();
      }
      print(action.toString());
      if (action != null) {
        Map data = jsonDecode(action.toString());
        if (data["status"] == "200") {
        Fluttertoast.showToast(msg: "Item Increased Succeccfully...",toastLength: Toast.LENGTH_SHORT,fontSize: 16);
        getCart(context);
        } else {
          print('error');
        }
      }
    }, onError: (value) {
      print(value);
    });
  }

  decrementItem(context,String id,String qty) async {
    setState(() {});

    Future<dynamic> response = apiInterface.decrementItem(id,qty);

    response.then((action) async {
      if(pr.isShowing()){
        pr.hide();
      }
      print(action.toString());
      if (action != null) {
        Map data = jsonDecode(action.toString());
        if (data["status"] == "200") {
          Fluttertoast.showToast(msg: "Item Reduced Succeccfully...",toastLength: Toast.LENGTH_SHORT,fontSize: 16);
          getCart(context);
        } else {
          print('error');
        }
      }
    }, onError: (value) {
      print(value);
    });
  }

}
