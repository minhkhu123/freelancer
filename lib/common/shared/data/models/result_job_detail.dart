// To parse this JSON data, do
//
//     final resultJobDetail = resultJobDetailFromJson(jsonString);

import 'dart:convert';

ResultJobDetail resultJobDetailFromJson(String str) => ResultJobDetail.fromJson(json.decode(str));

String resultJobDetailToJson(ResultJobDetail data) => json.encode(data.toJson());

class ResultJobDetail {
  ResultJobDetail({
    this.data,
    this.error,
  });

  Data data;
  dynamic error;

  factory ResultJobDetail.fromJson(Map<String, dynamic> json) => ResultJobDetail(
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
    this.inforCompany,
    this.jobDetail,
    this.similarJob,
    this.flcDatGia,
  });

  bool result;
  InforCompany inforCompany;
  JobDetail jobDetail;
  List<SimilarJob> similarJob;
  List<FlcDatGia> flcDatGia;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    result: json["result"] == null ? null : json["result"],
    inforCompany: json["infor_company"] == null ? null : InforCompany.fromJson(json["infor_company"]),
    jobDetail: json["job_detail"] == null ? null : JobDetail.fromJson(json["job_detail"]),
    similarJob: json["similar_job"] == null ? null : List<SimilarJob>.from(json["similar_job"].map((x) => SimilarJob.fromJson(x))),
    flcDatGia: json["flc_dat_gia"] == null ? null : List<FlcDatGia>.from(json["flc_dat_gia"].map((x) => FlcDatGia.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "result": result == null ? null : result,
    "infor_company": inforCompany == null ? null : inforCompany.toJson(),
    "job_detail": jobDetail == null ? null : jobDetail.toJson(),
    "similar_job": similarJob == null ? null : List<dynamic>.from(similarJob.map((x) => x.toJson())),
    "flc_dat_gia": flcDatGia == null ? null : List<dynamic>.from(flcDatGia.map((x) => x.toJson())),
  };
}

