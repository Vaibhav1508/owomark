import 'package:flutter/cupertino.dart';

class PgItem {
  String id = "";
  String name = "";
  String imageUrl = "";
  String location = "";
  String address = "";
  String price = "";
  String desc = "";

  Map<String, dynamic> toMap() {
    return {
      'id': this.id,
      'title': this.name,
      'img': this.imageUrl,
      'location': this.location,
      'address': this.address,
      'price': this.price,
      'description': this.desc,
    };
  }

  factory PgItem.fromMap(Map<String, dynamic> map) {
    return new PgItem(
      id: map['id'] as String,
      name: map['title'] as String,
      imageUrl: map['img'] as String,
      location: map['location'] as String,
      address: map['address'] as String,
      price: map['price'] as String,
      desc: map['description'] as String,
    );
  }

  PgItem({
    @required this.id,
    @required this.name,
    @required this.desc,
    @required this.imageUrl,
    @required this.location,
    @required this.address,
    @required this.price,
  });
}
