import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {

  RxBool isPassword = false.obs;

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
    emailTextEditingController.addListener(() {});
    passwordTextEditingController.addListener(() {});
    super.onInit();
  }
}