import 'package:equatable/equatable.dart';

class OptionItem  extends Equatable{
  int id;
  String title;
  OptionItem({this.id, this.title});

  @override
  List<Object> get props => [id, title];
}

class DropListModel {
  List<OptionItem> listItem;
  DropListModel({this.listItem});
}
