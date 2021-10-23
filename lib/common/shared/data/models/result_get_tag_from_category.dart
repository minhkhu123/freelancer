// To parse this JSON data, do
//
//     final resultTagFromCategory = resultTagFromCategoryFromJson(jsonString);

import 'dart:convert';

import 'package:equatable/equatable.dart';

ResultTagFromCategory resultTagFromCategoryFromJson(String str) => ResultTagFromCategory.fromJson(json.decode(str));

String resultTagFromCategoryToJson(ResultTagFromCategory data) => json.encode(data.toJson());

class ResultTagFromCategory {
  ResultTagFromCategory({
    this.data,
    this.error,
  });

  Data data;
  dynamic error;

  factory ResultTagFromCategory.fromJson(Map<String, dynamic> json) => ResultTagFromCategory(
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
    error: json["error"],
  );

  Map<String, dynamic> toJson() => {
    "data": data == null ? null : data.toJson(),
    "error": error,
  };
}

class Data {
  Data({
    this.result,
    this.listTag,
  });

  bool result;
  List<ListTag> listTag;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    result: json["result"] == null ? null : json["result"],
    listTag: json["list_tag"] == null ? null : List<ListTag>.from(json["list_tag"].map((x) => ListTag.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "result": result == null ? null : result,
    "list_tag": listTag == null ? null : List<dynamic>.from(listTag.map((x) => x.toJson())),
  };
}

class ListTag  extends Equatable{
  ListTag({
    this.id,
    this.name,
  });

  String id;
  String name;

  factory ListTag.fromJson(Map<String, dynamic> json) => ListTag(
    id: json["id"] == null ? null : json["id"],
    name: json["name"] == null ? null : json["name"],
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "name": name == null ? null : name,
  };

  @override
  List<Object> get props => [id, name];
}
