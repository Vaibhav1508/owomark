import 'package:flutter/cupertino.dart';


class CartItems {
  String id = "";
  String name = "";
  String title = "";
  String imageUrl = "";
  String qty = "";
  String price = "";

  Map<String, dynamic> toMap() {
    return {
      'id': this.id,
      'title': this.name,
      'name': this.title,
      'img': this.imageUrl,
      'qty': this.qty,
      'price': this.price,

    };
  }

  factory CartItems.fromMap(Map<String, dynamic> map) {
    return new CartItems(
      id: map['id'] as String,
      name: map['title'] as String,
      title: map['name'] as String,
      imageUrl: map['img'] as String,
      qty: map['qty'] as String,
      price: map['price'] as String,

    );
  }

  CartItems({
    @required this.id,
    @required this.name,
    @required this.imageUrl,
    @required this.title,
    @required this.qty,
    @required this.price,
  });

}
