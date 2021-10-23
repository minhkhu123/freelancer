import 'package:dio/dio.dart';
// import 'package:meeyteams/shared/common/constants.dart';
// import 'package:meeyteams/shared/local/local_storage.dart';

import '../api.dart';

class TokenInterceptors extends InterceptorsWrapper {
  String _accessToken;

  @override
  onRequest(RequestOptions options) async {
    if (_accessToken == null) {
      var authorizationCode = await getAuthorization();
      if (authorizationCode != null) {
        _accessToken = authorizationCode;
      }
    }
    options.headers["Authorization"] = _accessToken;
    options.headers["content-type"] = "application/x-www-form-urlencoded";
    return options;
  }

  @override
  onResponse(Response response) async {
    try {
      var responseJson = response.data;
      if (response.statusCode == 200 && responseJson["token"] != null) {
        _accessToken = responseJson["access_token"];
        // await LocalStorage.saveString(PrefKey.ACCESS_TOKEN, _accessToken);
        // await LocalStorage.saveString(PrefKey.TOKEN, responseJson['token']);
        httpManager.getAuthorization();
      }
    } catch (e) {
      print(e);
    }
    return response;
  }

  clearAuthorization() {
    this._accessToken = null;
    // LocalStorage.remove(PrefKey.ACCESS_TOKEN);
//    releaseClient();
  }

  getAuthorization() async {
      // String token = await LocalStorage.getString(PrefKey.ACCESS_TOKEN);
      // return token;
  }
}
