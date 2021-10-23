import 'package:flutter/material.dart';
import 'package:freelancer_app/screens/authens/register/register_controller.dart';
import 'package:freelancer_app/screens/home/home_controller.dart';
import 'package:freelancer_app/screens/menu/menu_controller.dart';
import 'package:get/get.dart';

import 'navigation/navigation_controller.dart';

class InitialBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => NavigationController(), fenix: true);
    Get.lazyPut(() => HomeController(), fenix: true);
    Get.lazyPut(() => MenuController(), fenix: true);
    Get.lazyPut(() => RegisterController(), fenix: true);
  }
}