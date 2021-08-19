import 'dart:io';

import 'package:album_app/common/models/folder.dart';
import 'package:album_app/common/models/image.dart';
import 'package:album_app/constants/firebase.dart';
import 'package:album_app/routes/app_pages.dart';
import 'package:album_app/widges/dialog_loading.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class HomeController extends GetxController {
  RxList<FolderModel> folderModel = <FolderModel>[].obs;
  String collectionFolder = 'folder';
  RxList<ImageModel> imageModel = RxList<ImageModel>();
  String collectionImage = 'image';
  List<ImageModel> get images => imageModel.value;

  TextEditingController searchFolderTextEditingController = TextEditingController();

  String get searchFolder => searchFolderTextEditingController.text;

  TextEditingController searchImageTextEditingController = TextEditingController();

  String get searchImage => searchImageTextEditingController.text;

  TextEditingController codeTextEditingController = TextEditingController();

  String get code => codeTextEditingController.text;

  TextEditingController moneyTextEditingController = TextEditingController();

  String get money => moneyTextEditingController.text;

  TextEditingController nameFolderTextEditingController = TextEditingController();

  String get nameFolderList => nameFolderTextEditingController.text;

  RxInt folder = 0.obs;
  File imageIn;
  List<XFile> imageFileList;
  RxString nameFolder = ''.obs;

  void checkNameFolder() {
    nameFolder.value;
    update();
  }

  void checkFolder() {
    folder.value;
    update();
  }

  final ImagePicker _picker = ImagePicker();

  Future imgFromCamera() async {
    final image = await _picker.pickImage(source: ImageSource.camera);

    imageIn = File(image.path);
    update();
  }

  Future imgFromGallery() async {
    final XFile image = await _picker.pickImage(source: ImageSource.gallery);

    imageIn = File(image.path);
    update();
  }

  Future imgMultiFromGallery() async {
    final images = await _picker.pickMultiImage();

    imageFileList = images;
    update();
  }

  // @override
  // void onReady() {
  //   super.onReady();
  //   folderModel.bindStream(getAllFolder());
  // }

  @override
  void onInit() async {
    searchFolderTextEditingController.addListener(() {});
    searchImageTextEditingController.addListener(() {});
    reloadDatabase();
    // print('folderModel.bindStream(getAllFolder())');
    // folderModel.bindStream(getAllFolder());
    folderModel.refresh();
    print(folderModel.length);
    super.onInit();
  }

  Stream<List<FolderModel>> getAllFolder() =>
      firebaseFirestore.collection(collectionFolder).snapshots().map((query) => query.docs.map((item) => FolderModel.fromMap(item)).toList());

  // Stream<List<ImageModel>> getAllImage() => firebaseFirestore.collection(collectionImage).snapshots().map

  void logOut() async {
    auth.signOut();
    Get.back();
    // Get.offNamed(Routes.LOGIN);
  }

  void reloadDatabase() async {
    await Future.delayed(Duration(milliseconds: 1));
    Get.dialog(DialogLoading());
    folderModel.bindStream(getAllFolder());
    Get.back();
    update();
  }

  void addFolder(String name, String id, String favorite) {
    firebaseFirestore.collection(collectionFolder).add({'name': name, 'favorite': favorite}).whenComplete(() {
      clearTextField();
      Get.back();
      Get.snackbar('Thêm thư mục', 'Bạn đã thêm thư mục thành công');
    });
    update();
  }

  void deleteFolder(String id) {
    firebaseFirestore.collection(collectionFolder).doc(id).delete().whenComplete(() {
      Get.back();
      Get.snackbar('Xóa thư mục', 'Bạn đã xóa thư mục thành công');
    });
    update();
  }

  void clearTextField() {
    nameFolderTextEditingController.clear();
    folder.value = 0;
    update();
  }
}
