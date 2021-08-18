class FolderModel{
  static const ID = "id";
  static const NAME = "name";
  static const FAVORITE = "favorite";

  String id;
  String name;
  bool favorite;

  FolderModel({this.id, this.name, this.favorite});

  FolderModel.fromMap(Map<String, dynamic> data){
    id = data[ID];
    name = data[NAME];
    favorite = data[FAVORITE];
  }

}
