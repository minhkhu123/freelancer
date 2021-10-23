import 'package:flutter/cupertino.dart';
import 'package:freelancer_app/common/constants.dart';
import 'package:freelancer_app/common/shared/data/http/result_data.dart';
import 'package:freelancer_app/common/shared/data/models/result_notification.dart';
import 'package:freelancer_app/common/shared/data/repositories/company_repositories.dart';
import 'package:freelancer_app/common/utils.dart';
import 'package:get/get.dart';
import 'package:sp_util/sp_util.dart';

class ChangePasswordController extends GetxController {
  CompanyRepositories _companyRepositories = CompanyRepositories();
  bool isEyeMKHT = true;
  bool isEyeMKNew = true;
  bool isEyeMKNewRP = true;
  String errorPWHT;
  String errorPWNew;
  String errorPWRP;
  RxBool checkOldPass = false.obs;

  TextEditingController passwordHTTextController = TextEditingController();

  String get passwordHT => passwordHTTextController.text;

  TextEditingController passwordNewTextController = TextEditingController();

  String get passwordNew => passwordNewTextController.text;

  TextEditingController passwordRPTextController = TextEditingController();

  String get passwordRP => passwordRPTextController.text;

  void changEyePasswordHT() {
    isEyeMKHT = !isEyeMKHT;
    update();
  }

  void changEyePasswordNew() {
    isEyeMKNew = !isEyeMKNew;
    update();
  }

  void changEyePasswordRP() {
    isEyeMKNewRP = !isEyeMKNewRP;
    update();
  }

  String validationOldPassword(String text) {
    if (checkOldPass.value && text.isNotEmpty) {
      return errorPWHT;
    }
    return null;
  }

  String validationPassword(String text) {
    if (!RegExp(r'^(?=.*?[a-z])(?=.*?[0-9]).{8,}$').hasMatch(text) && text.isNotEmpty) {
      return 'Mật khẩu sai định dạng';
    } else if (RegExp(r'[.,!@#\$&*~^%()+x=/_€£¥₩÷ ]').hasMatch(text) && text.isNotEmpty) {
      return 'Mật khẩu không được có ký tự đặc biệt';
    }
    return null;
  }

  String validatePWMatch(String text) {
    if (text != passwordRP) return "Mật khẩu bạn nhập cần khớp với mật khẩu mới";
    return null;
  }

  void showOldPass() {
    checkOldPass.value;
    update();
  }

  @override
  void onInit() {
    super.onInit();
    changEyePasswordHT();
    changEyePasswordNew();
    changEyePasswordRP();
    passwordRPTextController.addListener(() {
      errorPWRP = validationPassword(passwordRP);
      if (errorPWNew == null) {
        errorPWRP = validatePWMatch(passwordNew);
      }
      update();
    });
    passwordHTTextController.addListener(() {
      // errorPWHT = validationOldPassword(passwordHT);
      // errorPWHT;
      update();
    });
    passwordNewTextController.addListener(() {
      errorPWNew = validationPassword(passwordNew);

      errorPWRP = validatePWMatch(passwordNew);

      update();
    });
  }

  void checkOldPassNTD() async {
    String token = SpUtil.getString(ConstString.token);
    ResultData res = await _companyRepositories.checkOldPassNTD(token, passwordHT);
    ResultNotification resultNotification = resultNotificationFromJson(res.data);
    if (resultNotification.data.result) {
      checkOldPass.value = false;
      showOldPass();
    } else {
      SpUtil.putString(ConstString.Error_old_pass, resultNotification.error.message);
      errorPWHT = SpUtil.getString(ConstString.Error_old_pass);
      checkOldPass.value = true;
      showOldPass();
    }
    update();
  }

  void changPw(String url, {@required String token, String oldPW, String newPW}) async {
    if (RegExp(r'^(?=.*?[a-z])(?=.*?[0-9]).{8,}$').hasMatch(passwordNew) && !RegExp(r'[.,!@#\$&*~^%()+x=/_€£¥₩÷ ]').hasMatch(passwordNew)) {
      if (passwordHT.isNotEmpty && passwordNew.isNotEmpty && passwordRP.isNotEmpty) {
        ResultData rest = await _companyRepositories.changePW(url, token: token, oldPW: oldPW, newPW: newPW);
        if (rest.result) {
          ResultNotification resultNotification = resultNotificationFromJson(rest.data);
          String notification;
          if (resultNotification.data.result) {
            notification = resultNotification.data.message;
            passwordHTTextController.clear();
            passwordNewTextController.clear();
            passwordRPTextController.clear();
            Get.back();
            Utils.showToast(resultNotification.data.message);
          } else {
            notification = resultNotification.error.message;
            errorPWHT = resultNotification.error.message;
            update();
          }
          Get.snackbar("Message", notification);
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
      } else {
        if (passwordHT.isEmpty) errorPWHT = "Bạn chưa nhập mật khẩu hiện tại";
        if (passwordNew.isEmpty) errorPWNew = "Bạn chưa nhập mật khẩu mới";
        if (passwordRP.isEmpty) errorPWRP = "Bạn chưa nhập lại mật khẩu";
        Utils.showToast('Bạn chưa nhập thông tin');
        update();
      }
    } else {
      if (passwordHT.isEmpty) errorPWHT = "Bạn chưa nhập mật khẩu hiện tại";
      if (passwordNew.isEmpty) errorPWNew = "Bạn chưa nhập mật khẩu mới";
      if (passwordRP.isEmpty) errorPWRP = "Bạn chưa nhập lại mật khẩu";
      Utils.showToast('Mật khẩu phải có từ 8 ký tự trở lên cần ít nhất 1 chữ và 1 số, không được có dấu cách');
    }
    update();
  }
}
