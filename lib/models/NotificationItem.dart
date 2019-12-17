import 'package:flutter/cupertino.dart';

class NotificationItems {
  String id = "";
  String msg = "";
  String time = ""; 
  String title = "";

  Map<String, dynamic> toMap() {
    return {
      'id': this.id,
      'message': this.msg,
      'time': this.time,
      'title': this.title,
    };
  }

  factory NotificationItems.fromMap(Map<String, dynamic> map) {
    return new NotificationItems(
      id: map['id'] as String,
      msg: map['message'] as String,
     time: map['time'] as String,
      title: map['title'] as String,
    );
  }

  NotificationItems({
    @required this.id,
    @required this.title,
    @required this.msg, 
    @required this.time,
  });
}
