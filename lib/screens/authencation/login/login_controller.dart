import 'package:album_app/common/models/folder.dart';
import 'package:album_app/common/models/user.dart';
import 'package:album_app/constants/firebase.dart';
import 'package:album_app/routes/app_pages.dart';
import 'package:album_app/widges/dialog_loading.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  Rx<User> firebaseUser;
  String usersCollection = 'users';
  Rx<UserModel> userModel = UserModel().obs;
  String collectionFolder = 'folder';
  RxList<FolderModel> folderModel = <FolderModel>[].obs;

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
  void onReady() {
    firebaseUser = Rx<User>(auth.currentUser);
    firebaseUser.bindStream(auth.userChanges());
    super.onReady();
  }

  @override
  void onInit() {
    emailTextEditingController.addListener(() {});
    passwordTextEditingController.addListener(() {});
    super.onInit();
  }

  Stream<List<FolderModel>> getAllFolder() =>
      firebaseFirestore.collection(collectionFolder).snapshots().map((query) => query.docs.map((item) => FolderModel.fromMap(item)).toList());

  void login() async {
    await Future.delayed(Duration(milliseconds: 1));
    Get.dialog(DialogLoading());
    try {
      await auth.signInWithEmailAndPassword(email: email.trim(), password: password.trim()).then((result) {
        String userId = result.user.uid;
        initializedUserModel(userId);
        folderModel.bindStream(getAllFolder());
        Get.back();
        clearTextField();
        Get.toNamed(Routes.HOME);
        // Get.offNamed(Routes.HOME);
      });
    } catch(e) {
      debugPrint(e.toString());
      Get.back();
      Get.snackbar('Đăng nhập không thành công', 'Xin vui lòng thử lại!');
    }
    update();
  }

  initializedUserModel(String userId) async {
    userModel.value = await firebaseFirestore.collection(usersCollection).doc(userId).get().then((doc) => UserModel.fromSnapshot(doc));
  }

  clearTextField() {
    emailTextEditingController.clear();
    passwordTextEditingController.clear();
  }
}