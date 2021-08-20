import 'package:cloud_firestore/cloud_firestore.dart';

class ImageModel{
  static const ID = "id";
  static const IMAGE = "image";
  static const LIKED = "liked";
  static const NAME = "name";
  static const PRICE = "price";

  String id;
  String image;
  bool liked;
  String name;
  String price;

  ImageModel({this.id, this.image, this.liked, this.name, this.price});

  ImageModel.fromDocumentSnapshot(DocumentSnapshot data){
    id = data.id;
    image = (data.data() as Map)[IMAGE];
    liked = (data.data() as Map)[LIKED];
    name = (data.data()  as Map)[NAME];
    price = (data.data()  as Map)[PRICE];
  }

}