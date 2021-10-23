import 'dart:convert';

class ResultData {
  var data;
  bool result;
  int code;
  var headers;
  Error error;

  ResultData(this.data, this.result, this.code, {this.headers}){
    if (this.data.toString().contains("error")){
      setError(this.data.toString());
    }
  }
  
  void setError(String strResponse){
    try {
      var res = json.decode(strResponse);
      this.error = res["error"] == null ? null : Error.fromJson(res["error"]);
    } catch (e){
      Error error = new Error(code: 404, messages: e.toString());
      this.error = error;
    }
  }
}

class Error {
  Error({
    this.code,
    this.messages,
  });

  int code;
  String messages;

  factory Error.fromJson(Map<String, dynamic> json) => Error(
    code: json["code"] == null ? null : json["code"],
    messages: json["messages"] == null ? null : json["messages"],
  );

  Map<String, dynamic> toJson() => {
    "code": code == null ? null : code,
    "messages": messages == null ? null : messages,
  };
}

