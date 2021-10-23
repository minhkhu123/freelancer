import 'dart:io';

import 'package:flutter/material.dart';
import 'package:freelancer_app/common/shared/data/http/result_data.dart';
import 'package:freelancer_app/common/shared/data/models/result_get_district.dart';
import 'package:freelancer_app/common/shared/data/models/result_get_infor_ntd.dart';
import 'package:freelancer_app/common/shared/data/models/result_get_infor_uv.dart';
import 'package:freelancer_app/common/shared/data/models/result_notification.dart';
import 'package:freelancer_app/common/utils.dart';
import 'package:freelancer_app/common/utils_data.dart';
import 'package:freelancer_app/models/drop_list_model.dart';
import 'package:freelancer_app/routes/app_routes.dart';
import 'package:freelancer_app/screens/authens/update_profile_ntd/update_profile_ntd_screen.dart';
import 'package:freelancer_app/screens/candidate/commplete_your_profile/complete_your_profile_controller.dart';
import 'package:freelancer_app/screens/candidate/commplete_your_profile/complete_your_profile_screen.dart';
import 'package:freelancer_app/widgets/dialog_selection_image.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

class UpdateProfileNTDController extends GetxController {
  final bool checkWhoUR;

  UpdateProfileNTDController({this.checkWhoUR});

  CompleteYourProfileController completeYourProfileController = Get.put(CompleteYourProfileController());
  final _format = DateFormat('dd-MM-yyyy');
  DropListModel dropListModelCity = DropListModel(listItem: []);
  OptionItem optionItemSelectedCity = OptionItem(id: null, title: "Chọn tỉnh/thành phố");

  DropListModel dropListModelDistrict = DropListModel(listItem: []);
  OptionItem optionItemSelectedDistrict = OptionItem(id: null, title: "Chọn quận/huyện");

  DropListModel dropListModelSex =
      DropListModel(listItem: [OptionItem(id: 1, title: "Nam"), OptionItem(id: 2, title: "Nữ"), OptionItem(id: 3, title: 'Khác')]);
  OptionItem optionItemSexSelected = OptionItem(id: null, title: "Chọn giới tính");

  EmployerInfor employerInfor;
  UserInfor userInfor = UserInfor();

  DateTime valueDate = DateTime.now();
  TextEditingController textEditingControllerName = TextEditingController();
  TextEditingController textEditingControllerSDT = TextEditingController();
  TextEditingController textEditingControllerEmail = TextEditingController();

  Rx<File> _imgAvatar = File('').obs;
  Rx<File> _img = File('').obs;
  Rx<String> _pathOldImage = ''.obs;
  bool updateImage = false;
  String messageDate = "Chọn ngày sinh";
  String notification = '';
  RxInt currentIndex = 0.obs;
  RxList<FocusNode> _isFocus = [FocusNode(), FocusNode(), FocusNode()].obs;
  RxList<bool> _error = [false, false, false].obs;

  File get imgAvatar => _imgAvatar.value;

  File get img => _img.value;

  RxList<FocusNode> get isFocus => _isFocus;

  RxList<bool> get error => _error;

  Future selectDate(context) async {
    final date = await showDatePicker(context: context, initialDate: valueDate, firstDate: DateTime(1950), lastDate: DateTime(valueDate.year + 2));
    if (date != null && date != valueDate) {
      valueDate = date;
      messageDate = _format.format(date);
    }
    update();
  }

  Future getImgFromGallery() async {
    final img = await ImagePicker().getImage(source: ImageSource.gallery);
    _img.value = File(img.path);
  }

  Future getImageFromCamera() async {
    final img = await ImagePicker().getImage(source: ImageSource.camera);
    _img.value = File(img.path);
  }

  void onUpdateImage() async {
    _imgAvatar.value = (UtilsData.checkFileSize(_img.value) > 2) ? await UtilsData.compressionFile(_img.value) : _img.value;
    Get.back();
  }

  void onCancel() {
    Get.back();
  }

  @override
  void onInit() async {
    super.onInit();
    textEditingControllerEmail.addListener(() {});
    textEditingControllerName.addListener(() {});
    textEditingControllerSDT.addListener(() {});
    dropListModelCity = await UtilsData.getCity();
    print(dropListModelCity.listItem.length);
    setValueForUpdate();
  }

  Future<void> getDistrict({@required int idCity}) async {
    ResultData rest = await UtilsData.authenticationRepositories.getListDistrict(idCity);
    if (rest.result) {
      ResultGetDistrict resultGetDistrict = resultGetDistrictFromJson(rest.data);
      if (resultGetDistrict.data.result) {
        dropListModelDistrict.listItem.clear();
        for (int i = 0; i < resultGetDistrict.data.listDistrict.length; i++) {
          dropListModelDistrict.listItem
              .add(OptionItem(id: int.parse(resultGetDistrict.data.listDistrict[i].id), title: resultGetDistrict.data.listDistrict[i].name));
        }
        update();
      }
    } else {
      if (rest.code != 200) print("Lỗi");
    }
  }

