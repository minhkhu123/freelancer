// To parse this JSON data, do
//
//     final resultGetCity = resultGetCityFromJson(jsonString);

import 'dart:convert';

ResultGetCity resultGetCityFromJson(String str) => ResultGetCity.fromJson(json.decode(str));

String resultGetCityToJson(ResultGetCity data) => json.encode(data.toJson());

class ResultGetCity {
  ResultGetCity({
    this.data,
    this.error,
  });

  Data data;
  dynamic error;

  factory ResultGetCity.fromJson(Map<String, dynamic> json) => ResultGetCity(
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
    this.listCity,
  });

  bool result;
  List<ListCity> listCity;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    result: json["result"] == null ? null : json["result"],
    listCity: json["list_city"] == null ? null : List<ListCity>.from(json["list_city"].map((x) => ListCity.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "result": result == null ? null : result,
    "list_city": listCity == null ? null : List<dynamic>.from(listCity.map((x) => x.toJson())),
  };
}

class ListCity {
  ListCity({
    this.id,
    this.name,
    this.order,
    this.type,
    this.count,
    this.countVl,
    this.cityTw,
    this.postCode,
  });

  String id;
  String name;
  String order;
  String type;
  String count;
  String countVl;
  String cityTw;
  String postCode;

  factory ListCity.fromJson(Map<String, dynamic> json) => ListCity(
    id: json["id"] == null ? null : json["id"],
    name: json["name"] == null ? null : json["name"],
    order: json["order"] == null ? null : json["order"],
    type: json["type"] == null ? null : json["type"],
    count: json["count"] == null ? null : json["count"],
    countVl: json["count_vl"] == null ? null : json["count_vl"],
    cityTw: json["city_tw"] == null ? null : json["city_tw"],
    postCode: json["post_code"] == null ? null : json["post_code"],
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "name": name == null ? null : name,
    "order": order == null ? null : order,
    "type": type == null ? null : type,
    "count": count == null ? null : count,
    "count_vl": countVl == null ? null : countVl,
    "city_tw": cityTw == null ? null : cityTw,
    "post_code": postCode == null ? null : postCode,
  };
}
