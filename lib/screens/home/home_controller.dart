import 'dart:io';

import 'package:album_app/common/models/folder.dart';
import 'package:album_app/common/models/image.dart';
import 'package:album_app/constants/firebase.dart';
import 'package:album_app/routes/app_pages.dart';
import 'package:album_app/widges/dialog_loading.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
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
  String folderId = '';

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

  @override
  void onInit() async {
    searchFolderTextEditingController.addListener(() {});
    searchImageTextEditingController.addListener(() {});
    reloadDatabase();
    folderModel.refresh();
    super.onInit();
  }

  Stream<List<FolderModel>> getAllFolder() => firebaseFirestore
      .collection(collectionFolder)
      .snapshots()
      .map((query) => query.docs.map((item) => FolderModel.fromDocumentSnapshot(item)).toList());

  Stream<List<ImageModel>> getAllImage(String uid) => firebaseFirestore
      .collection(collectionFolder)
      .doc(uid)
      .collection(collectionImage)
      .orderBy("name")
      .snapshots()
      .map((query) => query.docs.map((item) => ImageModel.fromDocumentSnapshot(item)).toList());

  void logOut() async {
    // auth.signOut();
    Get.back();
    // Get.offNamed(Routes.LOGIN);
  }

  void getDataImage(String id) {
    imageModel.clear();
    imageModel.bindStream(getAllImage(id));
    update();
  }

  void reloadDatabase() async {
    await Future.delayed(Duration(milliseconds: 1));
    Get.dialog(DialogLoading());
    // String uid = 'V1uGJw5Sx4fArEqzBNrQ';
    folderModel.bindStream(getAllFolder());
    // imageModel.bindStream(getAllImage(id));
    Get.back();
    update();
  }

  void addFolder(String name, String id, String favorite) {
    firebaseFirestore.collection(collectionFolder).add({
      'name': name,
      'favorite': favorite,
    }).whenComplete(() {
      print(firebaseFirestore.collection(collectionFolder).id);
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

  void addImage(String folderId, String code, String price, bool liked) async {
    await Future.delayed(Duration(milliseconds: 1));
    Get.dialog(DialogLoading());
    var taskSnapshot = await firebase_storage.FirebaseStorage.instance.ref().child(imageIn.path.split('/').last).putFile(imageIn);
    final String downloadUrl = await taskSnapshot.ref.getDownloadURL();
    await firebaseFirestore
        .collection(collectionFolder)
        .doc(folderId)
        .collection(collectionImage)
        .add({'name': code, 'price': price, 'image': downloadUrl, 'liked': liked}).whenComplete(() {
      clearTextField();
      Get.back();
      Get.back();
      Get.snackbar('Thêm ảnh', 'Bạn đã thêm ảnh thành công');
    });
    update();
  }

  void deleteImage(String folderId, String id) {
    firebaseFirestore.collection(collectionFolder).doc(folderId).collection(collectionImage).doc(id).delete().whenComplete(() {
      Get.back();
      Get.snackbar('Xóa ảnh', 'Bạn đã xóa ảnh thành công');
    });
    update();
  }

  void clearTextField() {
    nameFolderTextEditingController.clear();
    folder.value = 0;
    codeTextEditingController.clear();
    moneyTextEditingController.clear();
    update();
  }
}
