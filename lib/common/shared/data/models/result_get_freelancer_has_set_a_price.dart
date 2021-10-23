import 'dart:convert';

ResultGetFreelancerHasSetAPrice resultGetFreelancerHasSetAPriceFromJson(
        String str) =>
    ResultGetFreelancerHasSetAPrice.fromJson(json.decode(str));

String resultGetFreelancerHasSetAPriceToJson(
        ResultGetFreelancerHasSetAPrice data) =>
    json.encode(data.toJson());

class ResultGetFreelancerHasSetAPrice {
  ResultGetFreelancerHasSetAPrice({
    this.data,
    this.error,
  });

  Data data;
  Error error;

  factory ResultGetFreelancerHasSetAPrice.fromJson(Map<String, dynamic> json) =>
      ResultGetFreelancerHasSetAPrice(
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
    this.dsDatgia,
  });

  bool result;
  List<DsDatgia> dsDatgia;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        result: json["result"] == null ? null : json["result"],
        dsDatgia: json["ds_datgia"] == null
            ? null
            : List<DsDatgia>.from(
                json["ds_datgia"].map((x) => DsDatgia.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "result": result == null ? null : result,
        "ds_datgia": dsDatgia == null
            ? null
            : List<dynamic>.from(dsDatgia.map((x) => x.toJson())),
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
class DsDatgia {
  DsDatgia({
    this.idDatGia,
    this.tenFreelancer,
    this.idFlc,
    this.linkFreelancer,
    this.tenCongViec,
    this.maViec,
    this.linkCongViec,
    this.nganSachDuKien,
    this.datGia,
    this.lienHe,
  });

  final String idDatGia;
  final String tenFreelancer;
  final String idFlc;
  final String linkFreelancer;
  final String tenCongViec;
  final String maViec;
  final String linkCongViec;
  final String nganSachDuKien;
  final String datGia;
  final String lienHe;

  factory DsDatgia.fromJson(Map<String, dynamic> json) => DsDatgia(
    idDatGia: json["id_dat_gia"] == null ? null : json["id_dat_gia"],
    tenFreelancer: json["ten_freelancer"] == null ? null : json["ten_freelancer"],
    idFlc: json["id_flc"] == null ? null : json["id_flc"],
    linkFreelancer: json["link_freelancer"] == null ? null : json["link_freelancer"],
    tenCongViec: json["ten_cong_viec"] == null ? null : json["ten_cong_viec"],
    maViec: json["ma_viec"] == null ? null : json["ma_viec"],
    linkCongViec: json["link_cong_viec"] == null ? null : json["link_cong_viec"],
    nganSachDuKien: json["ngan_sach_du_kien"] == null ? null : json["ngan_sach_du_kien"],
    datGia: json["dat_gia"] == null ? null : json["dat_gia"],
    lienHe: json["lien_he"] == null ? null : json["lien_he"],
  );

  Map<String, dynamic> toJson() => {
    "id_dat_gia": idDatGia == null ? null : idDatGia,
    "ten_freelancer": tenFreelancer == null ? null : tenFreelancer,
    "id_flc": idFlc == null ? null : idFlc,
    "link_freelancer": linkFreelancer == null ? null : linkFreelancer,
    "ten_cong_viec": tenCongViec == null ? null : tenCongViec,
    "ma_viec": maViec == null ? null : maViec,
    "link_cong_viec": linkCongViec == null ? null : linkCongViec,
    "ngan_sach_du_kien": nganSachDuKien == null ? null : nganSachDuKien,
    "dat_gia": datGia == null ? null : datGia,
    "lien_he": lienHe == null ? null : lienHe,
  };
}



