import 'package:flutter/material.dart';
import 'package:get/get.dart';

class IntroController extends GetxController {
  RxInt indexPage = 0.obs;
  PageController pageController = PageController();
  final RxInt count = 3.obs;
  ValueNotifier currentPageNotifier = ValueNotifier<int>(0);
  RxBool isNextEnable = true.obs;

  @override
  void onInit() {
    super.onInit();
    indexPage.value;
    update();
  }
}
