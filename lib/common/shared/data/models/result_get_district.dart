// To parse this JSON data, do
//
//     final resultGetDistrict = resultGetDistrictFromJson(jsonString);

import 'dart:convert';

ResultGetDistrict resultGetDistrictFromJson(String str) => ResultGetDistrict.fromJson(json.decode(str));

String resultGetDistrictToJson(ResultGetDistrict data) => json.encode(data.toJson());

class ResultGetDistrict {
  ResultGetDistrict({
    this.data,
    this.error,
  });

  Data data;
  dynamic error;

  factory ResultGetDistrict.fromJson(Map<String, dynamic> json) => ResultGetDistrict(
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
    this.listDistrict,
  });

  bool result;
  List<ListDistrict> listDistrict;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    result: json["result"] == null ? null : json["result"],
    listDistrict: json["list_district"] == null ? null : List<ListDistrict>.from(json["list_district"].map((x) => ListDistrict.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "result": result == null ? null : result,
    "list_district": listDistrict == null ? null : List<dynamic>.from(listDistrict.map((x) => x.toJson())),
  };
}

class ListDistrict {
  ListDistrict({
    this.id,
    this.name,
    this.order,
    this.type,
    this.count,
  });

  String id;
  String name;
  String order;
  dynamic type;
  String count;

  factory ListDistrict.fromJson(Map<String, dynamic> json) => ListDistrict(
    id: json["id"] == null ? null : json["id"],
    name: json["name"] == null ? null : json["name"],
    order: json["order"] == null ? null : json["order"],
    type: json["type"],
    count: json["count"] == null ? null : json["count"],
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "name": name == null ? null : name,
    "order": order == null ? null : order,
    "type": type,
    "count": count == null ? null : count,
  };
}
