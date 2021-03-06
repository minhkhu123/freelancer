import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/svg.dart';
import 'package:freelancer_app/common/constants.dart';
import 'package:freelancer_app/common/images.dart';
import 'package:freelancer_app/common/shared/data/http/address.dart';
import 'package:freelancer_app/common/shared/data/http/result_data.dart';
import 'package:freelancer_app/common/shared/data/models/result_get_infor_uv.dart';
import 'package:freelancer_app/common/shared/data/models/result_get_tag_from_category.dart';
import 'package:freelancer_app/common/shared/data/models/result_notification.dart';
import 'package:freelancer_app/common/shared/data/repositories/user_repositories.dart';
import 'package:freelancer_app/common/utils_data.dart';
import 'package:freelancer_app/models/drop_list_model.dart';
import 'package:freelancer_app/models/field_model.dart';
import 'package:freelancer_app/screens/authens/ongoing_project/ongoing_project_controller.dart';
import 'package:freelancer_app/screens/navigation/navigation_controller.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:sp_util/sp_util.dart';

class CompleteYourProfileController extends GetxController {
  NavigationController navigationController = Get.put(NavigationController());
  var _format = NumberFormat("#,###");

  OnGoingProjectController _onGoingProjectController = Get.put(OnGoingProjectController());

  UserRepository _userRepository = UserRepository();

  TextEditingController luongCoDinh = TextEditingController(text: '0');
  TextEditingController luongULBD = TextEditingController(text: '0');
  TextEditingController luongULKT = TextEditingController(text: '0');
  TextEditingController ngheNghiep = TextEditingController();
  TextEditingController textEditingControllerName = TextEditingController();
  TextEditingController nameProject = TextEditingController();

  bool isEstimatesOrPermanent = true;
  int idSkill = 0;
  List<ListTag> listSelectSkill = [];
  UserInfor userInfo = UserInfor(pathAvt: '', avatar: '');
  List<String> category = [];
  List<String> skill = [];
  RxString textError = ''.obs;
  RxString textErrorCD = ''.obs;
  List<FieldModel> listField = [
    //Kh???i t???o 1 ph???n t??? ????? ko b??? l???i
    FieldModel(id: 0, name: '', img: SvgPicture.asset(Images.ic_remove)),
  ];
  RxList _listProjectFile = [].obs;
  String messageDate = '';
  String exp = '';
  String intro = '';
  Rx<File> _file = File('').obs;

  RxList get listProjectFile => _listProjectFile;

  File get file => _file.value;
  RxInt currentIndex = 0.obs;

  DropListModel listModelWorkForm = DropListModel(listItem: [
    OptionItem(id: 1, title: "To??n th???i gian c??? ?????nh"),
    OptionItem(id: 2, title: "To??n th???i gian t???m th???i"),
    OptionItem(id: 3, title: "B??n th???i gian"),
    OptionItem(id: 4, title: "B??n th???i gian t???m th???i"),
    OptionItem(id: 5, title: "H???p ?????ng"),
    OptionItem(id: 6, title: "Kh??c"),
  ]);
  OptionItem optionItemWorkForm = OptionItem(id: null, title: "Ch???n h??nh th???c");

  DropListModel listModelBy = DropListModel(listItem: [
    OptionItem(id: 1, title: 'Ng??y'),
    OptionItem(id: 2, title: 'Tu???n'),
    OptionItem(id: 3, title: 'Th??ng'),
    OptionItem(id: 4, title: 'N??m')
  ]);

  OptionItem optionSelectedBy = OptionItem(id: 1, title: 'Ng??y');

  DropListModel listExp = DropListModel(listItem: [
    OptionItem(id: 0, title: 'Ch??a c?? kinh nghi???m'),
    OptionItem(id: 1, title: 'D?????i 1 n??m'),
    OptionItem(id: 2, title: '1 n??m'),
    OptionItem(id: 3, title: '2 n??m'),
    OptionItem(id: 4, title: '3 n??m'),
    OptionItem(id: 5, title: '4 n??m'),
    OptionItem(id: 6, title: '5 n??m'),
    OptionItem(id: 7, title: 'Tr??n 5 n??m'),
  ]);

  DropListModel listModelRecruitment = DropListModel(listItem: []);
  OptionItem optionItemRecruitment = OptionItem(id: null, title: "Ch???n l??nh v???c");

  DropListModel listModelCity = DropListModel(listItem: []);
  OptionItem optionSelectedCity = OptionItem(id: null, title: "Ch???n n??i l??m vi???c");

  List<ListTag> codeLanguage = [];

