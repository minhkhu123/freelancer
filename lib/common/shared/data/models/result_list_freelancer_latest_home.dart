// To parse this JSON data, do
//
//     final resultListFreelancerLatestHome = resultListFreelancerLatestHomeFromJson(jsonString);

import 'dart:convert';

ResultListFreelancerLatestHome resultListFreelancerLatestHomeFromJson(String str) => ResultListFreelancerLatestHome.fromJson(json.decode(str));

String resultListFreelancerLatestHomeToJson(ResultListFreelancerLatestHome data) => json.encode(data.toJson());

class ResultListFreelancerLatestHome {
  ResultListFreelancerLatestHome({
    this.data,
    this.error,
  });

  Data data;
  dynamic error;

  factory ResultListFreelancerLatestHome.fromJson(Map<String, dynamic> json) => ResultListFreelancerLatestHome(
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
    this.listFlc,
  });

  bool result;
  List<ListFlcLatestHome> listFlc;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    result: json["result"] == null ? null : json["result"],
    listFlc: json["list_flc"] == null ? null : List<ListFlcLatestHome>.from(json["list_flc"].map((x) => ListFlcLatestHome.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "result": result == null ? null : result,
    "list_flc": listFlc == null ? null : List<dynamic>.from(listFlc.map((x) => x.toJson())),
  };
}

class ListFlcLatestHome {
  ListFlcLatestHome({
    this.avatar,
    this.path,
    this.hoTen,
    this.maUser,
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
  bool viewed;
  String ngheNghiep;
  String diaChi;
  String kinhNghiem;
  String sdt;
  String linkDetail;
  String kyNang;
  int rateStar;

  factory ListFlcLatestHome.fromJson(Map<String, dynamic> json) => ListFlcLatestHome(
    avatar: json["avatar"] == null ? null : json["avatar"],
    path: json["path"] == null ? null : json["path"],
    hoTen: json["ho_ten"] == null ? null : json["ho_ten"],
    maUser: json["ma_user"] == null ? null : json["ma_user"],
    viewed: json["viewed"] == null ? null : json["viewed"],
    ngheNghiep: json["nghe_nghiep"] == null ? null : json["nghe_nghiep"],
    diaChi: json["dia_chi"] == null ? null : json["dia_chi"],
    kinhNghiem: json["kinh_nghiem"] == null ? null : json["kinh_nghiem"],
    sdt: json["sdt"] == null ? null : json["sdt"],
    linkDetail: json["link_detail"] == null ? null : json["link_detail"],
    kyNang: json["ky_nang"] == null ? null : json["ky_nang"],
    rateStar: json["rate_star"] == null ? null : json["rate_star"],
  );

  Map<String, dynamic> toJson() => {
    "avatar": avatar == null ? null : avatar,
    "path": path == null ? null : path,
    "ho_ten": hoTen == null ? null : hoTen,
    "ma_user": maUser == null ? null : maUser,
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
