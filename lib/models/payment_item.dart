import 'package:flutter/cupertino.dart';

class PaymentItem {
  String cod = "";
  String wallet = "";
  String balance = "";

  Map<String, dynamic> toMap() {
    return {
      'cod': this.cod,
      'wallet': this.wallet,
      'balance': this.balance,
    };
  }

  factory PaymentItem.fromMap(Map<String, dynamic> map) {
    return new PaymentItem(
      wallet: map['wallet'] as String,
      cod: map['cod'] as String,
      balance: map['balance'] as String,
    );
  }

  PaymentItem({
    @required this.cod,
    @required this.wallet,
    @required this.balance,
  });
}
