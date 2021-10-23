// To parse this JSON data, do
//
//     final resultFreelancerPage = resultFreelancerPageFromJson(jsonString);

import 'dart:convert';

ResultFreelancer resultFreelancerFromJson(String str) => ResultFreelancer.fromJson(json.decode(str));

String resultFreelancerToJson(ResultFreelancer data) => json.encode(data.toJson());

class ResultFreelancer {
  ResultFreelancer({
    this.data,
    this.error,
  });

  Data data;
  Error error;

  factory ResultFreelancer.fromJson(Map<String, dynamic> json) => ResultFreelancer(
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
    this.listFlc,
  });

  bool result;
  List<ListFlc> listFlc;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    result: json["result"] == null ? null : json["result"],
    listFlc: json["list_flc"] == null ? null : List<ListFlc>.from(json["list_flc"].map((x) => ListFlc.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "result": result == null ? null : result,
    "list_flc": listFlc == null ? null : List<dynamic>.from(listFlc.map((x) => x.toJson())),
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

class ListFlc {
  ListFlc({
    this.avatar,
    this.path,
    this.hoTen,
    this.maUser,
    this.nganhNghe,
    this.viewed,
    this.ngheNghiep,
    this.diaChi,
    this.kinhNghiem,
    this.sdt,
    this.linkDetail,
    this.kyNang,
    this.rateStar,
  });

  String avatar;
  String path;
  String hoTen;
  String maUser;
  String nganhNghe;
  bool viewed;
  String ngheNghiep;
  String diaChi;
  String kinhNghiem;
  String sdt;
  String linkDetail;
  String kyNang;
  double rateStar;

  factory ListFlc.fromJson(Map<String, dynamic> json) => ListFlc(
    avatar: json["avatar"] == null ? null : json["avatar"],
    path: json["path"] == null ? null : json["path"],
    hoTen: json["ho_ten"] == null ? null : json["ho_ten"],
    maUser: json["ma_user"] == null ? null : json["ma_user"],
    nganhNghe: json["nganh_nghe"] == null ? null : json["nganh_nghe"],
    viewed: json["viewed"] == null ? null : json["viewed"],
    ngheNghiep: json["nghe_nghiep"] == null ? null : json["nghe_nghiep"],
    diaChi: json["dia_chi"] == null ? null : json["dia_chi"],
    kinhNghiem: json["kinh_nghiem"] == null ? null : json["kinh_nghiem"],
    sdt: json["sdt"] == null ? null : json["sdt"],
    linkDetail: json["link_detail"] == null ? null : json["link_detail"],
    kyNang: json["ky_nang"] == null ? null : json["ky_nang"],
    rateStar: json["rate_star"] == null ? null : json["rate_star"].toDouble(),
  );

  Map<String, dynamic> toJson() => {
    "avatar": avatar == null ? null : avatar,
    "path": path == null ? null : path,
    "ho_ten": hoTen == null ? null : hoTen,
    "ma_user": maUser == null ? null : maUser,
    "nganh_nghe": nganhNghe == null ? null : nganhNghe,
    "viewed": viewed == null ? null : viewed,
    "nghe_nghiep": ngheNghiep == null ? null : ngheNghiep,
    "dia_chi": diaChi == null ? null : diaChi,
    "kinh_nghiem": kinhNghiem == null ? null : kinhNghiem,
    "sdt": sdt == null ? null : sdt,
    "link_detail": linkDetail == null ? null : linkDetail,
    "ky_nang": kyNang == null ? null : kyNang,
    "rate_star": rateStar == null ? null : rateStar,
  };
}
