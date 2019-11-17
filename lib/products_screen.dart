import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:owomark/models/book_item.dart';
import 'package:owomark/single_product.dart';
import 'package:owomark/subcategory.dart';

import 'api_interface.dart';
import 'dashboard_screen.dart';

class ProductsScreen extends StatefulWidget {

  final String cat_id;
  final String sub_id;


  ProductsScreen({Key key,this.cat_id,this.sub_id}) : super(key: key);

  @override
  _ProductsScreenState createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {

  ApiInterface apiInterface = new ApiInterface();
  //Category List
  List<BookItem> books = new List();

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
                builder: (_) => SubCategorys(cat_id: widget.cat_id),
              ),
            )),
        title: Text(
          'Products',
          style: TextStyle(color: Colors.black),
          //textAlign: TextAlign.center,
        ),
        elevation: 3.0,
      ),
      body:  books.length == 0
          ? Center(
        child: Text(
          "No Products Found",
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
        ),
      ):Container(
        padding: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
        height: double.infinity,

        child: GridView.count(crossAxisCount: 2,
        scrollDirection: Axis.vertical,

        children: List.generate(books.length, (index){

          final item = books[index];

          return  GestureDetector(
            child: makeBestCategory(
                image: producturl+item.imageUrl, title:item.name,price: item.amount ),
            onTap: ()=> Navigator.push(context, MaterialPageRoute(
              builder: (_)=>SingleProduct(product_id: item.id,)
            )),
          );
        })),
      ),

    );
  }

  @override
  void initState() {
    super.initState();
    getSubCategory(context);
  }

  getSubCategory(context) async {
    setState(() {});

    Future<dynamic> response = apiInterface.getProducts(widget.sub_id);

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


Widget makeBestCategory({String image, String title,String price}) {
  return Column(

      children: <Widget>[
        Container(
          height: 100,
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
                      fontSize: 16),
                ),
              )),
        ),
        ListTile(
          title: Text(price+' Rs',style: TextStyle(
            fontSize: 18,
            //color: Colors.green,
            fontWeight: FontWeight.bold
          ),),
          trailing: Icon(Icons.arrow_forward_ios,),
        ),

      ],
    );


}