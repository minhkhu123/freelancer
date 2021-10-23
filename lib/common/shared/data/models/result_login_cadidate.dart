// To parse this JSON data, do
//
//     final resultLoginCandidate = resultLoginCandidateFromJson(jsonString);

import 'dart:convert';

ResultLoginCandidate resultLoginCandidateFromJson(String str) => ResultLoginCandidate.fromJson(json.decode(str));

String resultLoginCandidateToJson(ResultLoginCandidate data) => json.encode(data.toJson());

class ResultLoginCandidate {
  ResultLoginCandidate({
    this.data,
    this.error,
  });

  Data data;
  Error error;

  factory ResultLoginCandidate.fromJson(Map<String, dynamic> json) => ResultLoginCandidate(
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
    this.message,
    this.accessToken,
    this.token,
    this.xacThuc,
    this.userInfo,
  });

  bool result;
  String message;
  String accessToken;
  String token;
  bool xacThuc;
  UserInfo userInfo;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    result: json["result"] == null ? null : json["result"],
    message: json["message"] == null ? null : json["message"],
    accessToken: json["access_token"] == null ? null : json["access_token"],
    token: json["token"] == null ? null : json["token"],
    xacThuc: json["xac_thuc"] == null ? null : json["xac_thuc"],
    userInfo: json["user_info"] == null ? null : UserInfo.fromJson(json["user_info"]),
  );

  Map<String, dynamic> toJson() => {
    "result": result == null ? null : result,
    "message": message == null ? null : message,
    "access_token": accessToken == null ? null : accessToken,
    "token": token == null ? null : token,
    "xac_thuc": xacThuc == null ? null : xacThuc,
    "user_info": userInfo == null ? null : userInfo.toJson(),
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


class UserInfo {
  UserInfo({
    this.epId,
    this.epEmail,
    this.epPassword,
    this.epName,
    this.epPhone,
    this.epLogo,
    this.epPathLogo,
    this.gt,
    this.epBirthday,
    this.createTime,
    this.updateTime,
    this.epLat,
    this.epLong,
  });

  String epId;
  String epEmail;
  String epPassword;
  String epName;
  String epPhone;
  String epLogo;
  String epPathLogo;
  String gt;
  String epBirthday;
  String createTime;
  String updateTime;
  dynamic epLat;
  dynamic epLong;

  factory UserInfo.fromJson(Map<String, dynamic> json) => UserInfo(
    epId: json["ep_id"] == null ? null : json["ep_id"],
    epEmail: json["ep_email"] == null ? null : json["ep_email"],
    epPassword: json["ep_password"] == null ? null : json["ep_password"],
    epName: json["ep_name"] == null ? null : json["ep_name"],
    epPhone: json["ep_phone"] == null ? null : json["ep_phone"],
    epLogo: json["ep_logo"] == null ? null : json["ep_logo"],
    epPathLogo: json["ep_path_logo"] == null ? null : json["ep_path_logo"],
    gt: json["gt"] == null ? null : json["gt"],
    epBirthday: json["ep_birthday"] == null ? null : json["ep_birthday"],
    createTime: json["create_time"] == null ? null : json["create_time"],
    updateTime: json["update_time"] == null ? null : json["update_time"],
    epLat: json["ep_lat"],
    epLong: json["ep_long"],
  );

  Map<String, dynamic> toJson() => {
    "ep_id": epId == null ? null : epId,
    "ep_email": epEmail == null ? null : epEmail,
    "ep_password": epPassword == null ? null : epPassword,
    "ep_name": epName == null ? null : epName,
    "ep_phone": epPhone == null ? null : epPhone,
    "ep_logo": epLogo == null ? null : epLogo,
    "ep_path_logo": epPathLogo == null ? null : epPathLogo,
    "gt": gt == null ? null : gt,
    "ep_birthday": epBirthday == null ? null : epBirthday,
    "create_time": createTime == null ? null : createTime,
    "update_time": updateTime == null ? null : updateTime,
    "ep_lat": epLat,
    "ep_long": epLong,
  };
}
