import 'dart:convert';

class ResultGetFreelancerWorking {
  ResultGetFreelancerWorking({
    this.data,
    this.error,
  });

  final Data data;
  final Error error;

  factory ResultGetFreelancerWorking.fromRawJson(String str) =>
      ResultGetFreelancerWorking.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ResultGetFreelancerWorking.fromJson(Map<String, dynamic> json) =>
      ResultGetFreelancerWorking(
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
        error: json["error"] == null ? null : Error.fromJson(json['error']),
      );

  Map<String, dynamic> toJson() => {
        "data": data == null ? null : data.toJson(),
        "error": error == null ? null : error.toJson(),
      };
}
class Error {
  int code;
  String message;
  Error({this.code, this.message});

  factory Error.fromJson(Map<String, dynamic> json) => Error(
      code: json['code'] == null ? null : json['code'],
      message: json['message'] == null ? null : json['message']);

  Map<String, dynamic> toJson() => {
    'code': code == null ? null : code,
    'message': message == null ? null : message
  };
}

class Data {
  Data({
    this.result,
    this.list,
  });

  final bool result;
  final List<ListElement> list;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        result: json["result"] == null ? null : json["result"],
        list: json["ListElement"] == null
            ? null
            : List<ListElement>.from(
                json["ListElement"].map((x) => ListElement.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "result": result == null ? null : result,
        "ListElement": list == null
            ? null
            : List<dynamic>.from(list.map((x) => x.toJson())),
      };
}

class ListElement {
  String idDatGia;
  String maFrelancer;
  String tenFreelancer;
  String linkFreelancer;
  String maViec;
  String tenDuAn;
  String linkDuAn;
  String nganSach;
  String ngayHetHan;
  String trangThai;
  int danhGia;

  ListElement({this.idDatGia, this.maFrelancer, this.tenFreelancer, this.linkFreelancer, this.maViec, this.tenDuAn, this.linkDuAn, this.nganSach, this.ngayHetHan, this.trangThai, this.danhGia});

  ListElement.fromJson(Map<String, dynamic> json) {
    this.idDatGia = json["id_dat_gia"];
    this.maFrelancer = json["ma_frelancer"];
    this.tenFreelancer = json["ten_freelancer"];
    this.linkFreelancer = json["link_freelancer"];
    this.maViec = json["ma_viec"];
    this.tenDuAn = json["ten_du_an"];
    this.linkDuAn = json["link_du_an"];
    this.nganSach = json["ngan_sach"];
    this.ngayHetHan = json["ngay_het_han"];
    this.trangThai = json["trang_thai"];
    this.danhGia = json["danh_gia"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data["id_dat_gia"] = this.idDatGia;
    data["ma_frelancer"] = this.maFrelancer;
    data["ten_freelancer"] = this.tenFreelancer;
    data["link_freelancer"] = this.linkFreelancer;
    data["ma_viec"] = this.maViec;
    data["ten_du_an"] = this.tenDuAn;
    data["link_du_an"] = this.linkDuAn;
    data["ngan_sach"] = this.nganSach;
    data["ngay_het_han"] = this.ngayHetHan;
    data["trang_thai"] = this.trangThai;
    data["danh_gia"] = this.danhGia;
    return data;
  }
}
