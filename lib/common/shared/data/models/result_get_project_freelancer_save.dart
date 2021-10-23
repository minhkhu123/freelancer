// To parse this JSON data, do
//
//     final resultGetProjectFreelancerSave = resultGetProjectFreelancerSaveFromJson(jsonString);

import 'dart:convert';

ResultGetProjectFreelancerSave resultGetProjectFreelancerSaveFromJson(String str) => ResultGetProjectFreelancerSave.fromJson(json.decode(str));

String resultGetProjectFreelancerSaveToJson(ResultGetProjectFreelancerSave data) => json.encode(data.toJson());

class ResultGetProjectFreelancerSave {
  ResultGetProjectFreelancerSave({
    this.data,
    this.error,
  });

  Data data;
  Error error;

  factory ResultGetProjectFreelancerSave.fromJson(Map<String, dynamic> json) => ResultGetProjectFreelancerSave(
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
    this.listProjectSaved,
  });

  bool result;
  List<ListProjectSaved> listProjectSaved;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    result: json["result"] == null ? null : json["result"],
    listProjectSaved: json["list_project_saved"] == null ? null : List<ListProjectSaved>.from(json["list_project_saved"].map((x) => ListProjectSaved.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "result": result == null ? null : result,
    "list_project_saved": listProjectSaved == null ? null : List<dynamic>.from(listProjectSaved.map((x) => x.toJson())),
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

class ListProjectSaved {
  ListProjectSaved({
    this.idProject,
    this.name,
    this.kinhPhiDuKien,
    this.kyNang,
    this.ngayHetHan,
    this.ngayDatGiaKetThuc,
  });

  String idProject;
  String name;
  String kinhPhiDuKien;
  String kyNang;
  String ngayHetHan;
  String ngayDatGiaKetThuc;

  factory ListProjectSaved.fromJson(Map<String, dynamic> json) => ListProjectSaved(
    idProject: json["id_project"] == null ? null : json["id_project"],
    name: json["name"] == null ? null : json["name"],
    kinhPhiDuKien: json["kinh_phi_du_kien"] == null ? null : json["kinh_phi_du_kien"],
    kyNang: json["ky_nang"] == null ? null : json["ky_nang"],
    ngayHetHan: json["ngay_het_han"] == null ? null : json["ngay_het_han"],
    ngayDatGiaKetThuc: json["ngay_dat_gia_ket_thuc"] == null ? null : json["ngay_dat_gia_ket_thuc"],
  );

  Map<String, dynamic> toJson() => {
    "id_project": idProject == null ? null : idProject,
    "name": name == null ? null : name,
    "kinh_phi_du_kien": kinhPhiDuKien == null ? null : kinhPhiDuKien,
    "ky_nang": kyNang == null ? null : kyNang,
    "ngay_het_han": ngayHetHan == null ? null : ngayHetHan,
    "ngay_dat_gia_ket_thuc": ngayDatGiaKetThuc == null ? null : ngayDatGiaKetThuc,
  };
}
