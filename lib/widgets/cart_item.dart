import 'package:flutter/material.dart';
import 'package:owomark/models/cart_model.dart';
import 'package:owomark/models/transaction_model.dart';

class CartItem extends StatefulWidget {
  @override
  _CartItemState createState() => _CartItemState();
}

class _CartItemState extends State<CartItem> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
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
              itemCount: cart.length,
              itemBuilder: (BuildContext context, int index) {
                final Cart item = cart[index];

                return GestureDetector(

                  child: Container(
                    // width: 300,
                    margin: EdgeInsets.only(top: 5.0, bottom: 5.0),
                    padding:
                    EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
                    decoration: BoxDecoration(
                        color: item.delivered ? Colors.white : Colors.white,
                        border:
                        Border(bottom: BorderSide(color: Colors.black12))),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                           Image.asset(item.image,height: 80,width: 80,),
                            SizedBox(
                              width: 10.0,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  item.title,
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
                                     item.text,
                                     style: TextStyle(
                                       color: Colors.grey,
                                       fontSize: 16.0,
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
                              icon: Icon(Icons.add,color: Colors.blue,),
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
    );
  }
}
