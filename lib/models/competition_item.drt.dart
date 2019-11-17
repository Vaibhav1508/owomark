import 'package:flutter/cupertino.dart';


class CompetitionItem {
  String id = "";
  String name = "";
  String imageUrl = "";

  Map<String, dynamic> toMap() {
    return {
      'id': this.id,
      'title': this.name,
      'img': this.imageUrl,

    };
  }

  factory CompetitionItem.fromMap(Map<String, dynamic> map) {
    return new CompetitionItem(
      id: map['id'] as String,
      name: map['title'] as String,
      imageUrl: map['img'] as String,

    );
  }

  CompetitionItem({
    @required this.id,
    @required this.name,
    @required this.imageUrl,
  });

}
