import 'package:flutter/cupertino.dart';

class EventItem {
  String id = "";
  String name = "";
  String imageUrl = "";
  String location = "";
  String time = "";
  String price = "";

  Map<String, dynamic> toMap() {
    return {
      'id': this.id,
      'title': this.name,
      'img': this.imageUrl,
      'location': this.location,
      'timing': this.time,
      'price': this.price,
    };
  }

  factory EventItem.fromMap(Map<String, dynamic> map) {
    return new EventItem(
      id: map['id'] as String,
      name: map['title'] as String,
      imageUrl: map['img'] as String,
      location: map['location'] as String,
      time: map['timing'] as String,
      price: map['price'] as String,
    );
  }

  EventItem({
    @required this.id,
    @required this.name,
    @required this.imageUrl,
    @required this.location,
    @required this.time,
    @required this.price,
  });
}
