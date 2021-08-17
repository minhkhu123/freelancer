import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RegisterController extends GetxController {

  RxBool isPassword = false.obs;
  RxBool isConfirmPassword = false.obs;

  TextEditingController emailTextEditingController = TextEditingController();

  String get email => emailTextEditingController.text;

  TextEditingController passwordTextEditingController = TextEditingController();

  String get password => passwordTextEditingController.text;

  TextEditingController confirmPasswordTextEditingController = TextEditingController();

  String get confirmPassword => confirmPasswordTextEditingController.text;

  void changeShow() {
    isPassword.value = !isPassword.value;
    update();
  }

  void changeConfirmShow() {
    isConfirmPassword.value = !isConfirmPassword.value;
    update();
  }

  @override
  void onInit() {
    emailTextEditingController.addListener(() {});
    passwordTextEditingController.addListener(() {});
    confirmPasswordTextEditingController.addListener(() {});
    super.onInit();
  }
}