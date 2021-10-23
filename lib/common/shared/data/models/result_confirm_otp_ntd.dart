// To parse this JSON data, do
//
//     final resultConfirmOtpntd = resultConfirmOtpntdFromJson(jsonString);

import 'dart:convert';

ResultConfirmOtpntd resultConfirmOtpntdFromJson(String str) => ResultConfirmOtpntd.fromJson(json.decode(str));

String resultConfirmOtpntdToJson(ResultConfirmOtpntd data) => json.encode(data.toJson());

class ResultConfirmOtpntd {
  ResultConfirmOtpntd({
    this.data,
    this.error,
  });

  Data data;
  Error error;

  factory ResultConfirmOtpntd.fromJson(Map<String, dynamic> json) => ResultConfirmOtpntd(
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
    error: json["error"] == null ? null : Error.fromJson(json["error"]),
  );

  Map<String, dynamic> toJson() => {
    "data": data == null ? null : data.toJson(),
    "error": error == null ? null : error.toJson(),
  };
}

class Data {
  Data({
    this.result,
    this.id,
    this.accessToken,
    this.message,
  });

  bool result;
  String id;
  String accessToken;
  String message;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    result: json["result"] == null ? null : json["result"],
    id: json["id"] == null ? null : json["id"],
    accessToken: json["access_token"] == null ? null : json["access_token"],
    message: json["message"] == null ? null : json["message"],
  );

  Map<String, dynamic> toJson() => {
    "result": result == null ? null : result,
    "id": id == null ? null : id,
    "access_token": accessToken == null ? null : accessToken,
    "message": message == null ? null : message,
  };
}

class Error {
  Error({
    this.code,
    this.message,
  });

  int code;
  String message;

  factory Error.fromJson(Map<String, dynamic> json) => Error(
    code: json["code"] == null ? null : json["code"],
    message: json["message"] == null ? null : json["message"],
  );

  Map<String, dynamic> toJson() => {
    "code": code == null ? null : code,
    "message": message == null ? null : message,
  };
}