  @override
  void onInit() async {
    super.onInit();
    luongULBD.addListener(() {
      onChangeFormat(luongULBD.text, luongULBD);
      onValidateSalary();
      update();
    });
    luongULKT.addListener(() {
      onChangeFormat(luongULKT.text, luongULKT);
      onValidateSalary();
      update();
    });
    luongCoDinh.addListener(() {
      onChangeFormat(luongCoDinh.text, luongCoDinh);
      onValidateSalary();
      update();
    });
    textEditingControllerName.addListener(() {});
    ngheNghiep.addListener(() {});
    nameProject.addListener(() {});

    userInfo = await UtilsData.userInfo();
    _listProjectFile.addAll(await getListProjectFile());
    category.addAll(userInfo.linhVucLamViec.split(','));
    skill.addAll(userInfo.kyNang.split(','));
    selectSkill(idSkill);
    listSelectSkill.addAll(_getSelectSkill(userInfo.kyNang));
    listField = (await UtilsData.getCategory())
        .map((e) => FieldModel(id: int.parse(e.maLinhVuc), name: e.tenLinhVuc, img: SvgPicture.network(e.pathIcon)))
        .toList();
    listModelRecruitment.listItem.addAll(listField.map((e) => OptionItem(id: e.id, title: e.name)).toList());
    listModelCity = await UtilsData.getCity();
    setUp();
  }

  // @override
  // void onClose() {
  //   super.onClose();
  //   luongCoDinh.dispose();
  //   luongULKT.dispose();
  //   luongULBD.dispose();
  //   textEditingControllerName.dispose();
  // }

  void setUp() async {
    userInfo = await UtilsData.userInfo();
    ngheNghiep.text = userInfo.ngheNghiep;
    textEditingControllerName.text = userInfo.ten;
    print('textEditingControllerName.text');
    print(textEditingControllerName.text);
    print('userInfo.ten');
    print(userInfo.ten);
    exp = listExp.listItem[int.parse(userInfo.kinhNghiem)].title;
    intro = userInfo.gioiThieu;
    messageDate = userInfo.ngaySinh;
    List<ListTag> listTag = (await UtilsData.getTagFromCategory(1)).listItem.map((e) => ListTag(id: e.id.toString(), name: e.title)).toList();
    codeLanguage.addAll(listTag);
    if (userInfo.cvMongMuon.isNotEmpty) {
      listModelRecruitment.listItem.forEach((element) {
        if (element.id == int.parse(userInfo.cvMongMuon)) optionItemRecruitment = OptionItem(id: element.id, title: element.title);
      });
    }
    listModelWorkForm.listItem.forEach((element) {
      if (element.id == int.parse(userInfo.hinhThucLamViec)) optionItemWorkForm = OptionItem(id: element.id, title: element.title);
    });
    listModelCity.listItem.forEach((element) {
      if (element.id == int.parse(userInfo.noiLamViecMongMuon)) optionSelectedCity = OptionItem(id: element.id, title: element.title);
    });
    List<String> luong = userInfo.mucLuong.split(',');
    String luongCD = userInfo.mucLuong;
    if (userInfo.loaiLuong == '2') {
      luongULBD.text = _format.format(int.parse(luong[0]));
      luongULKT.text = _format.format(int.parse(luong[1]));
    } else if (userInfo.loaiLuong == '1') {
      luongCoDinh.text = _format.format(int.parse(luongCD));
    }
    update();
  }

  void selectSkill(int id) async {
    idSkill = id;
    codeLanguage.clear();
    List<ListTag> listTag = [];
    listTag = (await UtilsData.getTagFromCategory(listField[id].id)).listItem.map((e) => ListTag(id: e.id.toString(), name: e.title)).toList();
    codeLanguage.addAll(listTag);
    update();
  }

  void onChangeCkeckBox(bool value, ListTag e) {
    if (value) {
      listSelectSkill.add(e);
      skill.add(e.id);
    } else {
      listSelectSkill.remove(e);
      skill.remove(e.id);
    }
    update();
  }

  List<ListTag> _getSelectSkill(String kyNang) {
    List<ListTag> skill = [];
    if (kyNang.isEmpty) return [];
    kyNang.split(',').forEach((element) {
      for (ListTag i in _onGoingProjectController.listSkills.map((e) => ListTag(id: e.id, name: e.name)).toList()) {
        if (i.id == element) {
          skill.add(i);
        }
      }
    });
    return skill;
  }

