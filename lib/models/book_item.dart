import 'package:flutter/cupertino.dart';

class BookItem {
  String id = "";
  String name = "";
  String imageUrl = "";
  String price = "";
  String discount = "";
  String amount = "";
  String publication = "";
  String author = "";
  String location = "";
  String note = "";
  String buy_price = "";
  String mrp = "";
  String pub = "";
  String title = "";
  String pickup = "";
  String fname = "";
  String lname = "";
  String auth = "";
  String usrname = "";
  String returnamount = "";

  Map<String, dynamic> toMap() {
    return {
      'id': this.id,
      'user': this.usrname,
      'returnAmount': this.returnamount,
      'location': this.location,
      'title': this.name,
      'img': this.imageUrl,
      'price_detail': this.price,
      'mrp': this.mrp,
      'discount': this.discount,
      'info': this.publication,
      'feature': this.author,
      'author': this.auth,
      'buy_price': this.buy_price,
      'note': this.note,
      'book': this.title,
      'price': this.amount,
      'pickup': this.pickup,
      'f_name': this.fname,
      'publication': this.pub,
      'l_name': this.lname,
    };
  }

  factory BookItem.fromMap(Map<String, dynamic> map) {
    return new BookItem(
      id: map['id'] as String,
      usrname: map['user'] as String,
      returnamount: map['returnAmount'] as String,
      pub: map['publication'] as String,
      name: map['title'] as String,
      imageUrl: map['img'] as String,
      price: map['price_detail'] as String,
      mrp: map['mrp'] as String,
      discount: map['discount'] as String,
      amount: map['price'] as String,
      author: map['feature'] as String,
      note: map['note'] as String,
      buy_price: map['buy_price'] as String,
      publication: map['info'] as String,
      location: map['location'] as String,
      title: map['book'] as String,
      auth: map['author'] as String,
      pickup: map['pickup'] as String,
      fname: map['f_name'] as String,
      lname: map['l_name'] as String,
    );
  }

  BookItem({
    @required this.id,
    @required this.auth,
    @required this.pub,
    @required this.name,
    @required this.imageUrl,
    @required this.price,
    @required this.amount,
    @required this.discount,
    @required this.author,
    @required this.publication,
    @required this.note,
    @required this.title,
    @required this.location,
    @required this.buy_price,
    @required this.mrp,
    @required this.pickup,
    @required this.fname,
    @required this.returnamount,
    @required this.lname,
    @required this.usrname,
  });
}
