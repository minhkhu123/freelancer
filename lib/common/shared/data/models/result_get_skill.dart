import 'dart:convert';

ResultGetSkills resultGetSkillsFromJson(String str) =>
    ResultGetSkills.fromJson(json.decode(str));

String resultGetSkillsToJson(ResultGetSkills data) =>
    json.encode(data.toJson());

class ResultGetSkills {
  ResultGetSkills({
    this.data,
    this.error,
  });

  Data data;
  dynamic error;

  factory ResultGetSkills.fromJson(Map<String, dynamic> json) =>
      ResultGetSkills(
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
    this.listSkills,
  });

  bool result;
  List<ListSkill> listSkills;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        result: json["result"] == null ? null : json["result"],
        listSkills: json["list_skills"] == null
            ? null
            : List<ListSkill>.from(
                json["list_skills"].map((x) => ListSkill.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "result": result == null ? null : result,
        "list_skills": listSkills == null
            ? null
            : List<dynamic>.from(listSkills.map((x) => x.toJson())),
      };
}

class ListSkill {
  ListSkill({
    this.id,
    this.name,
  });

  String id;
  String name;

  factory ListSkill.fromJson(Map<String, dynamic> json) => ListSkill(
      id: json['id'] == null ? null : json['id'],
      name: json['name'] == null ? null : json['name']);

  Map<String, dynamic> toJson() =>
      {'id': id == null ? null : id, 'name': name == null ? null : name};
}
