// To parse this JSON data, do
//
//     final resultRenew = resultRenewFromJson(jsonString);

import 'dart:convert';

class ResultRenew {
  ResultRenew({
    this.result,
    this.accessToken,
    this.id,
  });

  final bool result;
  final String accessToken;
  final String id;

  factory ResultRenew.fromRawJson(String str) => ResultRenew.fromJson(json.decode(str));
  String toRawJson() => json.encode(toJson());

  factory ResultRenew.fromJson(Map<String, dynamic> json) => ResultRenew(
    result: json["result"] == null ? null : json["result"],
    accessToken: json["access_token"] == null ? null : json["access_token"],
    id: json["id"] == null ? null : json["id"],
  );

  Map<String, dynamic> toJson() => {
    "result": result == null ? null : result,
    "access_token": accessToken == null ? null : accessToken,
    "id": id == null ? null : id,
  };
}
