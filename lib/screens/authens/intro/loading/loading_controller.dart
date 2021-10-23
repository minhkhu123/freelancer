import 'package:freelancer_app/common/constants.dart';
import 'package:freelancer_app/common/shared/data/http/result_data.dart';
import 'package:freelancer_app/common/shared/data/repositories/user_repositories.dart';
import 'package:freelancer_app/screens/authens/login/login_controller.dart';
import 'package:freelancer_app/screens/authens/wait_login/wait_login_screen_1.dart';
import 'package:freelancer_app/screens/navigation/navigation_controller.dart';
import 'package:freelancer_app/widgets/dialog_loading.dart';
import 'package:get/get.dart';
import 'package:sp_util/sp_util.dart';
import 'package:freelancer_app/routes/app_routes.dart';

class LoadingController extends GetxController {
  UserRepository _userRepository = UserRepository();
  // LoginController loginController = LoginController();
  // NavigationController navigationController = NavigationController();
  String token;
  RxBool checkIntro = false.obs;

  void checkIntroBool() {
    checkIntro.value;
    SpUtil.putBool(ConstString.CHECK_INTRO, checkIntro.value);
    update();
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    token = SpUtil.getString(ConstString.token);
    checkIntro.value = SpUtil.getBool(ConstString.CHECK_INTRO);
    nextScreen();
  }

  void nextScreen() async {
    // getUserProfileCheck();
    String user = SpUtil.getString(ConstString.Status_user);
    await new Future.delayed(const Duration(seconds: 2));
    checkIntro.value ? Get.toNamed(Routes.WAIT_LOGIN_1) : Get.toNamed(Routes.INTRO);
    // user == ''
    //     ? Get.toNamed(Routes.INTRO)
    //     : token == ''
    //     ? Get.toNamed(Routes.WAIT_LOGIN_1)
    //     : freelancerInfo();
    update();
  }

  // void freelancerInfo() async {
  //   await Future.delayed(Duration(milliseconds: 1));
  //   Get.dialog(DialogLoading());
  //   ResultData res = await _userRepository.freelancerInfo(token);
  //   if (res.result) {
  //     Get.back();
  //     SpUtil.putBool(ConstString.WHO_YOU_ARE, navigationController.wur);
  //     Get.toNamed(Routes.NAVIGATION);
  //   } else {
  //     Get.back();
  //     loginController.whoYouAre = true;
  //     Get.toNamed(Routes.LOGIN);
  //   }
  //   update();
  // }

  // void ntdInfo() async {
  //   await Future.delayed(Duration(milliseconds: 1));
  //   Get.dialog(DialogLoading());
  //   ResultData res = await _userRepository.ntdInfo(token);
  //   if (res.result) {
  //     Get.back();
  //     Get.toNamed(Routes.NAVIGATION);
  //   } else {
  //     Get.back();
  //     loginController.whoYouAre = false;
  //     Get.toNamed(Routes.LOGIN);
  //   }
  //   update();
  // }
}