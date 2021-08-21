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
  RxList<FolderModel> favoriteFolderModel = <FolderModel>[].obs;
  String collectionFolder = 'folder';
  RxList<ImageModel> imageModel = RxList<ImageModel>();
  String collectionImage = 'image';

  List<FolderModel> get favorites => favoriteFolderModel.value;

  List<FolderModel> get folders => folderModel.value;

  List<ImageModel> get images => imageModel.value;
  List<ImageModel> imagesSearch = [];
  List<FolderModel> foldersSearch = [];
  List<FolderModel> favoriteFolders = [];

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
  RxString folderId = ''.obs;
  RxString favoriteId = ''.obs;

  void checkFolderID() {
    folderId.value;
    update();
  }

  void checkNameFolder() {
    nameFolder.value;
    update();
  }

  void checkFolder() {
    folder.value;
    update();
  }

  void checkFavorite() {
    favoriteId.value;
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
    print(folderModel.length);
    super.onInit();
  }

  Stream<List<FolderModel>> getAllFolder() => firebaseFirestore
      .collection(collectionFolder)
      .where('dateCreated')
      .orderBy('noted', descending: true)
      .snapshots()
      .map((query) => query.docs.map((item) => FolderModel.fromDocumentSnapshot(item)).toList());

  Stream<List<ImageModel>> getAllImage(String uid) => firebaseFirestore
      .collection(collectionFolder)
      .doc(uid)
      .collection(collectionImage)
      .orderBy("dateCreated", descending: true)
      .snapshots()
      .map((query) => query.docs.map((item) => ImageModel.fromDocumentSnapshot(item)).toList());

  Stream<List<FolderModel>> getFavoriteFolders() => firebaseFirestore
      .collection(collectionFolder)
      .where('favorite', isEqualTo: '2')
      .snapshots()
      .map((query) => query.docs.map((item) => FolderModel.fromDocumentSnapshot(item)).toList());

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
    folderModel.bindStream(getAllFolder());
    getSearchListFolder();
    Get.back();
    update();
  }

  void addFolder(String name, String id, String favorite) {
    firebaseFirestore.collection(collectionFolder).add({
      'name': name,
      'favorite': favorite,
      'dateCreated': Timestamp.now(),
      'noted': 0,
    }).whenComplete(() {
      print(firebaseFirestore.collection(collectionFolder).id);
      clearTextField();
      foldersSearch.clear();
      foldersSearch.addAll(folders);
      Get.back();
      Get.snackbar('Thêm thư mục', 'Bạn đã thêm thư mục thành công');
    });
    update();
  }

  void deleteFolder(String id) {
    firebaseFirestore.collection(collectionFolder).doc(id).delete().whenComplete(() {
      foldersSearch.clear();
      foldersSearch.addAll(folders);
      update();
      Get.back();
      Get.snackbar('Xóa thư mục', 'Bạn đã xóa thư mục thành công');
    });
    update();
  }

  void updateFolder(String id, int noted) {
    firebaseFirestore.collection(collectionFolder).doc(id).update({
      'noted': noted,
    }).whenComplete(() {
      foldersSearch.clear();
      foldersSearch.addAll(folders);
      update();
      print('note thành công');
    });
    update();
  }

  void addImage(String folderId, String code, String price, bool liked) async {
    await Future.delayed(Duration(milliseconds: 1));
    Get.dialog(DialogLoading());
    var taskSnapshot = await firebase_storage.FirebaseStorage.instance.ref().child(imageIn.path.split('/').last).putFile(imageIn);
    final String downloadUrl = await taskSnapshot.ref.getDownloadURL();
    await firebaseFirestore.collection(collectionFolder).doc(folderId).collection(collectionImage).add({
      'name': code,
      'price': price,
      'image': downloadUrl,
      'liked': liked,
      'dateCreated': Timestamp.now(),
      'favoriteFolder': '',
      'favoriteId': '',
    }).whenComplete(() {
      clearTextField();
      imagesSearch.clear();
      imagesSearch.addAll(images);
      Get.back();
      Get.back();
      Get.snackbar('Thêm ảnh', 'Bạn đã thêm ảnh thành công');
    });
    update();
  }

  void deleteImage(String folderId, String id) {
    firebaseFirestore.collection(collectionFolder).doc(folderId).collection(collectionImage).doc(id).delete().whenComplete(() {
      imagesSearch.clear();
      imagesSearch.addAll(images);
      update();
      Get.back();
      Get.snackbar('Xóa ảnh', 'Bạn đã xóa ảnh thành công');
    });
    update();
  }

  Future<void> getSearchListImage() async {
    if (searchImage == '' || searchImage.isEmpty) {
      imagesSearch = [];
      imagesSearch.addAll(images);
    } else {
      imagesSearch = [];
      update();
      for (int i = 0; i < images.length; i++) {
        if (images.elementAt(i).name.toString().toLowerCase().contains(searchImage.toLowerCase())) {
          imagesSearch.add(images[i]);
        }
      }
    }
    update();
  }

  Future<void> getSearchListFolder() async {
    if (searchFolder == '' || searchFolder.isEmpty) {
      foldersSearch = [];
      foldersSearch.addAll(folders);
    } else {
      foldersSearch = [];
      update();
      for (int i = 0; i < folders.length; i++) {
        if (folders.elementAt(i).name.toString().toLowerCase().contains(searchFolder.toLowerCase())) {
          foldersSearch.add(folders[i]);
        }
      }
    }
    update();
  }

  void bindFavoriteFolder() {
    favoriteFolderModel.bindStream(getFavoriteFolders());
    update();
  }

  void addImageToFavorite(String folderID, String code, String price, String urlImage) async {
    await Future.delayed(Duration(milliseconds: 1));
    Get.dialog(DialogLoading());
    await firebaseFirestore.collection(collectionFolder).doc(folderID).collection(collectionImage).add({
      'name': code,
      'image': urlImage,
      'price': price,
      'liked': true,
      'dateCreated': Timestamp.now(),
    }).whenComplete(() {
      clearTextField();
      images.clear();
      imagesSearch.clear();
      getDataImage(folderId.value);
      favoriteId.value = '';
      Get.back();
      Get.back();
      Get.snackbar('Thêm ảnh yêu thích', 'Bạn đã thêm ảnh vào mục yêu thích thành công');
    });
    // update();
  }

  void updateImage(String folderId,String id, bool liked) {
    firebaseFirestore.collection(collectionFolder).doc(folderId).collection(collectionImage).doc(id).update({
      'liked': liked,
    }).whenComplete(() {
      imagesSearch.clear();
      imagesSearch.addAll(images);
      update();
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
