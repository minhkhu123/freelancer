import 'package:flutter/cupertino.dart';
import 'package:freelancer_app/common/constants.dart';
import 'package:freelancer_app/common/shared/data/http/result_data.dart';
import 'package:freelancer_app/common/shared/data/models/result_get_posted_new.dart';
import 'package:freelancer_app/common/shared/data/repositories/company_repositories.dart';
import 'package:get/get.dart';
import 'package:sp_util/sp_util.dart';

class MessagePostedController extends GetxController {
  CompanyRepositories _companyRepositories = CompanyRepositories();

  List listPostedNew = [];
  RxString messageError = ''.obs;
  RxInt countLoadTime = 1.obs;

  @override
  void onInit() {
    super.onInit();

    getPostNews(token: SpUtil.getString(ConstString.token));
  }

  void getPostNews({@required String token, int xemThem = 1}) async {
    ResultData rest =
        await _companyRepositories.getPostedNew(token: token, xemThem: xemThem);
    if (rest.result) {
      ResultGetPostedNews resultGetPostedNews =
          resultGetPostedNewsFromJson(rest.data);
      if (resultGetPostedNews.data.result == false &&
          resultGetPostedNews.error.code == 200) {
        messageError.value = resultGetPostedNews.error.message;
      } else if (resultGetPostedNews.data.result) {
        listPostedNew.addAll(resultGetPostedNews.data.listPosted);
      }
    } else {
      if (rest.code == 404)
        print("Lỗi 404");
      else if (rest.code == 401)
        print("Lỗi 401");
      else if (rest.code == 500)
        print("Lỗi 500");
      else if (rest.code == 505)
        print("Lỗi 404");
      else
        print("Lỗi");
    }
    update();
  }
}
