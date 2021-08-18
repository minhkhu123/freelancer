import 'dart:io';

import 'package:album_app/common/models/folder.dart';
import 'package:album_app/constants/firebase.dart';
import 'package:album_app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class HomeController extends GetxController {
  RxList<FolderModel> folderModel = RxList<FolderModel>([]);
  String collectionFolder = 'folder';

  TextEditingController searchFolderTextEditingController = TextEditingController();

  String get searchFolder => searchFolderTextEditingController.text;

  TextEditingController searchImageTextEditingController = TextEditingController();

  String get searchImage => searchImageTextEditingController.text;

  TextEditingController codeTextEditingController = TextEditingController();

  String get code => codeTextEditingController.text;

  TextEditingController moneyTextEditingController = TextEditingController();

  String get money => moneyTextEditingController.text;

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
    // reloadDatabase();
    folderModel.bindStream(getAllFolder());
    print(folderModel.length);
    super.onInit();
  }

  Stream<List<FolderModel>> getAllFolder() =>
      firebaseFirestore.collection(collectionFolder).snapshots().map((query) => query.docs.map((item) => FolderModel.fromMap(item.data())).toList());

  void logOut() async {
    auth.signOut();
    Get.offNamed(Routes.LOGIN);
  }

  void reloadDatabase() {
    folderModel.bindStream(getAllFolder());
    update();
  }
}
