
import 'dart:convert';

ResultGetFreelancerSaved resultGetFreelancerSavedFromJson(String str) => ResultGetFreelancerSaved.fromJson(json.decode(str));
String resultGetFreelancerSavedToJson(ResultGetFreelancerSaved data) => json.encode(data.toJson());

class ResultGetFreelancerSaved {
  ResultGetFreelancerSaved({
    this.data,
    this.error,
  });

  Data data;
  Error error;

  factory ResultGetFreelancerSaved.fromJson(Map<String, dynamic> json) => ResultGetFreelancerSaved(
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
    error: json["error"] == null ? null : Error.fromJson(json['error']),
  );

  Map<String, dynamic> toJson() => {
    "data": data == null ? null : data.toJson(),
    "error": error == null ? null : error.toJson(),
  };
}

class Error{
  int code;
  String message;
  Error({this.code, this.message});

  factory Error.fromJson(Map<String, dynamic> json) => Error(
     code: json['code'] == null? null : json['code'],
     message: json['message'] ==null? null : json['message']
  );
  Map<String, dynamic> toJson() => {
    'code': code == null? null: code,
    'message': message ==null? null : message
  };
}

class Data {
  Data({
    this.result,
    this.listFlcSaved,
  });

  bool result;
  List<ListFlcSaved> listFlcSaved;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    result: json["result"] == null ? null : json["result"],
    listFlcSaved: json["list_flc_saved"] == null ? null : List<ListFlcSaved>.from(json["list_flc_saved"].map((x) => ListFlcSaved.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "result": result == null ? null : result,
    "list_flc_saved": listFlcSaved == null ? null : List<dynamic>.from(listFlcSaved.map((x) => x.toJson())),
  };
}

class ListFlcSaved {
  ListFlcSaved({
    this.id,
    this.tenFreelancer,
    this.linkFreelancer,
    this.nganhNghe,
    this.kyNang,
    this.diaChi,
    this.tbSaoDanhGia,
  });

  String id;
  String tenFreelancer;
  String linkFreelancer;
  String nganhNghe;
  String kyNang;
  String diaChi;
  double tbSaoDanhGia;

  factory ListFlcSaved.fromJson(Map<String, dynamic> json) => ListFlcSaved(
    id: json["id"] == null ? null : json["id"],
    tenFreelancer: json["ten_freelancer"] == null ? null : json["ten_freelancer"],
    linkFreelancer: json["link_freelancer"] == null ? null : json["link_freelancer"],
    nganhNghe: json["nganh_nghe"] == null ? null : json["nganh_nghe"],
    kyNang: json["ky_nang"] == null ? null : json["ky_nang"],
    diaChi: json["dia_chi"] == null ? null : json["dia_chi"],
    tbSaoDanhGia: json["tb_sao_danh_gia"] == null ? null : json["tb_sao_danh_gia"].toDouble(),
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "ten_freelancer": tenFreelancer == null ? null : tenFreelancer,
    "link_freelancer": linkFreelancer == null ? null : linkFreelancer,
    "nganh_nghe": nganhNghe == null ? null : nganhNghe,
    "ky_nang": kyNang == null ? null : kyNang,
    "dia_chi": diaChi == null ? null : diaChi,
    "tb_sao_danh_gia": tbSaoDanhGia == null ? null : tbSaoDanhGia,
  };
}
