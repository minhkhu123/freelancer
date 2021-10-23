// To parse this JSON data, do
//
//     final resultListJobProjectHome = resultListJobProjectHomeFromJson(jsonString);

import 'dart:convert';

ResultListJobProjectHome resultListJobProjectHomeFromJson(String str) => ResultListJobProjectHome.fromJson(json.decode(str));

String resultListJobProjectHomeToJson(ResultListJobProjectHome data) => json.encode(data.toJson());

class ResultListJobProjectHome {
  ResultListJobProjectHome({
    this.data,
    this.error,
  });

  Data data;
  dynamic error;

  factory ResultListJobProjectHome.fromJson(Map<String, dynamic> json) => ResultListJobProjectHome(
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
    this.listJobProjectHome,
  });

  bool result;
  List<ListJobProjectHome> listJobProjectHome;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    result: json["result"] == null ? null : json["result"],
    listJobProjectHome: json["list_job"] == null ? null : List<ListJobProjectHome>.from(json["list_job"].map((x) => ListJobProjectHome.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "result": result == null ? null : result,
    "list_job": listJobProjectHome == null ? null : List<dynamic>.from(listJobProjectHome.map((x) => x.toJson())),
  };
}

class ListJobProjectHome {
  ListJobProjectHome({
    this.id,
    this.ten,
    this.logo,
    this.noiLamViec,
    this.loaiViecLam,
    this.datGiaKt,
    this.maLinhVuc,
    this.maKiNang,
    this.theLoaiChiPhi,
    this.chiPhi,
    this.chiPhiTheoGiDo,
  });

  String id;
  String ten;
  String logo;
  String noiLamViec;
  String loaiViecLam;
  String datGiaKt;
  String maLinhVuc;
  String maKiNang;
  String theLoaiChiPhi;
  String chiPhi;
  String chiPhiTheoGiDo;

  factory ListJobProjectHome.fromJson(Map<String, dynamic> json) => ListJobProjectHome(
    id: json["id"] == null ? null : json["id"],
    ten: json["ten"] == null ? null : json["ten"],
    logo: json["logo"] == null ? null : json["logo"],
    noiLamViec: json["noi_lam_viec"] == null ? null : json["noi_lam_viec"],
    loaiViecLam: json["loai_viec_lam"] == null ? null : json["loai_viec_lam"],
    datGiaKt: json["dat_gia_kt"] == null ? null : json["dat_gia_kt"],
    maLinhVuc: json["ma_linh_vuc"] == null ? null : json["ma_linh_vuc"],
    maKiNang: json["ma_ki_nang"] == null ? null : json["ma_ki_nang"],
    theLoaiChiPhi: json["the_loai_chi_phi"] == null ? null : json["the_loai_chi_phi"],
    chiPhi: json["chi_phi"] == null ? null : json["chi_phi"],
    chiPhiTheoGiDo: json["chi_phi_theo_gi_do"] == null ? null : json["chi_phi_theo_gi_do"],
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "ten": ten == null ? null : ten,
    "logo": logo == null ? null : logo,
    "noi_lam_viec": noiLamViec == null ? null : noiLamViec,
    "loai_viec_lam": loaiViecLam == null ? null : loaiViecLam,
    "dat_gia_kt": datGiaKt == null ? null : datGiaKt,
    "ma_linh_vuc": maLinhVuc == null ? null : maLinhVuc,
    "ma_ki_nang": maKiNang == null ? null : maKiNang,
    "the_loai_chi_phi": theLoaiChiPhi == null ? null : theLoaiChiPhi,
    "chi_phi": chiPhi == null ? null : chiPhi,
    "chi_phi_theo_gi_do": chiPhiTheoGiDo == null ? null : chiPhiTheoGiDo,
  };
}
