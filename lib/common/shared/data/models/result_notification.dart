import 'dart:convert';

ResultNotification resultNotificationFromJson(String str) =>
    ResultNotification.fromJson(json.decode(str));

String resultNotificationToJson(ResultNotification data) =>
    json.encode(data.toJson());

class ResultNotification {
  ResultNotification({
    this.data,
    this.error,
  });

  Data data;
  Error error;

  factory ResultNotification.fromJson(Map<String, dynamic> json) =>
      ResultNotification(
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
        error: json["error"] == null ? null : Error.fromJson(json["error"]),
      );

  Map<String, dynamic> toJson() => {
        "data": data == null ? null : data.toJson(),
        "error": error == null ? null : error.toJson(),
      };
}

class Data {
  Data({this.result, this.message});

  bool result;
  String message;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
      result: json["result"] == null ? null : json["result"],
      message: json['message'] == null ? null : json['message']);

  Map<String, dynamic> toJson() => {
        "result": result == null ? null : result,
        'message': message == null ? null : message,
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
