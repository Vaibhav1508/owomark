import 'package:flutter/cupertino.dart';

class MessageItem {
  String id = "";
  String fname = "";
  String imageUrl = "";
  String msg = "";
  String time = "";
  String lname = "";
  String sender = "";
  String status = "";

  Map<String, dynamic> toMap() {
    return {
      'id': this.id,
      'img': this.imageUrl,
      'msg': this.msg,
      'timing': this.time,
      'f_name': this.fname,
      'l_name': this.lname,
      'sender': this.sender,
      'status': this.status,
    };
  }

  factory MessageItem.fromMap(Map<String, dynamic> map) {
    return new MessageItem(
      id: map['id'] as String,
      msg: map['msg'] as String,
      sender: map['sender'] as String,
      fname: map['f_name'] as String,
      lname: map['l_name'] as String,
      time: map['timing'] as String,
      imageUrl: map['img'] as String,
      status: map['status'] as String,
    );
  }

  MessageItem({
    @required this.id,
    @required this.sender,
    @required this.msg,
    @required this.fname,
    @required this.lname,
    @required this.status,
    @required this.time,
    @required this.imageUrl,
  });
}
