import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:owomark/models/book_item.dart';

import 'api_interface.dart';
import 'category_screen.dart';

class SingleProduct extends StatefulWidget {
  final String subcat_id;
  final String product_id;

  SingleProduct({Key key, this.subcat_id, this.product_id}) : super(key: key);

  @override
  _SingleProductState createState() => _SingleProductState();
}

class _SingleProductState extends State<SingleProduct> {
  ApiInterface apiInterface = new ApiInterface();

  //Category List
  List<BookItem> product = new List();

  String producturl = 'http://owomark.com/owomarkapp/images/product/';

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
                      builder: (_) => Category(),
                    ),
                  )),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.add_shopping_cart),
              iconSize: 30,
              color: Colors.blue,
            )
          ],
          title: Text(
            'Product Details',
            style: TextStyle(color: Colors.black),
            //textAlign: TextAlign.center,
          ),
          elevation: 3.0,
        ),
        body: Container(
            child: ListView.builder(
                itemCount: product.length,
                itemBuilder: (BuildContext context, int index) {
                  final item = product[index];

                  return SingleChildScrollView(
                      // height: double.infinity,
                      padding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                      child: Column(
                        children: <Widget>[
                          Image.network(
                            producturl + item.imageUrl,
                            height: 300,
                            width: MediaQuery.of(context).size.width * 5,
                          ),
                          ListTile(
                            title: Text(
                              'Product Title',
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
                              'Publication',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 18),
                            ),
                            trailing: Icon(Icons.arrow_forward_ios),
                          ),
                          ListTile(
                            title: Text(item.publication),
                          ),
                          Divider(),
                          ListTile(
                            title: Text(
                              'Author Name',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 18),
                            ),
                            trailing: Icon(Icons.arrow_forward_ios),
                          ),
                          ListTile(
                            title: Text(item.author),
                          ),
                          Divider(),
                          ListTile(
                            title: Text(
                              'Product M.R.P',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 18),
                            ),
                            trailing: Icon(Icons.arrow_forward_ios),
                          ),
                          ListTile(
                            title: Text(item.price + " Rs"),
                          ),
                          Divider(),
                          ListTile(
                            title: Text(
                              'Product Discount ',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 18),
                            ),
                            trailing: Icon(Icons.arrow_forward_ios),
                          ),
                          ListTile(
                            title: Text(item.discount + ' %'),
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
                              item.amount + ' Rs',
                              style:
                                  TextStyle(color: Colors.orange, fontSize: 22),
                            ),
                          ),
                          Divider(),
                          ListTile(
                            title: Text(
                              'Note',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 18),
                            ),
                            trailing: Icon(Icons.arrow_forward_ios),
                          ),
                          ListTile(
                            title: Text(item.note),
                          ),
                          Divider(),
                          ListTile(
                            title: Text('Additional Details 1'),
                          ),
                          Divider(),
                          ListTile(
                            title: Text('Additional Details 2'),
                          )
                        ],
                      ));
                })));
  }

  @override
  void initState() {
    super.initState();
    getSingleProduct(context);
  }

  getSingleProduct(context) async {
    setState(() {});

    Future<dynamic> response = apiInterface.getSingleProduct(widget.product_id);

    response.then((action) async {
      print(action.toString());
      if (action != null) {
        Map data = jsonDecode(action.toString());
        if (data["status"] == "200") {
          List<dynamic> list = data['result'];
          for (int i = 0; i < list.length; i++) {
            BookItem notificationItem = BookItem.fromMap(list[i]);
            product.add(notificationItem);
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
