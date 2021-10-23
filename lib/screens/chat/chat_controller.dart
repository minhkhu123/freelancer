import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChatController extends GetxController {
  RxBool isChat = false.obs;
  RxBool isLiked = false.obs;
  FocusNode focusNode = FocusNode();

  void checkIsLiked() {
    isLiked.value = !isLiked.value;
    update();
  }

  void checkIsChat() {
    isChat.value = !isChat.value;
    print(isChat.value);
    update();
  }

  @override
  void onInit() {
    super.onInit();
    checkIsLiked();
    focusNode.addListener(() {
      checkIsChat();
    });
  }
}
