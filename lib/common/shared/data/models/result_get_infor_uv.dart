import 'dart:convert';

class ResultGetInforFreelancer {
  ResultGetInforFreelancer({
    this.data,
    this.error,
  });

  final Data data;
  final dynamic error;

  factory ResultGetInforFreelancer.fromRawJson(String str) => ResultGetInforFreelancer.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ResultGetInforFreelancer.fromJson(Map<String, dynamic> json) => ResultGetInforFreelancer(
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
    this.userInfor,
    this.projectImage,
    this.projectFile,
  });

  final bool result;
  final UserInfor userInfor;
  final List<dynamic> projectImage;
  final List<ProjectFile> projectFile;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    result: json["result"] == null ? null : json["result"],
    userInfor: json["user_infor"] == null ? null : UserInfor.fromJson(json["user_infor"]),
    projectImage: json["project_image"] == null ? null : List<dynamic>.from(json["project_image"].map((x) => x)),
    projectFile: json["project_file"] == null ? null : List<ProjectFile>.from(json["project_file"].map((x) => ProjectFile.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "result": result == null ? null : result,
    "user_infor": userInfor == null ? null : userInfor.toJson(),
    "project_image": projectImage == null ? null : List<dynamic>.from(projectImage.map((x) => x)),
    "project_file": projectFile == null ? null : List<dynamic>.from(projectFile.map((x) => x.toJson())),
  };
}
class ProjectImage {
  ProjectImage({
    this.idImg,
    this.nameImg,
    this.pathProfileImg,
  });

  final String idImg;
  final String nameImg;
  final String pathProfileImg;

  factory ProjectImage.fromJson(Map<String, dynamic> json) => ProjectImage(
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

class ProjectFile {
  ProjectFile({
    this.idProject,
    this.nameProject,
    this.nameFile,
    this.pathFile,
  });

  final String idProject;
  final String nameProject;
  final String nameFile;
  final String pathFile;

  factory ProjectFile.fromJson(Map<String, dynamic> json) => ProjectFile(
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

class UserInfor {
  UserInfor({
    this.id,
    this.ten,
    this.avatar,
    this.pathAvt,
    this.tuoi,
    this.tinhThanhTxt,
    this.luotXem,
    this.hoTen,
    this.ngaySinh,
    this.gioiTinh,
    this.sdt,
    this.email,
    this.tinhThanh,
    this.quanHuyen,
    this.kinhNghiem,
    this.gioiThieu,
    this.ngheNghiep,
    this.cvMongMuon,
    this.hinhThucLamViec,
    this.noiLamViecMongMuon,
    this.loaiLuong,
    this.mucLuong,
    this.traLuongTheo,
    this.linhVucLamViec,
    this.kyNang,
  });

  final String id;
  final String ten;
  final String avatar;
  final String pathAvt;
  final String tuoi;
  final String tinhThanhTxt;
  final String luotXem;
  final String hoTen;
  final String ngaySinh;
  final String gioiTinh;
  final String sdt;
  final String email;
  final String tinhThanh;
  final String quanHuyen;
  final String kinhNghiem;
  final String gioiThieu;
  final String ngheNghiep;
  final String cvMongMuon;
  final String hinhThucLamViec;
  final String noiLamViecMongMuon;
  final String loaiLuong;
  final String mucLuong;
  final String traLuongTheo;
  final String linhVucLamViec;
  final String kyNang;

  factory UserInfor.fromJson(Map<String, dynamic> json) => UserInfor(
    id: json["id"] == null ? null : json["id"],
    ten: json["ten"] == null ? null : json["ten"],
    avatar: json["avatar"] == null ? null : json["avatar"],
    pathAvt: json["path_avt"] == null ? null : json["path_avt"],
    tuoi: json["tuoi"] == null ? null : json["tuoi"],
    tinhThanhTxt: json["tinh_thanh_txt"] == null ? null : json["tinh_thanh_txt"],
    luotXem: json["luot_xem"] == null ? null : json["luot_xem"],
    hoTen: json["ho_ten"] == null ? null : json["ho_ten"],
    ngaySinh: json["ngay_sinh"] == null ? null : json["ngay_sinh"],
    gioiTinh: json["gioi_tinh"] == null ? null : json["gioi_tinh"],
    sdt: json["sdt"] == null ? null : json["sdt"],
    email: json["email"] == null ? null : json["email"],
    tinhThanh: json["tinh_thanh"] == null ? null : json["tinh_thanh"],
    quanHuyen: json["quan_huyen"] == null ? null : json["quan_huyen"],
    kinhNghiem: json["kinh_nghiem"] == null ? null : json["kinh_nghiem"],
    gioiThieu: json["gioi_thieu"] == null ? null : json["gioi_thieu"],
    ngheNghiep: json["nghe_nghiep"] == null ? null : json["nghe_nghiep"],
    cvMongMuon: json["cv_mong_muon"] == null ? null : json["cv_mong_muon"],
    hinhThucLamViec: json["hinh_thuc_lam_viec"] == null ? null : json["hinh_thuc_lam_viec"],
    noiLamViecMongMuon: json["noi_lam_viec_mong_muon"] == null ? null : json["noi_lam_viec_mong_muon"],
    loaiLuong: json["loai_luong"] == null ? null : json["loai_luong"],
    mucLuong: json["muc_luong"] == null ? null : json["muc_luong"],
    traLuongTheo: json["tra_luong_theo"] == null ? null : json["tra_luong_theo"],
    linhVucLamViec: json["linh_vuc_lam_viec"] == null ? null : json["linh_vuc_lam_viec"],
    kyNang: json["ky_nang"] == null ? null : json["ky_nang"],
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "ten": ten == null ? null : ten,
    "avatar": avatar == null ? null : avatar,
    "path_avt": pathAvt == null ? null : pathAvt,
    "tuoi": tuoi == null ? null : tuoi,
    "tinh_thanh_txt": tinhThanhTxt == null ? null : tinhThanhTxt,
    "luot_xem": luotXem == null ? null : luotXem,
    "ho_ten": hoTen == null ? null : hoTen,
    "ngay_sinh": ngaySinh == null ? null : ngaySinh,
    "gioi_tinh": gioiTinh == null ? null : gioiTinh,
    "sdt": sdt == null ? null : sdt,
    "email": email == null ? null : email,
    "tinh_thanh": tinhThanh == null ? null : tinhThanh,
    "quan_huyen": quanHuyen == null ? null : quanHuyen,
    "kinh_nghiem": kinhNghiem == null ? null : kinhNghiem,
    "gioi_thieu": gioiThieu == null ? null : gioiThieu,
    "nghe_nghiep": ngheNghiep == null ? null : ngheNghiep,
    "cv_mong_muon": cvMongMuon == null ? null : cvMongMuon,
    "hinh_thuc_lam_viec": hinhThucLamViec == null ? null : hinhThucLamViec,
    "noi_lam_viec_mong_muon": noiLamViecMongMuon == null ? null : noiLamViecMongMuon,
    "loai_luong": loaiLuong == null ? null : loaiLuong,
    "muc_luong": mucLuong == null ? null : mucLuong,
    "tra_luong_theo": traLuongTheo == null ? null : traLuongTheo,
    "linh_vuc_lam_viec": linhVucLamViec == null ? null : linhVucLamViec,
    "ky_nang": kyNang == null ? null : kyNang,
  };
}
