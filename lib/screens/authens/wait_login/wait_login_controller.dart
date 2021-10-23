import 'package:freelancer_app/common/constants.dart';
import 'package:get/get.dart';
import 'package:sp_util/sp_util.dart';

class WaitLoginController extends GetxController {
  RxBool checkWhoUR = false.obs;
  RxBool checkLogin = false.obs;
  RxInt typeUser = 0.obs;

  void checkIsLogin() {
    checkLogin.value;
    SpUtil.putBool(ConstString.LOGIN_IN, checkLogin.value);
    update();
  }

  void checkWhoYouAre() {
    checkWhoUR.value;
    SpUtil.putBool(ConstString.WHO_YOU_ARE, checkWhoUR.value);
    update();
  }

  void clearToken() {
    SpUtil.remove(ConstString.token);
    update();
  }

  void checkTypeUser() {
    typeUser.value;
    update();
  }

  @override
  void onInit() {
    super.onInit();
    // checkIsLogin();
    // checkWhoYouAre();
  }
}