  void selectedCity(OptionItem item) {
    optionItemSelectedCity = item;

    int indexCity = item.id ?? 0;
    optionItemSelectedDistrict = OptionItem(id: null, title: "Chọn quận/huyện");
    getDistrict(idCity: indexCity);
    update();
  }

  void selectedDistrict(OptionItem item) {
    optionItemSelectedDistrict = item;
    update();
  }

  void selectedSex(OptionItem item) {
    optionItemSexSelected = item;
    update();
  }

  void updateProfile(String url, {String token}) async {
    if (textEditingControllerName.text.isNotEmpty &&
        textEditingControllerSDT.text.isNotEmpty &&
        textEditingControllerEmail.text.isNotEmpty &&
        !messageDate.contains('Chọn') &&
        optionItemSexSelected.id != null &&
        optionItemSelectedCity.id != null &&
        optionItemSelectedDistrict.id != null) {
      _error[0] = false;
      _error[1] = false;
      _error[2] = false;
      ResultData rest = await UtilsData.authenticationRepositories.updateProfile(url, _pathOldImage.value,
          token: token,
          avatar: _imgAvatar.value,
          birthDay: messageDate,
          district: optionItemSelectedDistrict.id,
          fullName: textEditingControllerName.text,
          provin: optionItemSelectedCity.id,
          sex: optionItemSexSelected.id);
      ResultNotification resultNotification = resultNotificationFromJson(rest.data);
      if (resultNotification.data.result) {
        notification = resultNotification.data.message;
        completeYourProfileController.setUp();
        Get.back();
        // setValueForUpdate();
        //setValueForUpdate();
      } else {
        notification = resultNotification.error.message;
      }
      // if(checkWhoUR) await Utils.popLastScreen(popCount: 2, toScreen: CompleteYourProfileScreen());
      Get.snackbar("Message", notification);
    } else {
      Get.snackbar("Message", "Mời bạn nhập đầy đủ thông tin");
      if (textEditingControllerName.text.isEmpty) {
        _isFocus[0].requestFocus();
        _error[0] = true;
      }
      if (textEditingControllerSDT.text.isEmpty) {
        _isFocus[1].requestFocus();
        _error[1] = true;
      }
      if (textEditingControllerEmail.text.isEmpty) {
        _isFocus[2].requestFocus();
        _error[2] = true;
      }
    }
    update();
  }

  void setValueForUpdate() async {
    if (checkWhoUR) {
      userInfor = await UtilsData.userInfo();
      await getDistrict(idCity: int.parse(userInfor.tinhThanh));
      String titleDistrict = dropListModelDistrict.listItem.where((element) => element.id == int.parse(userInfor.quanHuyen)).first.title;
      _imgAvatar.value = File(userInfor.pathAvt + '/' + userInfor.avatar);
      _pathOldImage.value = _imgAvatar.value.path;
      textEditingControllerName.text = userInfor.ten;
      // valueDate = DateTime.parse(userInfor.ngaySinh);
      messageDate = userInfor.ngaySinh;
      optionItemSexSelected = OptionItem(id: int.parse(userInfor.gioiTinh), title: userInfor.gioiTinh == '1' ? 'Nam' : 'Nữ');
      textEditingControllerSDT.text = userInfor.sdt;
      textEditingControllerEmail.text = userInfor.email;
      optionItemSelectedCity = OptionItem(id: int.parse(userInfor.tinhThanh), title: userInfor.tinhThanhTxt);
      optionItemSelectedDistrict = OptionItem(id: int.parse(userInfor.quanHuyen), title: titleDistrict);
    } else {
      employerInfor = await UtilsData.employerInfor();
      OptionItem titleCity = dropListModelCity.listItem.where((element) => element.id == int.parse(employerInfor.provin)).first;
      await getDistrict(idCity: titleCity.id);

      String titleDistrict = dropListModelDistrict.listItem.where((element) => element.id == int.parse(employerInfor.district)).toList().first.title;
      //  String linkAvata
      _imgAvatar.value = File(employerInfor.linkAvatar + '/' + employerInfor.avatar);
      _pathOldImage.value = _imgAvatar.value.path;
      textEditingControllerName.text = employerInfor.name;

      valueDate = DateTime.fromMillisecondsSinceEpoch(int.parse(employerInfor.birthday) * 1000);
      messageDate = _format.format(valueDate);
      optionItemSexSelected = OptionItem(id: int.parse(employerInfor.sex), title: employerInfor.sex == '1' ? 'Nam' : 'Nữ');
      textEditingControllerSDT.text = employerInfor.tel;
      textEditingControllerEmail.text = employerInfor.email;
      optionItemSelectedCity = OptionItem(id: int.parse(employerInfor.provin), title: titleCity.title);
      optionItemSelectedDistrict = OptionItem(id: int.parse(employerInfor.district), title: titleDistrict);
    }
    update();
  }

  showDialogImage() {
    _img.value = _imgAvatar.value;
    Get.dialog(DialogSelectionImage());
  }

  checkImg() {
    if (_img.value.path.isEmpty || _img.value == _imgAvatar.value) return;
    onUpdateImage();
  }
}
