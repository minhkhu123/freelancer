import 'dart:convert';

ResultGetLatestJobsListing resultGetLatestJobsListingFromJson(String str) =>
    ResultGetLatestJobsListing.fromJson(json.decode(str));

String resultGetLatestJobsListingToJson(ResultGetLatestJobsListing data) =>
    json.encode(data.toJson());

class ResultGetLatestJobsListing {
  ResultGetLatestJobsListing({
    this.data,
    this.error,
  });

  Data data;
  Error error;

  factory ResultGetLatestJobsListing.fromJson(Map<String, dynamic> json) =>
      ResultGetLatestJobsListing(
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
        error: json["error"] == null? null: Error.fromJson(json['error']),
      );

  Map<String, dynamic> toJson() => {
        "data": data == null ? null : data.toJson(),
        "error": error == null? null: error.toJson(),
      };
}

class Error{
  int code;
  String message;
  Error({this.code, this.message});
  factory Error.fromJson(Map<String, dynamic> json)=> Error(
    code: json['code'] == null? null: json['code'],
    message: json['message'] == null? null: json['message']
  );
  Map<String, dynamic> toJson() => {
    'code': code == null? null: code,
    'message': message == null? null: message
  };
}

class Data {
  Data({
    this.result,
    this.list,
  });

  bool result;
  List<ListElement> list;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        result: json["result"] == null ? null : json["result"],
        list: json["list"] == null
            ? null
            : List<ListElement>.from(
                json["list"].map((x) => ListElement.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "result": result == null ? null : result,
        "list": list == null
            ? null
            : List<dynamic>.from(list.map((x) => x.toJson())),
      };
}

class ListElement {
  ListElement({
    this.maViecLam,
    this.tenCongViec,
    this.link,
    this.loaiViecLam,
    this.nganSachDuKien,
    this.luotDanhGia,
    this.hanCuoiDatGia,
    this.linkEdit,
  });

  String maViecLam;
  String tenCongViec;
  String link;
  String loaiViecLam;
  String nganSachDuKien;
  String luotDanhGia;
  String hanCuoiDatGia;
  String linkEdit;

  factory ListElement.fromJson(Map<String, dynamic> json) => ListElement(
        maViecLam: json["ma_viec_lam"] == null ? null : json["ma_viec_lam"],
        tenCongViec:
            json["ten_cong_viec"] == null ? null : json["ten_cong_viec"],
        link: json["link"] == null ? null : json["link"],
        loaiViecLam: json['loai_viec_lam'],
        nganSachDuKien: json["ngan_sach_du_kien"] == null
            ? null
            : json["ngan_sach_du_kien"],
        luotDanhGia:
            json["luot_danh_gia"] == null ? null : json["luot_danh_gia"],
        hanCuoiDatGia:
            json["han_cuoi_dat_gia"] == null ? null : json["han_cuoi_dat_gia"],
        linkEdit: json["link_edit"] == null ? null : json["link_edit"],
      );

  Map<String, dynamic> toJson() => {
        "ma_viec_lam": maViecLam == null ? null : maViecLam,
        "ten_cong_viec": tenCongViec == null ? null : tenCongViec,
        "link": link == null ? null : link,
        'loai_viec_lam': loaiViecLam,
        "ngan_sach_du_kien": nganSachDuKien == null ? null : nganSachDuKien,
        "luot_danh_gia": luotDanhGia == null ? null : luotDanhGia,
        "han_cuoi_dat_gia": hanCuoiDatGia == null ? null : hanCuoiDatGia,
        "link_edit": linkEdit == null ? null : linkEdit,
      };
}
