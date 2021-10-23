// To parse this JSON data, do
//
//     final resultGetNotificationCompany = resultGetNotificationCompanyFromJson(jsonString);

import 'dart:convert';

ResultGetNotificationCompany resultGetNotificationCompanyFromJson(String str) => ResultGetNotificationCompany.fromJson(json.decode(str));

String resultGetNotificationCompanyToJson(ResultGetNotificationCompany data) => json.encode(data.toJson());

class ResultGetNotificationCompany {
  ResultGetNotificationCompany({
    this.data,
    this.error,
  });

  Data data;
  Error error;

  factory ResultGetNotificationCompany.fromJson(Map<String, dynamic> json) => ResultGetNotificationCompany(
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
    this.listNotify,
  });

  bool result;
  List<ListNotifyCompany> listNotify;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    result: json["result"] == null ? null : json["result"],
    listNotify: json["list_notify"] == null ? null : List<ListNotifyCompany>.from(json["list_notify"].map((x) => ListNotifyCompany.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "result": result == null ? null : result,
    "list_notify": listNotify == null ? null : List<dynamic>.from(listNotify.map((x) => x.toJson())),
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

class ListNotifyCompany {
  ListNotifyCompany({
    this.avtFlc,
    this.linkAvt,
    this.name,
    this.textNotify,
    this.timeNotify,
  });

  String avtFlc;
  String linkAvt;
  String name;
  String textNotify;
  String timeNotify;

  factory ListNotifyCompany.fromJson(Map<String, dynamic> json) => ListNotifyCompany(
    avtFlc: json["avt_flc"] == null ? null : json["avt_flc"],
    linkAvt: json["link_avt"] == null ? null : json["link_avt"],
    name: json["name"] == null ? null : json["name"],
    textNotify: json["text_notify"] == null ? null : json["text_notify"],
    timeNotify: json["time_notify"] == null ? null : json["time_notify"],
  );

  Map<String, dynamic> toJson() => {
    "avt_flc": avtFlc == null ? null : avtFlc,
    "link_avt": linkAvt == null ? null : linkAvt,
    "name": name == null ? null : name,
    "text_notify": textNotify == null ? null : textNotify,
    "time_notify": timeNotify == null ? null : timeNotify,
  };
}
