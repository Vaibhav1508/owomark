import 'package:flutter/cupertino.dart';

class NewsItem {
  String id = "";
  String fname = "";
  String imageUrl = "";
  String liked = "";
  String time = "";
  String lname = "";
  String likes = "";

  Map<String, dynamic> toMap() {
    return {
      'id': this.id,
      'img': this.imageUrl,
      'liked': this.liked,
      'time': this.time,
      'f_name': this.fname,
      'l_name': this.lname,
      'likes': this.likes,
    };
  }

  factory NewsItem.fromMap(Map<String, dynamic> map) {
    return new NewsItem(
      id: map['id'] as String,
      liked: map['liked'] as String,
      likes: map['likes'] as String,
      fname: map['f_name'] as String,
      lname: map['l_name'] as String,
      time: map['time'] as String,
      imageUrl: map['img'] as String,
    );
  }

  NewsItem({
    @required this.id,
    @required this.likes,
    @required this.liked,
    @required this.fname,
    @required this.lname,
    @required this.time,
    @required this.imageUrl,
  });
}
