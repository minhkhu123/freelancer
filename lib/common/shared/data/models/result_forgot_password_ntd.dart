// To parse this JSON data, do
//
//     final resultForgotPasswordNtd = resultForgotPasswordNtdFromJson(jsonString);

import 'dart:convert';

import 'package:freelancer_app/common/shared/data/http/result_data.dart';

ResultForgotPasswordNtd resultForgotPasswordNtdFromJson(String str) => ResultForgotPasswordNtd.fromJson(json.decode(str));

String resultForgotPasswordNtdToJson(ResultForgotPasswordNtd data) => json.encode(data.toJson());

class ResultForgotPasswordNtd {
  ResultForgotPasswordNtd({
    this.data,
    this.error,
  });

  Data data;
  Error error;

  factory ResultForgotPasswordNtd.fromJson(Map<String, dynamic> json) => ResultForgotPasswordNtd(
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
    error: json["error"] == null ? null : Error.fromJson(json["error"]),
  );

  Map<String, dynamic> toJson() => {
    "data": data == null ? null : data.toJson(),
    "error": error == null ? null : error.toJson(),
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


class Data {
  Data({
    this.result,
    this.message,
    this.accessToken,
  });

  bool result;
  String message;
  String accessToken;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    result: json["result"] == null ? null : json["result"],
    message: json["message"] == null ? null : json["message"],
    accessToken: json["access_token"] == null ? null : json["access_token"],
  );

  Map<String, dynamic> toJson() => {
    "result": result == null ? null : result,
    "message": message == null ? null : message,
    "access_token": accessToken == null ? null : accessToken,
  };
}
