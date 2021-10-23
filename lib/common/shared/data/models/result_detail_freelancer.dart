// To parse this JSON data, do
//
//     final resultDetailFreelancer = resultDetailFreelancerFromJson(jsonString);

import 'dart:convert';

ResultDetailFreelancer resultDetailFreelancerFromJson(String str) => ResultDetailFreelancer.fromJson(json.decode(str));

String resultDetailFreelancerToJson(ResultDetailFreelancer data) => json.encode(data.toJson());

class ResultDetailFreelancer {
  ResultDetailFreelancer({
    this.data,
    this.error,
  });

  Data data;
  dynamic error;

  factory ResultDetailFreelancer.fromJson(Map<String, dynamic> json) => ResultDetailFreelancer(
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
    this.freelancerInfor,
    this.projectImage,
    this.projectFile,
    this.topFlc,
  });

  FreelancerInfor freelancerInfor;
  List<ProjectImageDetail> projectImage;
  List<ProjectFileDetail> projectFile;
  List<TopFlc> topFlc;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    freelancerInfor: json["freelancer_infor"] == null ? null : FreelancerInfor.fromJson(json["freelancer_infor"]),
    projectImage: json["project_image"] == null ? null : List<ProjectImageDetail>.from(json["project_image"].map((x) => ProjectImageDetail.fromJson(x))),
    projectFile: json["project_file"] == null ? null : List<ProjectFileDetail>.from(json["project_file"].map((x) => ProjectFileDetail.fromJson(x))),
    topFlc: json["top_flc"] == null ? null : List<TopFlc>.from(json["top_flc"].map((x) => TopFlc.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "freelancer_infor": freelancerInfor == null ? null : freelancerInfor.toJson(),
    "project_image": projectImage == null ? null : List<dynamic>.from(projectImage.map((x) => x.toJson())),
    "project_file": projectFile == null ? null : List<dynamic>.from(projectFile.map((x) => x.toJson())),
    "top_flc": topFlc == null ? null : List<dynamic>.from(topFlc.map((x) => x.toJson())),
  };
}

class FreelancerInfor {
  FreelancerInfor({
    this.id,
    this.hoTen,
    this.avatar,
    this.pathAvt,
    this.diaChi,
    this.ngaySinh,
    this.gioiTinh,
    this.sdt,
    this.email,
    this.viewed,
    this.saved,
    this.kinhNghiem,
    this.gioiThieu,
    this.nganhNghe,
    this.ngheNghiep,
    this.kyNang,
    this.hinhThucLamViec,
    this.perecentComplete,
    this.tbRate,
    this.xepLoai,
  });

  String id;
  String hoTen;
  String avatar;
  String pathAvt;
  String diaChi;
  String ngaySinh;
  String gioiTinh;
  String sdt;
  String email;
  bool viewed;
  bool saved;
  String kinhNghiem;
  String gioiThieu;
  String nganhNghe;
  String ngheNghiep;
  String kyNang;
  String hinhThucLamViec;
  double perecentComplete;
  double tbRate;
  String xepLoai;

  factory FreelancerInfor.fromJson(Map<String, dynamic> json) => FreelancerInfor(
    id: json["id"] == null ? null : json["id"],
    hoTen: json["ho_ten"] == null ? null : json["ho_ten"],
    avatar: json["avatar"] == null ? null : json["avatar"],
    pathAvt: json["path_avt"] == null ? null : json["path_avt"],
    diaChi: json["dia_chi"] == null ? null : json["dia_chi"],
    ngaySinh: json["ngay_sinh"] == null ? null : json["ngay_sinh"],
    gioiTinh: json["gioi_tinh"] == null ? null : json["gioi_tinh"],
    sdt: json["sdt"] == null ? null : json["sdt"],
    email: json["email"] == null ? null : json["email"],
    viewed: json["viewed"] == null ? null : json["viewed"],
    saved: json["saved"] == null ? null : json["saved"],
    kinhNghiem: json["kinh_nghiem"] == null ? null : json["kinh_nghiem"],
    gioiThieu: json["gioi_thieu"] == null ? null : json["gioi_thieu"],
    nganhNghe: json["nganh_nghe"] == null ? null : json["nganh_nghe"],
    ngheNghiep: json["nghe_nghiep"] == null ? null : json["nghe_nghiep"],
    kyNang: json["ky_nang"] == null ? null : json["ky_nang"],
    hinhThucLamViec: json["hinh_thuc_lam_viec"] == null ? null : json["hinh_thuc_lam_viec"],
    perecentComplete: json["perecent_complete"] == null ? null : json["perecent_complete"].toDouble(),
    tbRate: json["tb_rate"] == null ? null : json["tb_rate"].toDouble(),
    xepLoai: json["xep_loai"] == null ? null : json["xep_loai"],
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "ho_ten": hoTen == null ? null : hoTen,
    "avatar": avatar == null ? null : avatar,
    "path_avt": pathAvt == null ? null : pathAvt,
    "dia_chi": diaChi == null ? null : diaChi,
    "ngay_sinh": ngaySinh == null ? null : ngaySinh,
    "gioi_tinh": gioiTinh == null ? null : gioiTinh,
    "sdt": sdt == null ? null : sdt,
    "email": email == null ? null : email,
    "viewed": viewed == null ? null : viewed,
    "saved": saved == null ? null : saved,
    "kinh_nghiem": kinhNghiem == null ? null : kinhNghiem,
    "gioi_thieu": gioiThieu == null ? null : gioiThieu,
    "nganh_nghe": nganhNghe == null ? null : nganhNghe,
    "nghe_nghiep": ngheNghiep == null ? null : ngheNghiep,
    "ky_nang": kyNang == null ? null : kyNang,
    "hinh_thuc_lam_viec": hinhThucLamViec == null ? null : hinhThucLamViec,
    "perecent_complete": perecentComplete == null ? null : perecentComplete,
    "tb_rate": tbRate == null ? null : tbRate,
    "xep_loai": xepLoai == null ? null : xepLoai,
  };
}

