import 'package:dio/dio.dart';

import '../code.dart';
import '../result_data.dart';

class ErrorInterceptors extends InterceptorsWrapper {
  final Dio _dio;

  ErrorInterceptors(this._dio);

  @override
  onRequest(RequestOptions options) async {
    // var connectivityResult = await (new Connectivity().checkConnectivity());
    // if (connectivityResult == ConnectivityResult.none) {
    //   return _dio.resolve(new ResultData(
    //       Code.errorHandleFunction(Code.NETWORK_ERROR, "", false),
    //       false,
    //       Code.NETWORK_ERROR));
    // }
    return options;
  }
}
