import 'package:flutter/cupertino.dart';

class SliderItem {
  String id = "";
  String name = "";
  String imageUrl = "";
  String price = "";
  String desc = "";
  String fname = "";
  String lname = "";

  Map<String, dynamic> toMap() {
    return {
      'id': this.id,
      'title': this.name,
      'img': this.imageUrl,
      'price': this.price,
      'f_name': this.fname,
      'l_name': this.lname,
      'description': this.desc,
    };
  }

  factory SliderItem.fromMap(Map<String, dynamic> map) {
    return new SliderItem(
      id: map['id'] as String,
      name: map['title'] as String,
      imageUrl: map['img'] as String,
      price: map['price'] as String,
      fname: map['f_name'] as String,
      lname: map['l_name'] as String,
      desc: map['description'] as String,
    );
  }

  SliderItem({
    @required this.id,
    @required this.name,
    @required this.imageUrl,
    @required this.price,
    @required this.desc,
    @required this.fname,
    @required this.lname,
  });
}
