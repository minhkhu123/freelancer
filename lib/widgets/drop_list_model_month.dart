import 'package:flutter/material.dart';

class DropListModelMonth {
  DropListModelMonth(this.listOptionItemsMonth);

  final List<OptionItemMonth> listOptionItemsMonth;
}

class OptionItemMonth {
  String id;
  String title;

  OptionItemMonth({@required this.id, @required this.title});
}