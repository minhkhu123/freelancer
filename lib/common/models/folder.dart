import 'package:cloud_firestore/cloud_firestore.dart';

class FolderModel{
  static const ID = "id";
  static const NAME = "name";
  static const FAVORITE = "favorite";

  String id;
  String name;
  String favorite;

  FolderModel({this.id, this.name, this.favorite});

  FolderModel.fromDocumentSnapshot(DocumentSnapshot data){
    id = data.id;
    name = data[NAME];
    favorite = data[FAVORITE];
  }

}
