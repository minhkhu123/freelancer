// To parse this JSON data, do
//
//     final resultJobPosted = resultJobPostedFromJson(jsonString);

import 'dart:convert';

ResultJobPosted resultJobPostedFromJson(String str) => ResultJobPosted.fromJson(json.decode(str));

String resultJobPostedToJson(ResultJobPosted data) => json.encode(data.toJson());

class ResultJobPosted {
  ResultJobPosted({
    this.data,
  });

  Data data;

  factory ResultJobPosted.fromJson(Map<String, dynamic> json) => ResultJobPosted(
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "data": data == null ? null : data.toJson(),
  };
}

class Data {
  Data({
    this.result,
    this.employeeInfor,
    this.congViecDaDang,
  });

  bool result;
  EmployeeInfor employeeInfor;
  List<CongViecDaDang> congViecDaDang;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    result: json["result"] == null ? null : json["result"],
    employeeInfor: json["employee_infor"] == null ? null : EmployeeInfor.fromJson(json["employee_infor"]),
    congViecDaDang: json["cong_viec_da_dang"] == null ? null : List<CongViecDaDang>.from(json["cong_viec_da_dang"].map((x) => CongViecDaDang.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "result": result == null ? null : result,
    "employee_infor": employeeInfor == null ? null : employeeInfor.toJson(),
    "cong_viec_da_dang": congViecDaDang == null ? null : List<dynamic>.from(congViecDaDang.map((x) => x.toJson())),
  };
}

class CongViecDaDang {
  CongViecDaDang({
    this.maCv,
    this.anhLogoCv,
    this.pathLogo,
    this.tenCv,
    this.diaChiCv,
    this.hinhThucCv,
    this.chiPhiCv,
    this.luotDatGiaCv,
    this.hetHanDatGiaCv,
    this.kyNangCv,
    this.linkChiTiet,
  });

  String maCv;
  String anhLogoCv;
  String pathLogo;
  String tenCv;
  dynamic diaChiCv;
  String hinhThucCv;
  String chiPhiCv;
  String luotDatGiaCv;
  String hetHanDatGiaCv;
  String kyNangCv;
  String linkChiTiet;

  factory CongViecDaDang.fromJson(Map<String, dynamic> json) => CongViecDaDang(
    maCv: json["ma_cv"] == null ? null : json["ma_cv"],
    anhLogoCv: json["anh_logo_cv"] == null ? null : json["anh_logo_cv"],
    pathLogo: json["path_logo"] == null ? null : json["path_logo"],
    tenCv: json["ten_cv"] == null ? null : json["ten_cv"],
    diaChiCv: json["dia_chi_cv"],
    hinhThucCv: json["hinh_thuc_cv"] == null ? null : json["hinh_thuc_cv"],
    chiPhiCv: json["chi_phi_cv"] == null ? null : json["chi_phi_cv"],
    luotDatGiaCv: json["luot_dat_gia_cv"] == null ? null : json["luot_dat_gia_cv"],
    hetHanDatGiaCv: json["het_han_dat_gia_cv"] == null ? null : json["het_han_dat_gia_cv"],
    kyNangCv: json["ky_nang_cv"] == null ? null : json["ky_nang_cv"],
    linkChiTiet: json["link_chi_tiet"] == null ? null : json["link_chi_tiet"],
  );

  Map<String, dynamic> toJson() => {
    "ma_cv": maCv == null ? null : maCv,
    "anh_logo_cv": anhLogoCv == null ? null : anhLogoCv,
    "path_logo": pathLogo == null ? null : pathLogo,
    "ten_cv": tenCv == null ? null : tenCv,
    "dia_chi_cv": diaChiCv,
    "hinh_thuc_cv": hinhThucCv == null ? null : hinhThucCv,
    "chi_phi_cv": chiPhiCv == null ? null : chiPhiCv,
    "luot_dat_gia_cv": luotDatGiaCv == null ? null : luotDatGiaCv,
    "het_han_dat_gia_cv": hetHanDatGiaCv == null ? null : hetHanDatGiaCv,
    "ky_nang_cv": kyNangCv == null ? null : kyNangCv,
    "link_chi_tiet": linkChiTiet == null ? null : linkChiTiet,
  };
}

class EmployeeInfor {
  EmployeeInfor({
    this.id,
    this.avatarNtd,
    this.pathAvt,
    this.tenNtd,
    this.tinhTpNtd,
    this.sdtNtd,
    this.emailNtd,
    this.thamGia,
    this.daDang,
  });

  int id;
  String avatarNtd;
  String pathAvt;
  String tenNtd;
  String tinhTpNtd;
  String sdtNtd;
  String emailNtd;
  String thamGia;
  String daDang;

  factory EmployeeInfor.fromJson(Map<String, dynamic> json) => EmployeeInfor(
    id: json["id"] == null ? null : json["id"],
    avatarNtd: json["avatar_ntd"] == null ? null : json["avatar_ntd"],
    pathAvt: json["path_avt"] == null ? null : json["path_avt"],
    tenNtd: json["ten_ntd"] == null ? null : json["ten_ntd"],
    tinhTpNtd: json["tinh_tp_ntd"] == null ? null : json["tinh_tp_ntd"],
    sdtNtd: json["sdt_ntd"] == null ? null : json["sdt_ntd"],
    emailNtd: json["email_ntd"] == null ? null : json["email_ntd"],
    thamGia: json["tham_gia"] == null ? null : json["tham_gia"],
    daDang: json["da_dang"] == null ? null : json["da_dang"],
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "avatar_ntd": avatarNtd == null ? null : avatarNtd,
    "path_avt": pathAvt == null ? null : pathAvt,
    "ten_ntd": tenNtd == null ? null : tenNtd,
    "tinh_tp_ntd": tinhTpNtd == null ? null : tinhTpNtd,
    "sdt_ntd": sdtNtd == null ? null : sdtNtd,
    "email_ntd": emailNtd == null ? null : emailNtd,
    "tham_gia": thamGia == null ? null : thamGia,
    "da_dang": daDang == null ? null : daDang,
  };
}
