import 'package:flutter/material.dart';
import 'package:freelancer_app/common/constants.dart';
import 'package:freelancer_app/common/shared/data/http/result_data.dart';
import 'package:freelancer_app/common/shared/data/models/result_forgot_password_ntd.dart';
import 'package:freelancer_app/common/shared/data/models/result_notification.dart';
import 'package:freelancer_app/common/shared/data/repositories/authen_repositories.dart';
import 'package:freelancer_app/common/utils.dart';
import 'package:freelancer_app/screens/authens/forgot_password/update_pass_screen.dart';
import 'package:freelancer_app/screens/authens/forgot_password/update_pass_success_screen.dart';
import 'package:get/get.dart';
import 'package:sp_util/sp_util.dart';

import 'otp_forgot_password_screen.dart';

class ForgotPasswordController extends GetxController {
  AuthenticationRepositories _authenticationRepositories = AuthenticationRepositories();

  RxBool isNewPassword = false.obs;
  RxBool isConfirmNewPassword = false.obs;

  RxBool checkUpdatePass = false.obs;

  TextEditingController emailTextEditingController = TextEditingController();

  String get email => emailTextEditingController.text;

  TextEditingController otpTextEditingController = TextEditingController();

  String get otp => otpTextEditingController.text;

  TextEditingController newPassTextEditingController = TextEditingController();

  String get newPass => newPassTextEditingController.text;

  TextEditingController confirmPassTextEditingController = TextEditingController();

  String get confirmPass => confirmPassTextEditingController.text;

  void changeShow() {
    isNewPassword.value = !isNewPassword.value;
    update();
  }

  void changeShowConfirm() {
    isConfirmNewPassword.value = !isConfirmNewPassword.value;
    update();
  }

  String checkValidPassword() {
    if (!RegExp(r'^(?=.*?[a-z])(?=.*?[0-9]).{8,}$').hasMatch(newPass) && newPass.isNotEmpty) {
      return 'Mật khẩu sai định dạng';
    } else if (newPass == "" && checkUpdatePass.value) {
      return 'Bạn chưa nhập mật khẩu';
    } else if (RegExp(r'[.,!@#\$&*~^%()+x=/_€£¥₩÷ ]').hasMatch(newPass) && newPass.isNotEmpty) {
      return 'Mật khẩu không được có ký tự đặc biệt';
    }
    return null;
  }

  String checkValidConfirmPassword() {
    if (confirmPassTextEditingController.text != newPassTextEditingController.text && confirmPassTextEditingController.text.isNotEmpty) {
      return 'Mật khẩu này không đúng với mật khẩu đã nhập';
    } else if (confirmPass == "" && checkUpdatePass.value) {
      return 'Bạn chưa nhập mật khẩu';
    } else if (RegExp(r'[.,!@#\$&*~^%()+x=/_€£¥₩÷]').hasMatch(confirmPass) && checkUpdatePass.value) {
      return 'Mật khẩu không được có ký tự đặc biệt';
    }
    return null;
  }

  @override
  void onInit() {
    super.onInit();

    emailTextEditingController.addListener(() {});
    otpTextEditingController.addListener(() {});
    newPassTextEditingController.addListener(() {});
    confirmPassTextEditingController.addListener(() {});
  }

  void forgotPasswordNTD() async {
    ResultData res = await _authenticationRepositories.forgotPasswordNTD(email);
    ResultForgotPasswordNtd resultForgotPasswordNtd = resultForgotPasswordNtdFromJson(res.data);
    if (resultForgotPasswordNtd.data.result == true) {
      SpUtil.putString(ConstString.token, resultForgotPasswordNtd.data.accessToken);
      Get.to(OTPForgotPasswordScreen());
    } else {
      emailTextEditingController.clear();
      Utils.showToast(resultForgotPasswordNtd.error.message);
    }
    update();
  }

  void confirmOTPForgotPasswordNTD() async {
    String token = SpUtil.getString(ConstString.token);
    ResultData res = await _authenticationRepositories.confirmOTPForgotPasswordNTD(token, otp);
    ResultNotification resultNotification = resultNotificationFromJson(res.data);
    if (resultNotification.data.result == true) {
      Utils.showToast(resultNotification.data.message);
      Get.to(UpdatePassScreen());
    } else {
      otpTextEditingController.clear();
      Utils.showToast(resultNotification.error.message);
    }
    update();
  }

  void updatePasswordNTD() async {
    String token = SpUtil.getString(ConstString.token);
    if (RegExp(r'^(?=.*?[a-z])(?=.*?[0-9]).{8,}$').hasMatch(newPass) && !RegExp(r'[.,!@#\$&*~^%()+x=/_€£¥₩÷ ]').hasMatch(newPass)) {
      ResultData res = await _authenticationRepositories.updatePasswordNTD(token, newPass);
      ResultNotification resultNotification = resultNotificationFromJson(res.data);
      if (resultNotification.data.result) {
        Utils.showToast(resultNotification.data.message);
        checkUpdatePass.value = false;
        Get.to(UpdatePassSuccessScreen());
      } else {
        checkUpdatePass.value = true;
        newPassTextEditingController.clear();
        confirmPassTextEditingController.clear();
        Utils.showToast(resultNotification.error.message);
      }
    } else {
      Utils.showToast('Mật khẩu mới cần trên 8 ký tự, ít nhất 1 chữ và 1 số');
    }
    update();
  }

  void forgotPasswordUV() async {
    ResultData res = await _authenticationRepositories.forgotPasswordUV(email);
    ResultForgotPasswordNtd resultForgotPasswordNtd = resultForgotPasswordNtdFromJson(res.data);
    if (resultForgotPasswordNtd.data.result == true) {
      SpUtil.putString(ConstString.token, resultForgotPasswordNtd.data.accessToken);
      Get.to(OTPForgotPasswordScreen());
    } else {
      emailTextEditingController.clear();
      Utils.showToast(resultForgotPasswordNtd.error.message);
    }
    update();
  }

  void confirmOTPForgotPasswordUV() async {
    String token = SpUtil.getString(ConstString.token);
    ResultData res = await _authenticationRepositories.confirmOTPForgotPasswordUV(token, otp);
    ResultNotification resultNotification = resultNotificationFromJson(res.data);
    if (resultNotification.data != null) {
      Utils.showToast(resultNotification.data.message);
      Get.to(UpdatePassScreen());
    } else {
      otpTextEditingController.clear();
      Utils.showToast(resultNotification.error.message);
    }
    update();
  }

  void updatePasswordUV() async {
    String token = SpUtil.getString(ConstString.token);
    if (RegExp(r'^(?=.*?[a-z])(?=.*?[0-9]).{8,}$').hasMatch(newPass)) {
      ResultData res = await _authenticationRepositories.updatePasswordUV(token, newPass);
      ResultNotification resultNotification = resultNotificationFromJson(res.data);
      if (resultNotification.data.result) {
        Utils.showToast(resultNotification.data.message);
        checkUpdatePass.value = false;
        Get.to(UpdatePassSuccessScreen());
      } else {
        checkUpdatePass.value = true;
        newPassTextEditingController.clear();
        confirmPassTextEditingController.clear();
        Utils.showToast(resultNotification.error.message);
      }
    } else {
      Utils.showToast('Mật khẩu mới cần trên 8 ký tự, ít nhất 1 chữ và 1 số');
    }
    update();
  }
}
