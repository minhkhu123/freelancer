import 'package:flutter/material.dart';

class DropListModelFreelancer {
  DropListModelFreelancer(this.listOptionItemsFreelancer);

  final List<OptionItemFreelancer> listOptionItemsFreelancer;
}

class OptionItemFreelancer {
  String id;
  String title;
  final VoidCallback onPress;

  OptionItemFreelancer({@required this.id, @required this.title, @required this.onPress});
}