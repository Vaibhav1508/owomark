import 'package:flutter/cupertino.dart';


class BookItem {
  String id = "";
  String name = "";
  String imageUrl = "";
  String price = "";
  String discount = "";
  String amount="";
  String publication="";
  String author="";
  String note="";

  Map<String, dynamic> toMap() {
    return {
      'id': this.id,
      'title': this.name,
      'img': this.imageUrl,
      'price_detail': this.price,
      'discount': this.discount,
      'info': this.publication,
      'feature': this.author,
      'note': this.note,
      'price': this.amount,

    };
  }

  factory BookItem.fromMap(Map<String, dynamic> map) {
    return new BookItem(
      id: map['id'] as String,
      name: map['title'] as String,
      imageUrl: map['img'] as String,
      price: map['price_detail'] as String,
      discount: map['discount'] as String,
      amount: map['price'] as String,
      author: map['feature'] as String,
      note: map['note'] as String,
      publication: map['info'] as String,


    );
  }

  BookItem({
    @required this.id,
    @required this.name,
    @required this.imageUrl,
    @required this.price,
    @required this.amount,
    @required this.discount,
    @required this.author,
    @required this.publication,
    @required this.note,
  });

}
