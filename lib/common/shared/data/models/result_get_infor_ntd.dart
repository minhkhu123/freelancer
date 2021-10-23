import 'dart:convert';

ResultGetInforNtd resultGetInforNtdFromJson(String str) =>
    ResultGetInforNtd.fromJson(json.decode(str));

String resultGetInforNtdToJson(ResultGetInforNtd data) =>
    json.encode(data.toJson());

class ResultGetInforNtd {
  ResultGetInforNtd({
    this.data,
    this.error,
  });

  Data data;
  dynamic error;

  factory ResultGetInforNtd.fromJson(Map<String, dynamic> json) =>
      ResultGetInforNtd(
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
    this.employerInfor,
  });

  bool result;
  EmployerInfor employerInfor;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        result: json["result"] == null ? null : json["result"],
        employerInfor: json["employer_infor"] == null
            ? null
            : EmployerInfor.fromJson(json["employer_infor"]),
      );

  Map<String, dynamic> toJson() => {
        "result": result == null ? null : result,
        "employer_infor": employerInfor == null ? null : employerInfor.toJson(),
      };
}

class EmployerInfor {
  EmployerInfor({
    this.id,
    this.avatar ='',
    this.linkAvatar ='',
    this.name,
    this.diem,
    this.birthday,
    this.sex,
    this.tel,
    this.email,
    this.provin,
    this.district,
  });

  String id;
  String avatar;
  String linkAvatar;
  String name;
  int diem;
  String birthday;
  String sex;
  String tel;
  String email;
  String provin;
  String district;

  factory EmployerInfor.fromJson(Map<String, dynamic> json) => EmployerInfor(
        id: json["id"] == null ? null : json["id"],
        avatar: json["avatar"] == null ? null : json["avatar"],
        linkAvatar: json["link_avatar"] == null ? null : json["link_avatar"],
        name: json["name"] == null ? null : json["name"],
        diem: json["diem"] == null ? null : json["diem"],
        birthday: json["birthday"] == null ? null : json["birthday"],
        sex: json["sex"] == null ? null : json["sex"],
        tel: json["tel"] == null ? null : json["tel"],
        email: json["email"] == null ? null : json["email"],
        provin: json["provin"] == null ? null : json["provin"],
        district: json["district"] == null ? null : json["district"],
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "avatar": avatar == null ? null : avatar,
        "link_avatar": linkAvatar == null ? null : linkAvatar,
        "name": name == null ? null : name,
        "diem": diem == null ? null : diem,
        "birthday": birthday == null ? null : birthday,
        "sex": sex == null ? null : sex,
        "tel": tel == null ? null : tel,
        "email": email == null ? null : email,
        "provin": provin == null ? null : provin,
        "district": district == null ? null : district,
      };
}