class FlcDatGia {
  FlcDatGia({
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

  factory FlcDatGia.fromJson(Map<String, dynamic> json) => FlcDatGia(
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

class InforCompany {
  InforCompany({
    this.id,
    this.avatarNtd,
    this.linkAvt,
    this.linkDetailNtd,
    this.tenNtd,
    this.tinhTpNtd,
    this.sdt,
    this.email,
    this.thamGia,
    this.daDang,
  });

  String id;
  String avatarNtd;
  String linkAvt;
  String linkDetailNtd;
  String tenNtd;
  String tinhTpNtd;
  String sdt;
  String email;
  String thamGia;
  String daDang;

  factory InforCompany.fromJson(Map<String, dynamic> json) => InforCompany(
    id: json["id"] == null ? null : json["id"],
    avatarNtd: json["avatar_ntd"] == null ? null : json["avatar_ntd"],
    linkAvt: json["link_avt"] == null ? null : json["link_avt"],
    linkDetailNtd: json["link_detail_ntd"] == null ? null : json["link_detail_ntd"],
    tenNtd: json["ten_ntd"] == null ? null : json["ten_ntd"],
    tinhTpNtd: json["tinh_tp_ntd"] == null ? null : json["tinh_tp_ntd"],
    sdt: json["sdt"] == null ? null : json["sdt"],
    email: json["email"] == null ? null : json["email"],
    thamGia: json["tham_gia"] == null ? null : json["tham_gia"],
    daDang: json["da_dang"] == null ? null : json["da_dang"],
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "avatar_ntd": avatarNtd == null ? null : avatarNtd,
    "link_avt": linkAvt == null ? null : linkAvt,
    "link_detail_ntd": linkDetailNtd == null ? null : linkDetailNtd,
    "ten_ntd": tenNtd == null ? null : tenNtd,
    "tinh_tp_ntd": tinhTpNtd == null ? null : tinhTpNtd,
    "sdt": sdt == null ? null : sdt,
    "email": email == null ? null : email,
    "tham_gia": thamGia == null ? null : thamGia,
    "da_dang": daDang == null ? null : daDang,
  };
}

class JobDetail {
  JobDetail({
    this.anhLogoCv,
    this.pathAnhLogo,
    this.tenCv,
    this.saved,
    this.chiPhi,
    this.idDuAn,
    this.ngayDang,
    this.hinhThuc,
    this.ngayBd,
    this.datGiaKt,
    this.thoiHan,
    this.diaDiem,
    this.kinhNghiem,
    this.moTa,
    this.fileDinhKem,
    this.linkFile,
    this.kyNang,
    this.soLuongDatGiaCv,
  });

  String anhLogoCv;
  String pathAnhLogo;
  String tenCv;
  bool saved;
  String chiPhi;
  String idDuAn;
  String ngayDang;
  String hinhThuc;
  String ngayBd;
  String datGiaKt;
  String thoiHan;
  String diaDiem;
  String kinhNghiem;
  String moTa;
  String fileDinhKem;
  String linkFile;
  String kyNang;
  String soLuongDatGiaCv;

  factory JobDetail.fromJson(Map<String, dynamic> json) => JobDetail(
    anhLogoCv: json["anh_logo_cv"] == null ? null : json["anh_logo_cv"],
    pathAnhLogo: json["path_anh_logo"] == null ? null : json["path_anh_logo"],
    tenCv: json["ten_cv"] == null ? null : json["ten_cv"],
    saved: json["saved"] == null ? null : json["saved"],
    chiPhi: json["chi_phi"] == null ? null : json["chi_phi"],
    idDuAn: json["id_du_an"] == null ? null : json["id_du_an"],
    ngayDang: json["ngay_dang"] == null ? null : json["ngay_dang"],
    hinhThuc: json["hinh_thuc"] == null ? null : json["hinh_thuc"],
    ngayBd: json["ngay_bd"] == null ? null : json["ngay_bd"],
    datGiaKt: json["dat_gia_kt"] == null ? null : json["dat_gia_kt"],
    thoiHan: json["thoi_han"] == null ? null : json["thoi_han"],
    diaDiem: json["dia_diem"] == null ? null : json["dia_diem"],
    kinhNghiem: json["kinh_nghiem"] == null ? null : json["kinh_nghiem"],
    moTa: json["mo_ta"] == null ? null : json["mo_ta"],
    fileDinhKem: json["file_dinh_kem"] == null ? null : json["file_dinh_kem"],
    linkFile: json["link_file"] == null ? null : json["link_file"],
    kyNang: json["ky_nang"] == null ? null : json["ky_nang"],
    soLuongDatGiaCv: json["so_luong_dat_gia_cv"] == null ? null : json["so_luong_dat_gia_cv"],
  );

  Map<String, dynamic> toJson() => {
    "anh_logo_cv": anhLogoCv == null ? null : anhLogoCv,
    "path_anh_logo": pathAnhLogo == null ? null : pathAnhLogo,
    "ten_cv": tenCv == null ? null : tenCv,
    "saved": saved == null ? null : saved,
    "chi_phi": chiPhi == null ? null : chiPhi,
    "id_du_an": idDuAn == null ? null : idDuAn,
    "ngay_dang": ngayDang == null ? null : ngayDang,
    "hinh_thuc": hinhThuc == null ? null : hinhThuc,
    "ngay_bd": ngayBd == null ? null : ngayBd,
    "dat_gia_kt": datGiaKt == null ? null : datGiaKt,
    "thoi_han": thoiHan == null ? null : thoiHan,
    "dia_diem": diaDiem == null ? null : diaDiem,
    "kinh_nghiem": kinhNghiem == null ? null : kinhNghiem,
    "mo_ta": moTa == null ? null : moTa,
    "file_dinh_kem": fileDinhKem == null ? null : fileDinhKem,
    "link_file": linkFile == null ? null : linkFile,
    "ky_nang": kyNang == null ? null : kyNang,
    "so_luong_dat_gia_cv": soLuongDatGiaCv == null ? null : soLuongDatGiaCv,
  };
}

class SimilarJob {
  SimilarJob({
    this.id,
    this.tenViecLam,
    this.linkDetail,
    this.nganhNghe,
    this.loaiLuong,
    this.mucLuong,
    this.traLuongTheo,
  });

  String id;
  String tenViecLam;
  String linkDetail;
  String nganhNghe;
  String loaiLuong;
  String mucLuong;
  String traLuongTheo;

  factory SimilarJob.fromJson(Map<String, dynamic> json) => SimilarJob(
    id: json["id"] == null ? null : json["id"],
    tenViecLam: json["ten_viec_lam"] == null ? null : json["ten_viec_lam"],
    linkDetail: json["link_detail"] == null ? null : json["link_detail"],
    nganhNghe: json["nganh_nghe"] == null ? null : json["nganh_nghe"],
    loaiLuong: json["loai_luong"] == null ? null : json["loai_luong"],
    mucLuong: json["muc_luong"] == null ? null : json["muc_luong"],
    traLuongTheo: json["tra_luong_theo"] == null ? null : json["tra_luong_theo"],
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "ten_viec_lam": tenViecLam == null ? null : tenViecLam,
    "link_detail": linkDetail == null ? null : linkDetail,
    "nganh_nghe": nganhNghe == null ? null : nganhNghe,
    "loai_luong": loaiLuong == null ? null : loaiLuong,
    "muc_luong": mucLuong == null ? null : mucLuong,
    "tra_luong_theo": traLuongTheo == null ? null : traLuongTheo,
  };
}
