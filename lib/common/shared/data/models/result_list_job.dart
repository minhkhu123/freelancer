// To parse this JSON data, do
//
//     final resultGetListJobBySearch = resultGetListJobBySearchFromJson(jsonString);

import 'dart:convert';

ResultGetListJob resultGetListJobFromJson(String str) => ResultGetListJob.fromJson(json.decode(str));

String resultGetListJobToJson(ResultGetListJob data) => json.encode(data.toJson());

class ResultGetListJob {
  ResultGetListJob({
    this.data,
    this.error,
  });

  Data data;
  Error error;

  factory ResultGetListJob.fromJson(Map<String, dynamic> json) => ResultGetListJob(
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
    this.listJob,
  });

  bool result;
  List<ListJob> listJob;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    result: json["result"] == null ? null : json["result"],
    listJob: json["list_job"] == null ? null : List<ListJob>.from(json["list_job"].map((x) => ListJob.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "result": result == null ? null : result,
    "list_job": listJob == null ? null : List<dynamic>.from(listJob.map((x) => x.toJson())),
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

class ListJob {
  ListJob({
    this.anhLogo,
    this.pathLogo,
    this.loaiViecLam,
    this.tenViecLam,
    this.idJob,
    this.linkDetail,
    this.tenNtd,
    this.linhVuc,
    this.diaDiem,
    this.chiPhi,
    this.luotDatGia,
    this.hetHan,
    this.kyNang,
  });

  String anhLogo;
  String pathLogo;
  String loaiViecLam;
  String tenViecLam;
  String idJob;
  String linkDetail;
  String tenNtd;
  String linhVuc;
  String diaDiem;
  String chiPhi;
  String luotDatGia;
  String hetHan;
  String kyNang;

  factory ListJob.fromJson(Map<String, dynamic> json) => ListJob(
    anhLogo: json["anh_logo"] == null ? null : json["anh_logo"],
    pathLogo: json["path_logo"] == null ? null : json["path_logo"],
    loaiViecLam: json["loai_viec_lam"] == null ? null : json["loai_viec_lam"],
    tenViecLam: json["ten_viec_lam"] == null ? null : json["ten_viec_lam"],
    idJob: json["id_job"] == null ? null : json["id_job"],
    linkDetail: json["link_detail"] == null ? null : json["link_detail"],
    tenNtd: json["ten_ntd"] == null ? null : json["ten_ntd"],
    linhVuc: json["linh_vuc"] == null ? null : json["linh_vuc"],
    diaDiem: json["dia_diem"] == null ? null : json["dia_diem"],
    chiPhi: json["chi_phi"] == null ? null : json["chi_phi"],
    luotDatGia: json["luot_dat_gia"] == null ? null : json["luot_dat_gia"],
    hetHan: json["het_han"] == null ? null : json["het_han"],
    kyNang: json["ky_nang"] == null ? null : json["ky_nang"],
  );

  Map<String, dynamic> toJson() => {
    "anh_logo": anhLogo == null ? null : anhLogo,
    "path_logo": pathLogo == null ? null : pathLogo,
    "loai_viec_lam": loaiViecLam == null ? null : loaiViecLam,
    "ten_viec_lam": tenViecLam == null ? null : tenViecLam,
    "id_job": idJob == null ? null : idJob,
    "link_detail": linkDetail == null ? null : linkDetail,
    "ten_ntd": tenNtd == null ? null : tenNtd,
    "linh_vuc": linhVuc == null ? null : linhVuc,
    "dia_diem": diaDiem == null ? null : diaDiem,
    "chi_phi": chiPhi == null ? null : chiPhi,
    "luot_dat_gia": luotDatGia == null ? null : luotDatGia,
    "het_han": hetHan == null ? null : hetHan,
    "ky_nang": kyNang == null ? null : kyNang,
  };
}
