import 'package:flutter/material.dart';
import 'package:freelancer_app/common/constants.dart';
import 'package:freelancer_app/common/shared/data/http/result_data.dart';
import 'package:freelancer_app/common/shared/data/models/result_login_cadidate.dart';
import 'package:freelancer_app/common/shared/data/models/result_login_company.dart';
import 'package:freelancer_app/common/shared/data/repositories/authen_repositories.dart';
import 'package:freelancer_app/common/utils.dart';
import 'package:freelancer_app/routes/app_routes.dart';
import 'package:freelancer_app/screens/authens/register/otp_screen.dart';
import 'package:freelancer_app/screens/authens/wait_login/wait_login_controller.dart';
import 'package:freelancer_app/screens/home/home_screen.dart';
import 'package:freelancer_app/screens/navigation/navigation_controller.dart';
import 'package:freelancer_app/screens/navigation/navigation_screen.dart';
import 'package:freelancer_app/widgets/dialog_loading.dart';
import 'package:get/get.dart';
import 'package:sp_util/sp_util.dart';

class LoginController extends GetxController {
  AuthenticationRepositories _authenticationRepositories = AuthenticationRepositories();

  WaitLoginController _waitLoginController = Get.put(WaitLoginController());
  NavigationController navigationController = Get.put(NavigationController());

  RxBool isPassword = false.obs;
  bool whoYouAre;
  RxBool checkLogin = false.obs;

  TextEditingController emailTextEditingController = TextEditingController();

  String get email => emailTextEditingController.text;

  TextEditingController passwordTextEditingController = TextEditingController();

  String get password => passwordTextEditingController.text;

  void changeShow() {
    isPassword.value = !isPassword.value;
    update();
  }

  @override
  void onInit() {
    super.onInit();
    whoYouAre = SpUtil.getBool(ConstString.WHO_YOU_ARE);
    print(SpUtil.getBool(ConstString.WHO_YOU_ARE));
    emailTextEditingController.addListener(() {});
    passwordTextEditingController.addListener(() {});
  }

  void checkLog() {
    checkLogin.value;
    update();
  }

  String checkValidEmail() {
    if (email.length < 6 && !email.contains('@') && !email.contains('.') && email.isNotEmpty) {
      return 'Email bạn nhập không hợp lệ';
    } else if (email == "" && checkLogin.value) {
      return 'Bạn chưa nhập Email';
    }
    return null;
  }

  String checkValidPassword() {
    if (password.length < 6 && password.isNotEmpty) {
      return 'Mật khẩu phải từ 6 ký tự trở lên';
    } else if (password == "" && checkLogin.value) {
      return 'Bạn chưa nhập mật khẩu';
    } else if (RegExp(r'[.,!@#\$&*~^%()+x=/_€£¥₩÷ ]').hasMatch(password) && checkLogin.value) {
      return 'Mật khẩu không được có ký tự đặc biệt';
    }
    return null;
  }

  void loginCandidate() async {
    await Future.delayed(Duration(milliseconds: 1));
    Get.dialog(DialogLoading());
    ResultData res = await _authenticationRepositories.loginCandidate(email, password);
    ResultLoginCandidate resultLoginCandidate = resultLoginCandidateFromJson(res.data);
    if (resultLoginCandidate.data.result) {
      SpUtil.putString(ConstString.token, resultLoginCandidate.data.accessToken);
      SpUtil.putString(ConstString.EMAIL, resultLoginCandidate.data.userInfo.epEmail);
      SpUtil.putString(ConstString.ID_USER, resultLoginCandidate.data.userInfo.epId);
      SpUtil.putString(ConstString.PHONE_NUMBER, resultLoginCandidate.data.userInfo.epPhone);
      SpUtil.putString(ConstString.Status_user, '1');
      _waitLoginController.checkLogin.value = true;
      _waitLoginController.checkIsLogin();
      // whoYouAre ? _waitLoginController.checkWhoUR.value = true : _waitLoginController.checkWhoUR.value = false;
      _waitLoginController.checkWhoUR.value = true;
      _waitLoginController.checkWhoYouAre();
      checkLogin.value = false;
      Get.back();
      navigationController.currentPage.value = HomeScreen();
      navigationController.listJobProjectHome.clear();
      navigationController.listJobPartimeHome.clear();
      navigationController.setUpFreelancer();
      Get.to(NavigationScreen());
      // navigationController.loginIn = true;
      // navigationController.update();
      // Get.offAllNamed(Routes.NAVIGATION);
    } else {
      if (resultLoginCandidate.error != null) {
        checkLogin.value = true;
        Get.back();
        Utils.showToast(resultLoginCandidate.error.message);
      } else {
        SpUtil.putString(ConstString.token_register, resultLoginCandidate.data.token);
        checkLogin.value = true;
        Get.back();
        Utils.showToast(resultLoginCandidate.data.message);
        Get.to(OTPScreen());
      }
    }
    update();
  }

  void loginCompany() async {
    await Future.delayed(Duration(milliseconds: 1));
    Get.dialog(DialogLoading());
    ResultData res = await _authenticationRepositories.loginCompany(email, password);
    ResultLoginCompany resultLoginCompany = resultLoginCompanyFromJson(res.data);
    if (resultLoginCompany.data.result) {
      SpUtil.putString(ConstString.token, resultLoginCompany.data.accessToken);
      SpUtil.putString(ConstString.EMAIL, resultLoginCompany.data.userInfo.epEmail);
      SpUtil.putString(ConstString.ID_USER, resultLoginCompany.data.userInfo.epId);
      SpUtil.putString(ConstString.PHONE_NUMBER, resultLoginCompany.data.userInfo.epPhone);
      SpUtil.putString(ConstString.AVATAR, resultLoginCompany.data.userInfo.epLogo);
      SpUtil.putString(ConstString.Status_user, '1');
      _waitLoginController.checkLogin.value = true;
      _waitLoginController.checkIsLogin();
      // whoYouAre ? _waitLoginController.checkWhoUR.value = true : _waitLoginController.checkWhoUR.value = false;
      _waitLoginController.checkWhoUR.value = false;
      _waitLoginController.checkWhoYouAre();
      checkLogin.value = false;
      Get.back();
      navigationController.currentPage.value = HomeScreen();
      navigationController.listFreelancerLatestHome.clear();
      navigationController.listFreelancerOutstandingHome.clear();
      navigationController.setUpNTD();
      Get.to(NavigationScreen());
      // Get.offAllNamed(Routes.NAVIGATION);
    } else {
      if (resultLoginCompany.error != null) {
        checkLogin.value = true;
        Get.back();
        Utils.showToast(resultLoginCompany.error.message);
      } else {
        SpUtil.putString(ConstString.token_register, resultLoginCompany.data.token);
        checkLogin.value = true;
        Get.back();
        Utils.showToast(resultLoginCompany.data.message);
        Get.to(OTPScreen());
      }
    }
    update();
  }
}
