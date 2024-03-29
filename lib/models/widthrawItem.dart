import 'package:flutter/cupertino.dart';


class WidthrawItem {
  String id = "";
  String name = "";
  String amount = "";
  String paid = "";
  String created = "";

  Map<String, dynamic> toMap() {
    return {
      'id': this.id,
      'msg': this.name,
      'amount': this.amount,
      'paid': this.paid,
      'trans_time': this.created,

    };
  }

  factory WidthrawItem.fromMap(Map<String, dynamic> map) {
    return new WidthrawItem(
      id: map['id'] as String,
      name: map['msg'] as String,
      amount: map['amount'] as String,
      paid: map['paid'] as String,
      created: map['trans_time'] as String,

    );
  }

  WidthrawItem({
    @required this.id,
    @required this.name,
    @required this.amount,
    @required this.paid,
    @required this.created,
  });

}
