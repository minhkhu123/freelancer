// To parse this JSON data, do
//
//     final resultLoadMoreFreelancerDeal = resultLoadMoreFreelancerDealFromJson(jsonString);

import 'dart:convert';

ResultLoadMoreFreelancerDeal resultLoadMoreFreelancerDealFromJson(String str) => ResultLoadMoreFreelancerDeal.fromJson(json.decode(str));

String resultLoadMoreFreelancerDealToJson(ResultLoadMoreFreelancerDeal data) => json.encode(data.toJson());

class ResultLoadMoreFreelancerDeal {
  ResultLoadMoreFreelancerDeal({
    this.data,
    this.error,
  });

  Data data;
  Error error;

  factory ResultLoadMoreFreelancerDeal.fromJson(Map<String, dynamic> json) => ResultLoadMoreFreelancerDeal(
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
    this.flcDatGia,
  });

  bool result;
  List<FlcDatGiaLoadMore> flcDatGia;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    result: json["result"] == null ? null : json["result"],
    flcDatGia: json["flc_dat_gia"] == null ? null : List<FlcDatGiaLoadMore>.from(json["flc_dat_gia"].map((x) => FlcDatGiaLoadMore.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "result": result == null ? null : result,
    "flc_dat_gia": flcDatGia == null ? null : List<dynamic>.from(flcDatGia.map((x) => x.toJson())),
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

class FlcDatGiaLoadMore {
  FlcDatGiaLoadMore({
    this.avatarFlc,
    this.linkAvtFlc,
    this.idFlc,
    this.tenFlc,
    this.ngheNghiepFlc,
    this.datGia,
    this.saoTbFlc,
    this.gioiThieu,
  });

  String avatarFlc;
  String linkAvtFlc;
  String idFlc;
  String tenFlc;
  String ngheNghiepFlc;
  String datGia;
  int saoTbFlc;
  String gioiThieu;

  factory FlcDatGiaLoadMore.fromJson(Map<String, dynamic> json) => FlcDatGiaLoadMore(
    avatarFlc: json["avatar_flc"] == null ? null : json["avatar_flc"],
    linkAvtFlc: json["link_avt_flc"] == null ? null : json["link_avt_flc"],
    idFlc: json["id_flc"] == null ? null : json["id_flc"],
    tenFlc: json["ten_flc"] == null ? null : json["ten_flc"],
    ngheNghiepFlc: json["nghe_nghiep_flc"] == null ? null : json["nghe_nghiep_flc"],
    datGia: json["dat_gia"] == null ? null : json["dat_gia"],
    saoTbFlc: json["sao_tb_flc"] == null ? null : json["sao_tb_flc"],
    gioiThieu: json["gioi_thieu"] == null ? null : json["gioi_thieu"],
  );

  Map<String, dynamic> toJson() => {
    "avatar_flc": avatarFlc == null ? null : avatarFlc,
    "link_avt_flc": linkAvtFlc == null ? null : linkAvtFlc,
    "id_flc": idFlc == null ? null : idFlc,
    "ten_flc": tenFlc == null ? null : tenFlc,
    "nghe_nghiep_flc": ngheNghiepFlc == null ? null : ngheNghiepFlc,
    "dat_gia": datGia == null ? null : datGia,
    "sao_tb_flc": saoTbFlc == null ? null : saoTbFlc,
    "gioi_thieu": gioiThieu == null ? null : gioiThieu,
  };
}
