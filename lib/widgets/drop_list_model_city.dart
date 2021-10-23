import 'package:flutter/material.dart';

class DropListModelCity {
  DropListModelCity(this.listOptionItemsCity);

  final List<OptionItemCity> listOptionItemsCity;
}

class OptionItemCity {
  final String id;
  final String title;
  final String order;
  final String type;
  final String count;
  final String countVl;
  final String cityTw;
  final String postCode;

  OptionItemCity(
      {@required this.id,
      @required this.title,
      @required this.order,
      @required this.count,
      @required this.cityTw,
      @required this.countVl,
      @required this.postCode,
      @required this.type});
}
