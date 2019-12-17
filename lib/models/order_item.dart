import 'package:flutter/cupertino.dart';

class OrderItems {
  String id = "";
  String name = "";
  String imageUrl = "";
  String status = "";
  String time = "";
  String price = "";

  Map<String, dynamic> toMap() {
    return {
      'id': this.id,
      'order_no': this.name,
      'img': this.imageUrl,
      'delivery': this.status,
      'date': this.time,
      'amount': this.price,
    };
  }

  factory OrderItems.fromMap(Map<String, dynamic> map) {
    return new OrderItems(
      id: map['id'] as String,
      name: map['order_no'] as String,
      imageUrl: map['img'] as String,
      status: map['delivery'] as String,
      time: map['date'] as String,
      price: map['amount'] as String,
    );
  }

  OrderItems({
    @required this.id,
    @required this.name,
    @required this.imageUrl,
    @required this.status,
    @required this.time,
    @required this.price,
  });
}
