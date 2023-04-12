import 'package:flutter/cupertino.dart';

//Models in dart is treated as class
class Transactions {
  String id;
  String item;
  double price;
  DateTime dateTime;

  Transactions(
      {@required this.id,
      @required this.item,
      @required this.price,
      @required this.dateTime});
}
