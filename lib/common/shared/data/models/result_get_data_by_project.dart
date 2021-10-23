import 'dart:convert';

ResultGetDataByProject resultGetDataByProjectFromJson(String str) =>
    ResultGetDataByProject.fromJson(json.decode(str));

String resultGetDataByProjectToJson(ResultGetDataByProject data) => json.encode(data.toJson());

class ResultGetDataByProject {
  ResultGetDataByProject({
    this.data,
    this.error,
  });

  Data data;
  dynamic error;

  factory ResultGetDataByProject.fromJson(Map<String, dynamic> json) =>
      ResultGetDataByProject(
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
    this.dataPost,
  });

  bool result;
  DataPost dataPost;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        result: json["result"] == null ? null : json["result"],
        dataPost: json["data_post"] == null
            ? null
            : DataPost.fromJson(json["data_post"]),
      );

  Map<String, dynamic> toJson() => {
        "result": result == null ? null : result,
        "data_post": dataPost == null ? null : dataPost.toJson(),
      };
}

class DataPost {
  DataPost({
    this.idPost,
    this.linkDetail,
    this.logo,
    this.srcLogo,
    this.titlePost,
    this.idLinhVuc,
    this.idHinhThuc,
    this.idKinhNghiem,
    this.idNoiLam,
    this.moTa,
    this.fileName,
    this.filePath,
    this.idKyNang,
    this.loaiLuong,
    this.mucLuong,
    this.idHinhThucTraLuong,
    this.ngayBdDatGia,
    this.ngayKtDatGia,
    this.ngayBdLamViec,
    this.ngayKtLamViec,
  });

  String idPost;
  String linkDetail;
  String logo;
  String srcLogo;
  String titlePost;
  String idLinhVuc;
  String idHinhThuc;
  String idKinhNghiem;
  String idNoiLam;
  String moTa;
  String fileName;
  String filePath;
  String idKyNang;
  String loaiLuong;
  String mucLuong;
  String idHinhThucTraLuong;
  String ngayBdDatGia;
  String ngayKtDatGia;
  String ngayBdLamViec;
  String ngayKtLamViec;

  factory DataPost.fromJson(Map<String, dynamic> json) => DataPost(
        idPost: json["id_post"] == null ? null : json["id_post"],
        linkDetail: json["link_detail"] == null ? null : json["link_detail"],
        logo: json["logo"] == null ? null : json["logo"],
        srcLogo: json["src_logo"] == null ? null : json["src_logo"],
        titlePost: json["title_post"] == null ? null : json["title_post"],
        idLinhVuc: json["id_linh_vuc"] == null ? null : json["id_linh_vuc"],
        idHinhThuc: json["id_hinh_thuc"] == null ? null : json["id_hinh_thuc"],
        idKinhNghiem:
            json["id_kinh_nghiem"] == null ? null : json["id_kinh_nghiem"],
        idNoiLam: json["id_noi_lam"] == null ? null : json["id_noi_lam"],
        moTa: json["mo_ta"] == null ? null : json["mo_ta"],
        fileName: json["file_name"] == null ? null : json["file_name"],
        filePath: json["file_path"] == null ? null : json["file_path"],
        idKyNang: json["id_ky_nang"] == null ? null : json["id_ky_nang"],
        loaiLuong: json["loai_luong"] == null ? null : json["loai_luong"],
        mucLuong: json["muc_luong"] == null ? null : json["muc_luong"],
        idHinhThucTraLuong: json["id_hinh_thuc_tra_luong"] == null
            ? null
            : json["id_hinh_thuc_tra_luong"],
        ngayBdDatGia:
            json["ngay_bd_dat_gia"] == null ? null : json["ngay_bd_dat_gia"],
        ngayKtDatGia:
            json["ngay_kt_dat_gia"] == null ? null : json["ngay_kt_dat_gia"],
        ngayBdLamViec:
            json["ngay_bd_lam_viec"] == null ? null : json["ngay_bd_lam_viec"],
    ngayKtLamViec: json["ngay_kt_lam_viec"] == null
            ? null
            : json["ngay_kt_lam_viec"],
      );

  Map<String, dynamic> toJson() => {
        "id_post": idPost == null ? null : idPost,
        "link_detail": linkDetail == null ? null : linkDetail,
        "logo": logo == null ? null : logo,
        "src_logo": srcLogo == null ? null : srcLogo,
        "title_post": titlePost == null ? null : titlePost,
        "id_linh_vuc": idLinhVuc == null ? null : idLinhVuc,
        "id_hinh_thuc": idHinhThuc == null ? null : idHinhThuc,
        "id_kinh_nghiem": idKinhNghiem == null ? null : idKinhNghiem,
        "id_noi_lam": idNoiLam == null ? null : idNoiLam,
        "mo_ta": moTa == null ? null : moTa,
        "file_name": fileName == null ? null : fileName,
        "file_path": filePath == null ? null : filePath,
        "id_ky_nang": idKyNang == null ? null : idKyNang,
        "loai_luong": loaiLuong == null ? null : loaiLuong,
        "muc_luong": mucLuong == null ? null : mucLuong,
        "id_hinh_thuc_tra_luong":
            idHinhThucTraLuong == null ? null : idHinhThucTraLuong,
        "ngay_bd_dat_gia": ngayBdDatGia == null ? null : ngayBdDatGia,
        "ngay_kt_dat_gia": ngayKtDatGia == null ? null : ngayKtDatGia,
        "ngay_bd_lam_viec": ngayBdLamViec == null ? null : ngayBdLamViec,
        "ngay_kt_lam_viec": ngayKtLamViec == null ? null : ngayKtLamViec,
      };
}