  void updateSkill({@required String token, @required String category, @required String skills}) async {
    ResultData rest = await _userRepository.updateSkillFreelancer(token: token, category: category, skills: skills);
    if (rest.result) {
      ResultNotification resultNotification = resultNotificationFromJson(rest.data);
      String notification;
      if (resultNotification.data.result) {
        notification = resultNotification.data.message;
      } else {
        notification = resultNotification.error.message;
      }
      Get.snackbar("Message", notification);
    } else {
      if (rest.code != 200) print("L???i");
    }
  }

  void updateJobDesired(
      {@required String token, String job, int desiredJob, int type, int desiredCity, int salaryType, String salary, int salaryDepend}) async {
    ResultData rest = await _userRepository.updateJobDesired(
        token: token,
        job: job,
        desiredJob: desiredJob,
        type: type,
        desiredCity: desiredCity,
        salaryType: salaryType,
        salary: salary,
        salaryDepend: salaryDepend);
    if (rest.result) {
      ResultNotification resultNotification = resultNotificationFromJson(rest.data);
      String notification;
      if (resultNotification.data.result) {
        notification = resultNotification.data.message;
      } else {
        notification = resultNotification.error.message;
      }
      Get.snackbar("Message", notification);
    } else {
      if (rest.code != 200) print('L???i');
    }
  }

  void onChangePermanentOrEstimate() {
    this.isEstimatesOrPermanent = !this.isEstimatesOrPermanent;
    update();
  }

  void onChangeDropdown(OptionItem e) {
    optionSelectedBy = e;
    update();
  }

  bool onValidateSalary() {
    if (isEstimatesOrPermanent) {
      if (int.parse(luongCoDinh.text.replaceAll(',', '')) < 0) {
        textErrorCD.value = 'M???c l????ng kh??ng ???????c ????? ??m';
        return true;
      }
    } else {
      if (int.parse(luongULBD.text.replaceAll(',', '')) > int.parse(luongULKT.text.replaceAll(',', ''))) {
        textError.value = 'M???c l????ng b???t ?????u ph???i nh??? h??n m???c l????ng k???t th??c';
        return true;
      } else if (int.parse(luongULBD.text.replaceAll(',', '')) < 0 || int.parse(luongULKT.text.replaceAll(',', '')) < 0) {
        textError.value = 'M???c l????ng kh??ng ???????c ????? ??m';
        return true;
      }
    }
    textErrorCD.value = '';
    textError.value = '';
    update();
    return false;
  }

  void onChangeFormat(String str, TextEditingController ctrl) {
    String text = _format.format(int.tryParse(str.replaceAll(',', '')) ?? 0);
    ctrl.value = TextEditingValue(
      text: text,
      selection: TextSelection.collapsed(offset: text.length),
    );
  }

  String selectNameCategory() {
    List<String> item = [];
    category.forEach((element) {
      item.add(listField[int.parse(element)].name);
    });
    return item.join(' v?? ');
  }

  Future<List<ProjectFile>> getListProjectFile() async {
    ResultData rest = await UtilsData.authenticationRepositories.getOnlyToken(Address.FREELANCER_INFOR, token: SpUtil.getString(ConstString.token));
    if (rest.result) {
      ResultGetInforFreelancer freelancer = ResultGetInforFreelancer.fromRawJson(rest.data);
      if (freelancer.data.result) return freelancer.data.projectFile;
    } else {
      if (rest.code != 200) print('L???i');
    }
    return [];
  }

  upLoadFile() async {
    final file = await FilePicker.platform.pickFiles();
    if (file != null) this._file.value = File(file.paths[0]);
  }

  updateProjectFile() async {
    if(nameProject.text.isNotEmpty){
      if(UtilsData.checkFileSize(file) > 25) {
        Get.snackbar('Message', 'K??ch th?????c t???p t???i ??a: 25 MB');
        return;
      }
      ResultData rest = await UtilsData.companyRepositories.updateFileProject(
        token: SpUtil.getString(ConstString.token),
        projectName: nameProject.text,
        projectFile: _file.value,
      );
      if(rest.result){
        ResultNotification resultNotification = resultNotificationFromJson(rest.data);
        String noti;
        if(resultNotification.data.result) {
          noti = resultNotification.data.message;
          _listProjectFile.clear();
          nameProject.clear();
          _file.value = File('');
          _listProjectFile.addAll(await getListProjectFile());
        }
        else noti = resultNotification.error.message;
        Get.snackbar('Message', noti);
      }else{
        if(rest.code != 200) print('L???i');
      }
    }else{
      Get.snackbar('Message', 'B???n c???n ph???i nh???p t??n d??? ??n');
    }
  }
}
