import 'dart:convert';

import 'package:dio/dio.dart';

class LogsInterceptors extends InterceptorsWrapper {
  static List<Map> sHttpResponses = [];
  static List<String> sResponsesHttpUrl = [];

  static List<Map<String, dynamic>> sHttpRequest = [];
  static List<String> sRequestHttpUrl = [];

  static List<Map<String, dynamic>> sHttpError = [];

  static List<String> sHttpErrorUrl = [];

  @override
  onRequest(RequestOptions options) async {
    print(
        "URL: ${options.path} \nMethod: ${options.method} \nheader: ${options.headers} \nbody/query: ${options.data}");
    try {
      addLogic(sRequestHttpUrl, options.path ?? "");
      var data;
      if (data is Map) {
        data = options.data;
      } else {
        data = Map<String, dynamic>();
      }
      var map = {
        "header": {...options.headers},
      };
      if (options.method == "POST") {
        map["data"] = options.data;
      }
      addLogic(sHttpRequest, data);
    } catch (e) {
      print(e);
    }

    return options;
  }

  @override
  onResponse(Response response) async {
    if (response != null) {
      print('Response: ${response.request.path}\n' + response.toString());
    }

    if (response.data is Map || response.data is List) {
      try {
        var data = Map<String, dynamic>();
        data["data"] = response.data;
        addLogic(sResponsesHttpUrl, response?.request?.uri?.toString() ?? "");
        addLogic(sHttpResponses, data);
      } catch (e) {
        print(e);
      }
    } else if (response.data is String) {
      try {
        var data = Map<String, dynamic>();
        data["data"] = response.data;
        addLogic(sResponsesHttpUrl, response?.request?.uri.toString() ?? "");
        addLogic(sHttpResponses, data);
      } catch (e) {
        print(e);
      }
    } else if (response.data != null) {
      try {
        String data = response.data.toJson();
        addLogic(sResponsesHttpUrl, response?.request?.uri.toString() ?? "");
        addLogic(sHttpResponses, json.decode(data));
      } catch (e) {
        print(e);
      }
    }
    return response; // continue
  }

  @override
  onError(DioError err) async {
    print('Error: ' + err.toString());
    print('Error response: ' + (err.response?.toString() ?? ""));

    try {
      addLogic(sHttpErrorUrl, err.request.path ?? "null");
      var errors = Map<String, dynamic>();
      errors["error"] = err.message;
      addLogic(sHttpError, errors);
    } catch (e) {
      print(e);
    }
    return err; // continue;
  }

  static addLogic(List list, data) {
    if (list.length > 20) {
      list.removeAt(0);
    }
    list.add(data);
  }
}
