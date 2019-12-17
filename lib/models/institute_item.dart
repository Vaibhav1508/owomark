import 'package:flutter/cupertino.dart';

class InstituteItem {
  String id = "";
  String name = "";
  String imageUrl = "";
  String rate = "";
  String rated = "";
  String location = "";
  String address = "";
  String education = "";
  String email = "";
  String contact = "";
  String exp = "";
  String tutor = "";
  String city = "";
  String user = "";

  Map<String, dynamic> toMap() {
    return {
      'id': this.id,
      'name': this.name,
      'rated': this.rated,
      'img': this.imageUrl,
      'rate': this.rate,
      'location': this.location,
      'address': this.address,
      'contact': this.contact,
      'email': this.email,
      'tutor': this.tutor,
      't_exp': this.exp,
      't_edu': this.education,
      'city': this.city,
      'user': this.user,
    };
  }

  factory InstituteItem.fromMap(Map<String, dynamic> map) {
    return new InstituteItem(
      id: map['id'] as String,
      name: map['name'] as String,
      imageUrl: map['img'] as String,
      user: map['user'] as String,
      rate: map['rate'] as String,
      address: map['address'] as String,
      rated: map['rated'] as String,
      contact: map['contact'] as String,
      email: map['email'] as String,
      tutor: map['tutor'] as String,
      exp: map['t_exp'] as String,
      education: map['t_edu'] as String,
      city: map['city'] as String,
      location: map['location'] as String,
    );
  }

  InstituteItem({
    @required this.id,
    @required this.name,
    @required this.imageUrl,
    @required this.rated,
    @required this.rate,
    @required this.location,
    @required this.user,
    @required this.tutor,
    @required this.exp,
    @required this.email,
    @required this.address,
    @required this.city,
    @required this.contact,
    @required this.education,
  });
}
