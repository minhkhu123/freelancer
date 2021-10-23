import 'package:flutter/material.dart';

class DropListModelSex {
  DropListModelSex(this.listOptionItems);

  final List<OptionItemSex> listOptionItems;
}

class OptionItemSex {
  final String id;
  final String title;

  OptionItemSex({@required this.id, @required this.title});
}