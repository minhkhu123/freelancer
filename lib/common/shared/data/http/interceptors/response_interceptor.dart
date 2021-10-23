import 'package:dio/dio.dart';

import '../code.dart';
import '../result_data.dart';


class ResponseInterceptors extends InterceptorsWrapper {
  @override
  onResponse(Response response) async {
    RequestOptions options = response.request;
    var value;
    // try {
    //   var header = response.headers;
    //   if (header != null && header.toString().contains("text")) {
    //     value = new ResultData(response.data, true, Code.SUCCESS);
    //   } else if (response.statusCode >= 200 && response.statusCode <= 300) {
    //     value = new ResultData(response.data, true, Code.SUCCESS,
    //         headers: response.headers);
    //   }
    // } catch (e) {
    //   print(e.toString() + options.path);
    //   value = new ResultData(response.data, false, response.statusCode,
    //       headers: response.headers);
    // }
    return value;
  }
}
