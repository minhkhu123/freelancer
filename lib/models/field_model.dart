

import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/flutter_svg.dart';

class FieldModel{
  int id;
  String name;
  SvgPicture img;
  bool isColorText;
  FieldModel({this.name, this.img, this.id, this.isColorText = true});
}