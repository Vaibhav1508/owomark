import 'package:flutter/cupertino.dart';


class InstituteItem {
  String id = "";
  String name = "";
  String imageUrl = "";
  String rate = "";
  String location = "";

  Map<String, dynamic> toMap() {
    return {
      'id': this.id,
      'name': this.name,
      'img': this.imageUrl,
      'rate': this.rate,
      'location': this.location,

    };
  }

  factory InstituteItem.fromMap(Map<String, dynamic> map) {
    return new InstituteItem(
      id: map['id'] as String,
      name: map['name'] as String,
      imageUrl: map['img'] as String,
      rate: map['rate'] as String,
      location: map['location'] as String,

    );
  }

  InstituteItem({
    @required this.id,
    @required this.name,
    @required this.imageUrl,
    @required this.rate,
    @required this.location,
  });

}
