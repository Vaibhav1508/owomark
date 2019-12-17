import 'package:flutter/cupertino.dart';

class ReviewItem {
  String id = "";
  String rate = "";
  String user = "";

  Map<String, dynamic> toMap() {
    return {
      'id': this.id,
      'rate': this.rate,
      'user': this.user,
    };
  }

  factory ReviewItem.fromMap(Map<String, dynamic> map) {
    return new ReviewItem(
      id: map['id'] as String,
      user: map['user'] as String,
      rate: map['rate'] as String,
    );
  }

  ReviewItem({
    @required this.id,
    @required this.rate,
    @required this.user,
    
  });
}