class ProjectFileDetail {
  ProjectFileDetail({
    this.idProject,
    this.nameProject,
    this.nameFile,
    this.pathFile,
  });

  String idProject;
  String nameProject;
  String nameFile;
  String pathFile;

  factory ProjectFileDetail.fromJson(Map<String, dynamic> json) => ProjectFileDetail(
    idProject: json["id_project"] == null ? null : json["id_project"],
    nameProject: json["name_project"] == null ? null : json["name_project"],
    nameFile: json["name_file"] == null ? null : json["name_file"],
    pathFile: json["path_file"] == null ? null : json["path_file"],
  );

  Map<String, dynamic> toJson() => {
    "id_project": idProject == null ? null : idProject,
    "name_project": nameProject == null ? null : nameProject,
    "name_file": nameFile == null ? null : nameFile,
    "path_file": pathFile == null ? null : pathFile,
  };
}

class ProjectImageDetail {
  ProjectImageDetail({
    this.idImg,
    this.nameImg,
    this.pathProfileImg,
  });

  String idImg;
  String nameImg;
  String pathProfileImg;

  factory ProjectImageDetail.fromJson(Map<String, dynamic> json) => ProjectImageDetail(
    idImg: json["id_img"] == null ? null : json["id_img"],
    nameImg: json["name_img"] == null ? null : json["name_img"],
    pathProfileImg: json["path_profile_img"] == null ? null : json["path_profile_img"],
  );

  Map<String, dynamic> toJson() => {
    "id_img": idImg == null ? null : idImg,
    "name_img": nameImg == null ? null : nameImg,
    "path_profile_img": pathProfileImg == null ? null : pathProfileImg,
  };
}

class TopFlc {
  TopFlc({
    this.pathAvtFlcTop,
    this.anhAvt,
    this.idFlc,
    this.nameFlc,
    this.linkDetail,
    this.ngheNghiep,
    this.tinhThanh,
    this.kyNang,
    this.rateStar,
  });

  String pathAvtFlcTop;
  String anhAvt;
  String idFlc;
  String nameFlc;
  String linkDetail;
  String ngheNghiep;
  String tinhThanh;
  String kyNang;
  int rateStar;

  factory TopFlc.fromJson(Map<String, dynamic> json) => TopFlc(
    pathAvtFlcTop: json["path_avt_flc_top"] == null ? null : json["path_avt_flc_top"],
    anhAvt: json["anh_avt"] == null ? null : json["anh_avt"],
    idFlc: json["id_flc"] == null ? null : json["id_flc"],
    nameFlc: json["name_flc"] == null ? null : json["name_flc"],
    linkDetail: json["link_detail"] == null ? null : json["link_detail"],
    ngheNghiep: json["nghe_nghiep"] == null ? null : json["nghe_nghiep"],
    tinhThanh: json["tinh_thanh"] == null ? null : json["tinh_thanh"],
    kyNang: json["ky_nang"] == null ? null : json["ky_nang"],
    rateStar: json["rate_star"] == null ? null : json["rate_star"],
  );

  Map<String, dynamic> toJson() => {
    "path_avt_flc_top": pathAvtFlcTop == null ? null : pathAvtFlcTop,
    "anh_avt": anhAvt == null ? null : anhAvt,
    "id_flc": idFlc == null ? null : idFlc,
    "name_flc": nameFlc == null ? null : nameFlc,
    "link_detail": linkDetail == null ? null : linkDetail,
    "nghe_nghiep": ngheNghiep == null ? null : ngheNghiep,
    "tinh_thanh": tinhThanh == null ? null : tinhThanh,
    "ky_nang": kyNang == null ? null : kyNang,
    "rate_star": rateStar == null ? null : rateStar,
  };
}
