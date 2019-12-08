import 'package:flutter/cupertino.dart';

class QuizItem {
  String id = "";
  String name = "";
  String imageUrl = "";
  String q_time = "";
  String status = "";
  String min = "";
  String que = "";
  String ans = "";
  String a = "";
  String b = "";
  String c = "";
  String d = "";

  Map<String, dynamic> toMap() {
    return {
      'id': this.id,
      'title': this.name,
      'q_time': this.q_time,
      'img': this.imageUrl,
      'min': this.min,
      'que': this.que,
      'ans': this.ans,
      'a': this.a,
      'b': this.b,
      'c': this.c,
      'd': this.d,
      'status': this.status,
    };
  }

  factory QuizItem.fromMap(Map<String, dynamic> map) {
    return new QuizItem(
      id: map['id'] as String,
      name: map['title'] as String,
      imageUrl: map['img'] as String,
      q_time: map['q_time'] as String,
      status: map['status'] as String,
      min: map['min'] as String,
      que: map['que'] as String,
      ans: map['ans'] as String,
      a: map['a'] as String,
      b: map['b'] as String,
      c: map['c'] as String,
      d: map['d'] as String,
    );
  }

  QuizItem({
    @required this.id,
    @required this.min,
    @required this.name,
    @required this.q_time,
    @required this.imageUrl,
    @required this.status,
    @required this.que,
    @required this.ans,
    @required this.a,
    @required this.b,
    @required this.c,
    @required this.d,
  });
}
