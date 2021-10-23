import 'dart:convert';

ResultGetProjectFreelancerIsDoing resultGetProjectFreelancerIsDoingFromJson(
        String str) =>
    ResultGetProjectFreelancerIsDoing.fromJson(json.decode(str));

String resultGetProjectFreelancerIsDoingToJson(
        ResultGetProjectFreelancerIsDoing data) =>
    json.encode(data.toJson());

class ResultGetProjectFreelancerIsDoing {
  ResultGetProjectFreelancerIsDoing({this.data, this.error});

  Data data;
  Error error;

  factory ResultGetProjectFreelancerIsDoing.fromJson(
          Map<String, dynamic> json) =>
      ResultGetProjectFreelancerIsDoing(
          data: json["data"] == null ? null : Data.fromJson(json["data"]),
          error: json['error'] == null ? null : Error.fromJson(json['error']));

  Map<String, dynamic> toJson() => {
        "data": data == null ? null : data.toJson(),
        'error': error == null ? null : error.toJson()
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
    this.listJob,
  });

  bool result;
  List<ListJob> listJob;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        result: json["result"] == null ? null : json["result"],
        listJob: json["list_job"] == null
            ? null
            : List<ListJob>.from(
                json["list_job"].map((x) => ListJob.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "result": result == null ? null : result,
        "list_job": listJob == null
            ? null
            : List<dynamic>.from(listJob.map((x) => x.toJson())),
      };
}

class ListJob {
  ListJob({
    this.id,
    this.name,
    this.kinhPhi,
    this.ngayHetHan,
    this.trangThai,
    this.danhGia,
  });
  String id;
  String name;
  String kinhPhi;
  String ngayHetHan;
  String trangThai;
  int danhGia;

  factory ListJob.fromJson(Map<String, dynamic> json) => ListJob(
        id: json['id'],
        name: json["name"] == null ? null : json["name"],
        kinhPhi: json["kinh_phi"] == null ? null : json["kinh_phi"],
        ngayHetHan: json["ngay_het_han"] == null ? null : json["ngay_het_han"],
        trangThai: json["trang_thai"] == null ? null : json["trang_thai"],
        danhGia: json["danh_gia"] == null ? null : json["danh_gia"],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        "name": name == null ? null : name,
        "kinh_phi": kinhPhi == null ? null : kinhPhi,
        "ngay_het_han": ngayHetHan == null ? null : ngayHetHan,
        "trang_thai": trangThai == null ? null : trangThai,
        "danh_gia": danhGia == null ? null : danhGia,
      };
}
