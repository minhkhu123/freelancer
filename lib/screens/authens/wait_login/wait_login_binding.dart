import 'package:get/get.dart';

import 'wait_login_controller.dart';

class WaitLoginBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => WaitLoginController());
  }
}