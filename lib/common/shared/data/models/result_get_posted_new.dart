import 'dart:convert';

ResultGetPostedNews resultGetPostedNewsFromJson(String str) =>
    ResultGetPostedNews.fromJson(json.decode(str));

String resultGetPostedNewsToJson(ResultGetPostedNews data) =>
    json.encode(data.toJson());

class ResultGetPostedNews {
  Data data;
  Error error;
  ResultGetPostedNews({this.data, this.error});

  factory ResultGetPostedNews.fromJson(Map<String, dynamic> json) =>
      ResultGetPostedNews(
          data: json["data"] == null ? null : Data.fromJson(json["data"]),
          error: json["error"] == null ? null : Error.fromJson(json["error"]));
  Map<String, dynamic> toJson() => {
        "data": data == null ? null : data.toJson(),
        "error": error == null ? null : error.toJson()
      };
}

class Data {
  bool result;
  List<PostedNew> listPosted;
  Data({this.result, this.listPosted});

  factory Data.fromJson(Map<String, dynamic> json) => Data(
      result: json["result"] == null ? null : json["result"],
      listPosted: json['list_posted'] == null
          ? null
          : List.from(json['list_posted'].map((e) => PostedNew.fromJson(e))));

  Map<String, dynamic> toJson() => {
        "result": result == null ? null : result,
        'list_posted': listPosted == null
            ? null
            : List.from(listPosted.map((e) => e.toJson()))
      };
}

class Error {
  int code;
  String message;
  Error({this.code, this.message});

  factory Error.fromJson(Map<String, dynamic> json) => Error(
      code: json["code"] == null ? null : json["code"],
      message: json["message"] == null ? null : json["message"]);

  Map<String, dynamic> toJson() => {
        "code": code == null ? null : code,
        "message": message == null ? null : message
      };
}

class PostedNew {
  String id, tenCongViec, link, hinhThuc, hanCuoiDatGia, trangThai, linkEdit;
  PostedNew(
      {this.id,
      this.hanCuoiDatGia,
      this.hinhThuc,
      this.link,
      this.linkEdit,
      this.tenCongViec,
      this.trangThai});

  factory PostedNew.fromJson(Map<String, dynamic> json) => PostedNew(
      id: json['id'] == null ? null : json['id'],
      tenCongViec: json['ten_cong_viec'] == null ? null : json['ten_cong_viec'],
      hinhThuc: json['loai_viec_lam'] == null ? null : json['loai_viec_lam'],
      hanCuoiDatGia:
          json['han_cuoi_dat_gia'] == null ? null : json['han_cuoi_dat_gia'],
      link: json['link'] == null ? null : json['link'],
      linkEdit: json['link_edit'] == null ? null : json['link_edit'],
      trangThai: json['trang_thai'] == null ? null : json['trang_thai']);

  Map<String, dynamic> toJson() => {
        'id': id == null ? null : id,
        'ten_cong_viec': tenCongViec == null ? null : tenCongViec,
        'loai_viec_lam': hinhThuc == null ? null : hinhThuc,
        'han_cuoi_dat_gia': hanCuoiDatGia == null ? null : hanCuoiDatGia,
        'link': link == null ? null : link,
        'link_edit': linkEdit == null ? null : linkEdit,
        'trang_thai': trangThai == null ? null : trangThai
      };
}
