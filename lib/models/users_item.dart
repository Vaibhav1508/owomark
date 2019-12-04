import 'package:flutter/cupertino.dart';

class UsersItem {
  String id = "";
  String fname = "";
  String lname = "";
  String email = "";
  String mobile = "";
  String city = "";
  String pincode = "";

  Map<String, dynamic> toMap() {
    return {
      'id': this.id,
      'f_name': this.fname,
      'l_name': this.lname,
      'email': this.email,
      'mobile': this.mobile,
      'city': this.city,
      'pincode': this.pincode,
    };
  }

  factory UsersItem.fromMap(Map<String, dynamic> map) {
    return new UsersItem(
      id: map['id'] as String,
      fname: map['f_name'] as String,
      lname: map['l_name'] as String,
      mobile: map['mobile'] as String,
      email: map['email'] as String,
      city: map['city'] as String,
      pincode: map['pincode'] as String,
    );
  }

  UsersItem({
    @required this.id,
    @required this.fname,
    @required this.lname,
    @required this.email,
    @required this.city,
    @required this.mobile,
    @required this.pincode,
  });
}
