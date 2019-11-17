import 'package:flutter/cupertino.dart';


class CategoryItem {
   String id = "";
   String name = "";
   String title = "";
   String imageUrl = "";

  Map<String, dynamic> toMap() {
    return {
      'id': this.id,
      'title': this.name,
      'name': this.title,
      'img': this.imageUrl,

    };
  }

  factory CategoryItem.fromMap(Map<String, dynamic> map) {
    return new CategoryItem(
      id: map['id'] as String,
      name: map['title'] as String,
      title: map['name'] as String,
      imageUrl: map['img'] as String,

    );
  }

  CategoryItem({
    @required this.id,
    @required this.name,
    @required this.imageUrl,
    @required this.title,
  });

}
