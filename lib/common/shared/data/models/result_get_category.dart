
import 'dart:convert';

ResultGetCategory resultGetCategoryFromJson(String str) => ResultGetCategory.fromJson(json.decode(str));
String resultGetCategoryToJson(ResultGetCategory data) => json.encode(data.toJson());

class ResultGetCategory {
  ResultGetCategory({
    this.data,
    this.error,
  });

  Data data;
  dynamic error;

  factory ResultGetCategory.fromJson(Map<String, dynamic> json) => ResultGetCategory(
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
    this.listCategory,
  });

  bool result;
  List<ListCategory> listCategory;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    result: json["result"] == null ? null : json["result"],
    listCategory: json['list_category'] == null? null: List<ListCategory>.from(json['list_category'].map((e) => ListCategory.fromJson(e)))
  );

  Map<String, dynamic> toJson() => {
    "result": result == null ? null : result,
    'list_category': listCategory == null? null : List<ListCategory>.from(listCategory.map((e) => e.toJson()))
  };
}

class ListCategory {
  ListCategory({
    this.maLinhVuc,
    this.tenLinhVuc,
    this.icon,
    this.pathIcon,
  });

  String maLinhVuc;
  String tenLinhVuc;
  String icon;
  String pathIcon;

  factory ListCategory.fromJson(Map<String, dynamic> json) => ListCategory(
    maLinhVuc: json["ma_linh_vuc"] == null ? null : json["ma_linh_vuc"],
    tenLinhVuc: json["ten_linh_vuc"] == null ? null : json["ten_linh_vuc"],
    icon: json["icon"] == null ? null : json["icon"],
    pathIcon: json["path_icon"] == null ? null : json["path_icon"],
  );

  Map<String, dynamic> toJson() => {
    "ma_linh_vuc": maLinhVuc == null ? null : maLinhVuc,
    "ten_linh_vuc": tenLinhVuc == null ? null : tenLinhVuc,
    "icon": icon == null ? null : icon,
    "path_icon": pathIcon == null ? null : pathIcon,
  };
}
