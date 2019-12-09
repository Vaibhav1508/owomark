import 'package:flutter/cupertino.dart';

class TicketItem {
  String id = "";
  String name = "";
  String imageUrl = "";
  String status = "";
  String timing = "";
  String price = "";
  String user = "";
  String ticket = "";
  String location = "";

  Map<String, dynamic> toMap() {
    return {
      'id': this.id,
      'title': this.name,
      'ticket': this.ticket,
      'name': this.user,
      'img': this.imageUrl,
      'delivery': this.status,
      'timing': this.timing,
      'amount': this.price,
      'location': this.location,
    };
  }

  factory TicketItem.fromMap(Map<String, dynamic> map) {
    return new TicketItem(
      id: map['id'] as String,
      name: map['title'] as String,
      imageUrl: map['img'] as String,
      status: map['delivery'] as String,
      timing: map['timing'] as String,
      user: map['name'] as String,
      ticket: map['ticket'] as String,
      price: map['amount'] as String,
      location: map['location'] as String,
    );
  }

  TicketItem({
    @required this.id,
    @required this.name,
    @required this.imageUrl,
    @required this.status,
    @required this.location,
    @required this.timing,
    @required this.ticket,
    @required this.user,
    @required this.price,
  });
}
