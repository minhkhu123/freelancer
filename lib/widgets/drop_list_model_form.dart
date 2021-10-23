import 'package:flutter/material.dart';

class DropListModelForm {
  DropListModelForm(this.listOptionItemsForm);

  final List<OptionItemForm> listOptionItemsForm;
}

class OptionItemForm {
   int id;
   String title;

  OptionItemForm({@required this.id, @required this.title});
}